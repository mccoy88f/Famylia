import 'dart:convert';

import 'package:famylia_client/famylia_client.dart';

import 'famylia_services.dart';

class AiExtractionResult {
  const AiExtractionResult({
    required this.tipo,
    required this.titolo,
    required this.confidenza,
    required this.motivazione,
    this.descrizione,
    this.importo,
    this.quando,
    this.tipoAppuntamento,
    this.raw,
  });

  factory AiExtractionResult.fromJson(Map<String, dynamic> json) {
    DateTime? quando;
    final quandoRaw = json['quando'];
    if (quandoRaw is String && quandoRaw.isNotEmpty) {
      quando = DateTime.tryParse(quandoRaw);
    }
    return AiExtractionResult(
      tipo: json['tipo'] as String? ?? 'task',
      titolo: json['titolo'] as String? ?? '',
      descrizione: json['descrizione'] as String?,
      importo: (json['importo'] as num?)?.toDouble(),
      quando: quando,
      tipoAppuntamento: json['tipoAppuntamento'] as String?,
      confidenza: (json['confidenza'] as num?)?.toDouble() ?? 0.5,
      motivazione: json['motivazione'] as String? ?? '',
      raw: json,
    );
  }

  final String tipo;
  final String titolo;
  final String? descrizione;
  final double? importo;
  final DateTime? quando;
  final String? tipoAppuntamento;
  final double confidenza;
  final String motivazione;
  final Map<String, dynamic>? raw;
}

class AiRepository {
  AiRepository({FamyliaServices? services})
      : _client = (services ?? FamyliaServices.instance).client;

  final Client _client;

  Future<bool> isConfigured() => _client.ai.isConfigured();

  Future<AiExtractionResult> extractActivity(
    int familyId, {
    String? text,
    List<String>? base64Images,
    List<String>? mimeTypes,
    String? model,
  }) async {
    final payload = jsonEncode({
      if (text != null) 'text': text,
      if (base64Images != null) 'base64Images': base64Images,
      if (mimeTypes != null) 'mimeTypes': mimeTypes,
      if (model != null) 'model': model,
    });

    final json = await _client.ai.extractActivity(familyId, payload);
    return AiExtractionResult.fromJson(jsonDecode(json) as Map<String, dynamic>);
  }

  String errorMessage(Object e) {
    if (e is FamyliaException) return e.message;
    return 'Errore: $e';
  }
}
