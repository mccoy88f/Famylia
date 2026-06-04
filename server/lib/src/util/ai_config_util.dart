import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import 'ai_model_catalog.dart';

class QuotaExceededException implements Exception {
  final DateTime resetDate;
  final bool isTokenLimit;
  QuotaExceededException({required this.resetDate, required this.isTokenLimit});
  @override
  String toString() => '{"type":"QuotaExceeded","resetDate":"${resetDate.toIso8601String()}","isTokenLimit":$isTokenLimit}';
}

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
    String userPrompt, {
    int? familyId,
    String? systemPromptOverride,
  }) async {
    final config = await getConfig(session);
    final systemPrompt = systemPromptOverride ?? config.systemPrompt;

    if (familyId != null) {
      final quota = await FamilyQuota.db.findFirstRow(session,
          where: (t) => t.familyId.equals(familyId));
      if (quota != null) {
        final now = DateTime.now().toUtc();
        final startOfMonth = DateTime(now.year, now.month, 1).toUtc();
        final logs = await TokenUsageLog.db.find(session,
            where: (t) =>
                t.familyId.equals(familyId) &
                t.createdAt.isAfter(startOfMonth));
        final totalTokens =
            logs.fold(0, (s, l) => s + l.inputTokens + l.outputTokens);
        final totalCost = logs.fold(0.0, (s, l) => s + l.costUsd);
        final resetDate = DateTime(
                now.month == 12 ? now.year + 1 : now.year,
                now.month == 12 ? 1 : now.month + 1,
                1)
            .toUtc();
        if (quota.monthlyTokenLimit != null &&
            totalTokens >= quota.monthlyTokenLimit!) {
          throw QuotaExceededException(
              resetDate: resetDate, isTokenLimit: true);
        }
        if (quota.monthlyCostLimitUsd != null &&
            totalCost >= quota.monthlyCostLimitUsd!) {
          throw QuotaExceededException(
              resetDate: resetDate, isTokenLimit: false);
        }
      }
    }

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
    if (response.statusCode != 200) {
      throw Exception('OpenRouter error ${response.statusCode}: ${response.body}');
    }
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
    if (response.statusCode != 200) {
      throw Exception('Gemini error ${response.statusCode}: ${response.body}');
    }
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final candidates = data['candidates'] as List?;
    if (candidates == null || candidates.isEmpty) {
      throw Exception('Gemini returned no candidates: ${response.body}');
    }
    final text =
        candidates[0]['content']['parts'][0]['text'] as String;
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
      String provider, String modelId, int inputTokens, int outputTokens) {
    final info = AiModelCatalog.findById(modelId);
    final inputPrice = info?.inputPricePerM ?? 0.075;
    final outputPrice = info?.outputPricePerM ?? 0.30;
    return (inputTokens / 1_000_000) * inputPrice +
        (outputTokens / 1_000_000) * outputPrice;
  }
}
