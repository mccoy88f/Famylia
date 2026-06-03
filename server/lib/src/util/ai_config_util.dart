import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class AiCallResult {
  final String text;
  final int inputTokens;
  final int outputTokens;
  const AiCallResult({
    required this.text,
    required this.inputTokens,
    required this.outputTokens,
  });
}

class AiConfigUtil {
  // Cache config for 60 seconds
  static AiConfig? _cached;
  static DateTime? _cachedAt;

  static Future<AiConfig> getConfig(Session session) async {
    final now = DateTime.now();
    if (_cached != null &&
        _cachedAt != null &&
        now.difference(_cachedAt!).inSeconds < 60) {
      return _cached!;
    }
    var config = await AiConfig.db.findFirstRow(session);
    if (config == null) {
      config = await AiConfig.db.insertRow(
        session,
        AiConfig(
          provider: AiProvider.openrouter,
          modelName: 'google/gemini-flash-1.5',
          updatedAt: now.toUtc(),
        ),
      );
    }
    _cached = config;
    _cachedAt = now;
    return config;
  }

  static void invalidateCache() {
    _cached = null;
    _cachedAt = null;
  }

  static Future<AiCallResult> callAi(
    Session session,
    String systemPrompt,
    String userPrompt,
  ) async {
    final config = await getConfig(session);
    if (config.provider == AiProvider.gemini) {
      return _callGemini(config.modelName, systemPrompt, userPrompt);
    } else {
      return _callOpenRouter(config.modelName, systemPrompt, userPrompt);
    }
  }

  static Future<AiCallResult> _callOpenRouter(
      String model, String system, String user) async {
    final apiKey = Platform.environment['OPENROUTER_API_KEY'] ?? '';
    final response = await http.post(
      Uri.parse('https://openrouter.ai/api/v1/chat/completions'),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
        'HTTP-Referer': 'https://famylia.app',
        'X-Title': 'Famylia',
      },
      body: jsonEncode({
        'model': model,
        'messages': [
          {'role': 'system', 'content': system},
          {'role': 'user', 'content': user},
        ],
        'response_format': {'type': 'json_object'},
      }),
    );
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final text =
        (data['choices'] as List).first['message']['content'] as String;
    final usage = data['usage'] as Map<String, dynamic>? ?? {};
    return AiCallResult(
      text: text,
      inputTokens: (usage['prompt_tokens'] as int?) ?? 0,
      outputTokens: (usage['completion_tokens'] as int?) ?? 0,
    );
  }

  static Future<AiCallResult> _callGemini(
      String model, String system, String user) async {
    final apiKey = Platform.environment['GEMINI_API_KEY'] ?? '';
    // Strip "models/" prefix if present, normalize model name
    final modelId = model.replaceFirst(RegExp(r'^models/'), '');
    final response = await http.post(
      Uri.parse(
          'https://generativelanguage.googleapis.com/v1beta/models/$modelId:generateContent?key=$apiKey'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'system_instruction': {
          'parts': [
            {'text': system}
          ]
        },
        'contents': [
          {
            'parts': [
              {'text': user}
            ],
            'role': 'user'
          }
        ],
        'generationConfig': {'responseMimeType': 'application/json'},
      }),
    );
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final text =
        data['candidates'][0]['content']['parts'][0]['text'] as String;
    final usage = data['usageMetadata'] as Map<String, dynamic>? ?? {};
    return AiCallResult(
      text: text,
      inputTokens: (usage['promptTokenCount'] as int?) ?? 0,
      outputTokens: (usage['candidatesTokenCount'] as int?) ?? 0,
    );
  }

  static Future<void> logUsage(
    Session session, {
    required int familyId,
    required String feature,
    required String provider,
    required String modelName,
    required int inputTokens,
    required int outputTokens,
    required double costUsd,
  }) async {
    await TokenUsageLog.db.insertRow(
      session,
      TokenUsageLog(
        familyId: familyId,
        feature: feature,
        provider: provider,
        modelName: modelName,
        inputTokens: inputTokens,
        outputTokens: outputTokens,
        costUsd: costUsd,
        createdAt: DateTime.now().toUtc(),
      ),
    );
  }

  static double estimateCost(
      String provider, String model, int inputTokens, int outputTokens) {
    // Prices per million tokens
    double inputPricePerM = 0.075;
    double outputPricePerM = 0.30;
    final m = model.toLowerCase();
    if (provider == 'gemini') {
      if (m.contains('flash')) {
        inputPricePerM = 0.075;
        outputPricePerM = 0.30;
      } else if (m.contains('pro')) {
        inputPricePerM = 1.25;
        outputPricePerM = 5.00;
      }
    } else {
      // OpenRouter — use model name heuristics
      if (m.contains('flash')) {
        inputPricePerM = 0.075;
        outputPricePerM = 0.30;
      } else if (m.contains('gpt-4o-mini')) {
        inputPricePerM = 0.15;
        outputPricePerM = 0.60;
      } else if (m.contains('haiku')) {
        inputPricePerM = 0.80;
        outputPricePerM = 4.00;
      } else if (m.contains('sonnet')) {
        inputPricePerM = 3.00;
        outputPricePerM = 15.00;
      }
    }
    return (inputTokens / 1000000) * inputPricePerM +
        (outputTokens / 1000000) * outputPricePerM;
  }
}
