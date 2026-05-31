import 'dart:convert';
import 'dart:io';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../util/family_access.dart';

class AiEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  // ── Config ────────────────────────────────────────────────────────────────

  /// Returns true if an OpenRouter API key is stored in the DB.
  Future<bool> isConfigured(Session session) async {
    await requireUserId(session);
    final key = await _readKey(session);
    return key != null && key.isNotEmpty;
  }

  /// Returns current config (key masked, model visible). Admin use only.
  Future<String> getAiConfig(Session session) async {
    await requireUserId(session);
    final rows = await session.db.unsafeQuery(
      'SELECT "openRouterApiKey", "defaultModel" FROM "ai_config" LIMIT 1',
    );
    if (rows.isEmpty) {
      return jsonEncode({'hasKey': false, 'defaultModel': 'google/gemini-2.5-flash-preview'});
    }
    final row = rows.first;
    final key = row[0] as String? ?? '';
    final model = row[1] as String? ?? 'google/gemini-2.5-flash-preview';
    return jsonEncode({
      'hasKey': key.isNotEmpty,
      'keyPreview': key.isNotEmpty ? '${key.substring(0, key.length.clamp(0, 8))}••••••••' : '',
      'defaultModel': model,
    });
  }

  /// Saves OpenRouter API key and default model. Admin use only.
  Future<bool> saveAiConfig(
    Session session,
    String openRouterApiKey,
    String defaultModel,
  ) async {
    await requireUserId(session);
    final trimmedKey = openRouterApiKey.trim();
    final trimmedModel = defaultModel.trim();
    if (trimmedModel.isEmpty) {
      throw FamyliaException(message: 'Modello non valido.');
    }
    final keyToSave = trimmedKey.isEmpty
        ? ((await _readKey(session)) ?? '')
        : _sanitizeApiKey(trimmedKey);
    if (keyToSave.isEmpty) {
      throw FamyliaException(message: 'API key OpenRouter richiesta.');
    }
    await session.db.unsafeExecute(
      '''
      INSERT INTO "ai_config" ("openRouterApiKey", "defaultModel", "updatedAt")
      VALUES (\$1, \$2, now())
      ON CONFLICT DO NOTHING
      ''',
      parameters: QueryParameters.positional([keyToSave, trimmedModel]),
    );
    // If row already exists, update it
    await session.db.unsafeExecute(
      'UPDATE "ai_config" SET "openRouterApiKey" = \$1, "defaultModel" = \$2, "updatedAt" = now()',
      parameters: QueryParameters.positional([keyToSave, trimmedModel]),
    );
    return true;
  }

  /// Elenco modelli OpenRouter con supporto vision (input immagine).
  /// Valida la chiave API. Passa chiave vuota per usare quella salvata.
  Future<String> listVisionModels(
    Session session,
    String openRouterApiKey,
  ) async {
    await requireUserId(session);
    var apiKey = openRouterApiKey.trim();
    if (apiKey.isEmpty) {
      apiKey = (await _readKey(session)) ?? '';
    }
    if (apiKey.isEmpty) {
      throw FamyliaException(
        message: 'Inserisci una API key OpenRouter da verificare.',
      );
    }

    final models = await _fetchVisionModels(_sanitizeApiKey(apiKey));
    return jsonEncode({'models': models});
  }

  // ── Extraction ────────────────────────────────────────────────────────────

  /// Extracts a family activity from text and/or images.
  ///
  /// [payload] is a JSON string with:
  ///   - text: String? — raw text (email body, clipboard, etc.)
  ///   - base64Images: List<String>? — base64-encoded images or PDFs
  ///   - mimeTypes: List<String>? — MIME types for each image
  ///   - model: String? — model override for this call
  ///
  /// Returns a JSON string with the extraction result.
  Future<String> extractActivity(
    Session session,
    int familyId,
    String payload,
  ) async {
    await requireFamilyMemberNotGuest(session, familyId);

    final apiKey = await _readKey(session);
    if (apiKey == null || apiKey.isEmpty) {
      throw FamyliaException(
        message: 'OpenRouter API key non configurata. Impostala nella schermata Admin AI.',
      );
    }

    final Map<String, dynamic> data;
    try {
      data = jsonDecode(payload) as Map<String, dynamic>;
    } catch (_) {
      throw FamyliaException(message: 'Payload non valido.');
    }

    final text = data['text'] as String?;
    final base64Images = (data['base64Images'] as List?)?.cast<String>();
    final mimeTypes = (data['mimeTypes'] as List?)?.cast<String>();
    final modelOverride = data['model'] as String?;

    if ((text == null || text.trim().isEmpty) &&
        (base64Images == null || base64Images.isEmpty)) {
      throw FamyliaException(message: 'Fornisci almeno un testo o un\'immagine.');
    }

    final model = modelOverride?.isNotEmpty == true
        ? modelOverride!
        : await _readModel(session);

    return _callOpenRouter(
      _sanitizeApiKey(apiKey),
      model.trim(),
      text,
      base64Images,
      mimeTypes,
    );
  }

  // ── Private helpers ───────────────────────────────────────────────────────

  /// Rimuove caratteri non ammessi negli header HTTP (es. newline nella API key).
  String _sanitizeApiKey(String key) {
    return key
        .replaceAll(RegExp(r'[\x00-\x1F\x7F]'), '')
        .trim();
  }

  void _setOpenRouterHeaders(HttpClientRequest request, String apiKey) {
    request.headers.set(
      HttpHeaders.authorizationHeader,
      'Bearer ${_sanitizeApiKey(apiKey)}',
    );
    request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
    request.headers.set(HttpHeaders.refererHeader, 'https://famylia.app');
    request.headers.set('x-title', 'Famylia');
  }

  Future<String?> _readKey(Session session) async {
    final rows = await session.db.unsafeQuery(
      'SELECT "openRouterApiKey" FROM "ai_config" LIMIT 1',
    );
    if (rows.isEmpty) return null;
    final raw = rows.first[0] as String?;
    if (raw == null || raw.isEmpty) return null;
    return _sanitizeApiKey(raw);
  }

  Future<List<Map<String, dynamic>>> _fetchVisionModels(String apiKey) async {
    final client = HttpClient();
    try {
      final request = await client.getUrl(
        Uri.parse('https://openrouter.ai/api/v1/models'),
      );
      _setOpenRouterHeaders(request, apiKey);

      final response = await request.close();
      final body = await response.transform(utf8.decoder).join();

      if (response.statusCode == 401 || response.statusCode == 403) {
        throw FamyliaException(message: 'API key OpenRouter non valida.');
      }
      if (response.statusCode != 200) {
        throw FamyliaException(
          message: 'OpenRouter error ${response.statusCode}: $body',
        );
      }

      final json = jsonDecode(body) as Map<String, dynamic>;
      final data = json['data'] as List? ?? [];
      final models = <Map<String, dynamic>>[];

      for (final item in data) {
        if (item is! Map) continue;
        final id = item['id'] as String?;
        if (id == null || id.isEmpty) continue;
        if (!_modelSupportsVision(item)) continue;

        final name = item['name'] as String? ?? id;
        final isFree = _isModelFree(item, id);
        models.add({'id': id, 'name': name, 'isFree': isFree});
      }

      models.sort((a, b) {
        final aFree = a['isFree'] as bool? ?? false;
        final bFree = b['isFree'] as bool? ?? false;
        if (aFree != bFree) return aFree ? -1 : 1;
        return (a['name'] as String).compareTo(b['name'] as String);
      });
      if (models.isEmpty) {
        throw FamyliaException(
          message: 'Nessun modello con supporto vision trovato su OpenRouter.',
        );
      }
      return models;
    } on FamyliaException {
      rethrow;
    } catch (e) {
      throw FamyliaException(
        message: 'Errore recupero modelli OpenRouter: $e',
      );
    } finally {
      client.close();
    }
  }

  bool _modelSupportsVision(Map<dynamic, dynamic> item) {
    return _modelInputModalities(item).contains('image');
  }

  bool _isModelFree(Map<dynamic, dynamic> item, String id) {
    if (id.endsWith(':free') || id == 'openrouter/free') return true;
    final pricing = item['pricing'];
    if (pricing is! Map) return false;
    return _pricingAmount(pricing['prompt']) == 0 &&
        _pricingAmount(pricing['completion']) == 0 &&
        _pricingAmount(pricing['request']) == 0;
  }

  double _pricingAmount(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0;
  }

  List<String> _modelInputModalities(Map<dynamic, dynamic> item) {
    final arch = item['architecture'];
    if (arch is Map) {
      final modalities = arch['input_modalities'];
      if (modalities is List) {
        return modalities.map((e) => e.toString()).toList();
      }
    }
    final top = item['input_modalities'];
    if (top is List) {
      return top.map((e) => e.toString()).toList();
    }
    return const [];
  }

  Future<String> _readModel(Session session) async {
    final rows = await session.db.unsafeQuery(
      'SELECT "defaultModel" FROM "ai_config" LIMIT 1',
    );
    if (rows.isEmpty) return 'google/gemini-2.5-flash-preview';
    return (rows.first[0] as String?) ?? 'google/gemini-2.5-flash-preview';
  }

  Future<String> _callOpenRouter(
    String apiKey,
    String model,
    String? text,
    List<String>? images,
    List<String>? mimeTypes,
  ) async {
    final userParts = <Map<String, dynamic>>[];
    var extraText = StringBuffer();

    if (images != null) {
      for (var i = 0; i < images.length; i++) {
        final mime =
            (mimeTypes != null && i < mimeTypes.length) ? mimeTypes[i] : 'image/jpeg';
        if (_isVisionImageMime(mime)) {
          userParts.add({
            'type': 'image_url',
            'image_url': {'url': 'data:$mime;base64,${images[i]}'},
          });
        } else {
          extraText.writeln(
            '[Allegato non inviato come immagine: tipo $mime — descrivi dal testo se possibile.]',
          );
        }
      }
    }

    final userText = [
      if (text != null && text.trim().isNotEmpty) text.trim(),
      if (extraText.isNotEmpty) extraText.toString().trim(),
    ].join('\n\n');

    if (userText.isNotEmpty) {
      userParts.insert(0, {'type': 'text', 'text': userText});
    }

    if (userParts.isEmpty) {
      throw FamyliaException(
        message: 'Nessun contenuto valido da analizzare (solo immagini supportate).',
      );
    }

    final requestBody = jsonEncode({
      'model': model,
      'messages': [
        {'role': 'system', 'content': _systemPromptJson()},
        {
          'role': 'user',
          'content': userParts.length == 1 && userParts.first['type'] == 'text'
              ? userParts.first['text']
              : userParts,
        },
      ],
      'response_format': {'type': 'json_object'},
      'max_tokens': 800,
      'temperature': 0.1,
    });

    final bodyBytes = utf8.encode(requestBody);
    final client = HttpClient();
    try {
      final request = await client
          .postUrl(Uri.parse('https://openrouter.ai/api/v1/chat/completions'));
      _setOpenRouterHeaders(request, apiKey);
      request.contentLength = bodyBytes.length;
      request.add(bodyBytes);

      final response = await request.close();
      final body = await response.transform(utf8.decoder).join();

      if (response.statusCode != 200) {
        throw FamyliaException(
          message: 'OpenRouter error ${response.statusCode}: $body',
        );
      }

      final responseJson = jsonDecode(body) as Map<String, dynamic>;
      final choices = responseJson['choices'] as List?;
      if (choices == null || choices.isEmpty) {
        throw FamyliaException(message: 'Nessuna risposta dal modello AI.');
      }

      final message = (choices[0] as Map)['message'] as Map?;
      if (message == null) {
        throw FamyliaException(message: 'Risposta OpenRouter senza messaggio.');
      }

      final parsed = _parseExtractionJson(message['content']);
      return jsonEncode(parsed);
    } on FamyliaException {
      rethrow;
    } on FormatException catch (e) {
      throw FamyliaException(message: 'Risposta AI non valida: ${e.message}');
    } catch (e) {
      throw FamyliaException(message: 'Errore chiamata OpenRouter: $e');
    } finally {
      client.close();
    }
  }

  bool _isVisionImageMime(String mime) {
    return mime.startsWith('image/');
  }

  /// Prompt di sistema: schema JSON allineato a [AiExtractionResult] nell'app Flutter.
  String _systemPromptJson() {
    final today = DateTime.now().toIso8601String().substring(0, 10);
    return '''
Sei l'assistente di estrazione attività per Famylia (app familiare italiana).
Analizza testo e/o immagini allegate e restituisci UNA sola attività da registrare.

Rispondi ESCLUSIVAMENTE con un oggetto JSON valido (nessun markdown, nessun testo prima o dopo).
Schema obbligatorio:
{
  "tipo": "task" | "appuntamento" | "spesa" | "scadenza" | "acquisto",
  "titolo": "stringa max 60 caratteri, italiano",
  "descrizione": "stringa o null",
  "importo": number o null,
  "quando": "stringa ISO8601 o null",
  "tipoAppuntamento": "generico" | "medico" | "dentista" | "altro" o null,
  "confidenza": number tra 0 e 1,
  "motivazione": "stringa breve"
}

Significato di tipo:
- task: azione da fare (chiamare, prenotare, portare qualcosa)
- appuntamento: evento con data/ora (visita, riunione, scuola)
- spesa: pagamento già avvenuto (scontrino, bonifico)
- scadenza: pagamento o bolletta futura con scadenza
- acquisto: articolo per lista della spesa

Regole:
- Oggi è $today; converti "domani", "lunedì" ecc. in ISO8601 (es. 2026-06-01T10:00:00.000Z).
- tipoAppuntamento solo se tipo è appuntamento, altrimenti null.
- importo solo per spesa/scadenza se presente nel documento.
- Se incerto, abbassa confidenza ma compila comunque i campi obbligatori.
''';
  }

  Map<String, dynamic> _parseExtractionJson(dynamic rawContent) {
    final text = _contentToString(rawContent);
    if (text == null || text.trim().isEmpty) {
      throw const FormatException('contenuto vuoto');
    }

    var jsonText = text.trim();
    if (jsonText.startsWith('```')) {
      jsonText = jsonText
          .replaceFirst(RegExp(r'^```(?:json)?\s*', multiLine: true), '')
          .replaceFirst(RegExp(r'\s*```$'), '')
          .trim();
    }

    final decoded = jsonDecode(jsonText);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('atteso oggetto JSON');
    }

    return _normalizeExtraction(decoded);
  }

  String? _contentToString(dynamic content) {
    if (content == null) return null;
    if (content is String) return content;
    if (content is List) {
      final buffer = StringBuffer();
      for (final part in content) {
        if (part is Map) {
          final type = part['type'] as String?;
          if (type == 'text') {
            final t = part['text'] as String?;
            if (t != null && t.isNotEmpty) {
              if (buffer.isNotEmpty) buffer.writeln();
              buffer.write(t);
            }
          }
        }
      }
      return buffer.isEmpty ? null : buffer.toString();
    }
    return content.toString();
  }

  Map<String, dynamic> _normalizeExtraction(Map<String, dynamic> json) {
    const allowedTipi = {'task', 'appuntamento', 'spesa', 'scadenza', 'acquisto'};
    const allowedAppuntamento = {'generico', 'medico', 'dentista', 'altro'};

    var tipo = (json['tipo'] as String? ?? 'task').toLowerCase().trim();
    if (!allowedTipi.contains(tipo)) tipo = 'task';

    var titolo = (json['titolo'] as String? ?? '').trim();
    if (titolo.length > 60) titolo = titolo.substring(0, 60);

    final confidenzaRaw = json['confidenza'];
    final confidenza = confidenzaRaw is num
        ? confidenzaRaw.toDouble().clamp(0.0, 1.0)
        : 0.5;

    String? tipoAppuntamento;
    if (tipo == 'appuntamento') {
      final raw = (json['tipoAppuntamento'] as String? ?? 'generico')
          .toLowerCase()
          .trim();
      tipoAppuntamento =
          allowedAppuntamento.contains(raw) ? raw : 'generico';
    }

    return {
      'tipo': tipo,
      'titolo': titolo.isEmpty ? 'Attività da verificare' : titolo,
      'descrizione': json['descrizione'],
      'importo': json['importo'],
      'quando': json['quando'],
      'tipoAppuntamento': tipoAppuntamento,
      'confidenza': confidenza,
      'motivazione': (json['motivazione'] as String? ?? '').trim(),
    };
  }
}
