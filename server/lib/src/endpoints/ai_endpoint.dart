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
    await session.db.unsafeExecute(
      '''
      INSERT INTO "ai_config" ("openRouterApiKey", "defaultModel", "updatedAt")
      VALUES (\$1, \$2, now())
      ON CONFLICT DO NOTHING
      ''',
      parameters: QueryParameters.positional([trimmedKey, trimmedModel]),
    );
    // If row already exists, update it
    await session.db.unsafeExecute(
      'UPDATE "ai_config" SET "openRouterApiKey" = \$1, "defaultModel" = \$2, "updatedAt" = now()',
      parameters: QueryParameters.positional([trimmedKey, trimmedModel]),
    );
    return true;
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

    return _callOpenRouter(apiKey, model, text, base64Images, mimeTypes);
  }

  // ── Private helpers ───────────────────────────────────────────────────────

  Future<String?> _readKey(Session session) async {
    final rows = await session.db.unsafeQuery(
      'SELECT "openRouterApiKey" FROM "ai_config" LIMIT 1',
    );
    if (rows.isEmpty) return null;
    return rows.first[0] as String?;
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
    final content = <Map<String, dynamic>>[];

    content.add({
      'type': 'text',
      'text': _buildPrompt(text),
    });

    if (images != null) {
      for (var i = 0; i < images.length; i++) {
        final mime =
            (mimeTypes != null && i < mimeTypes.length) ? mimeTypes[i] : 'image/jpeg';
        content.add({
          'type': 'image_url',
          'image_url': {'url': 'data:$mime;base64,${images[i]}'},
        });
      }
    }

    final requestBody = jsonEncode({
      'model': model,
      'messages': [
        {'role': 'user', 'content': content}
      ],
      'response_format': {'type': 'json_object'},
      'max_tokens': 600,
      'temperature': 0.1,
    });

    final client = HttpClient();
    try {
      final request = await client
          .postUrl(Uri.parse('https://openrouter.ai/api/v1/chat/completions'));
      request.headers.set('Authorization', 'Bearer $apiKey');
      request.headers.set('Content-Type', 'application/json');
      request.headers.set('HTTP-Referer', 'https://famylia.app');
      request.headers.set('X-Title', 'Famylia');
      request.write(requestBody);

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

      final messageContent = (choices[0] as Map)['message']['content'] as String;
      jsonDecode(messageContent); // validate JSON
      return messageContent;
    } on FamyliaException {
      rethrow;
    } catch (e) {
      throw FamyliaException(message: 'Errore chiamata OpenRouter: $e');
    } finally {
      client.close();
    }
  }

  String _buildPrompt(String? userText) {
    final now = DateTime.now().toIso8601String().substring(0, 10);
    return '''Sei un assistente per l\'app Famylia che aiuta le famiglie a organizzare le attività.

Analizza il contenuto fornito (testo, email, fattura, screenshot, foto) e identifica UN\'UNICA attività familiare da registrare.

Rispondi SOLO con un oggetto JSON valido con questi campi:
{
  "tipo": "task" | "appuntamento" | "spesa" | "scadenza" | "acquisto",
  "titolo": "stringa breve max 60 caratteri",
  "descrizione": "stringa o null",
  "importo": numero decimale oppure null,
  "quando": "data ISO8601 oppure null",
  "tipoAppuntamento": "generico" | "medico" | "dentista" | "altro",
  "confidenza": numero da 0 a 1,
  "motivazione": "breve spiegazione di cosa hai rilevato"
}

Definizioni dei tipi:
- task: azione da compiere (es. chiamare il medico, portare l\'auto dal meccanico)
- appuntamento: evento con data/ora (visita, riunione, colloquio, evento scolastico)
- spesa: pagamento già effettuato (scontrino, ricevuta, estratto conto)
- scadenza: bolletta o pagamento futuro con importo e data (luce, gas, affitto, abbonamento)
- acquisto: prodotto da aggiungere alla lista della spesa

Regole:
- Data di oggi: $now. Converti date relative (domani, lunedì prossimo) in ISO8601.
- Se non trovi un tipo chiaro, usa il più plausibile con confidenza bassa.
- Titolo in italiano, conciso, senza articoli iniziali inutili.
- tipoAppuntamento va compilato solo se tipo = appuntamento.
${userText != null && userText.trim().isNotEmpty ? '\nContenuto testuale:\n$userText' : ''}''';
  }
}
