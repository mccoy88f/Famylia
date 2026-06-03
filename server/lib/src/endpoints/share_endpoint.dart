import 'dart:convert';
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../util/family_access.dart';
import '../util/ai_config_util.dart';

class ShareEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<SharedContentAnalysis> analyzeContent(
    Session session,
    String content, {
    String? fileName,
  }) async {
    await requireUserId(session);

    final truncated =
        content.length > 2000 ? content.substring(0, 2000) : content;

    final systemPrompt =
        'Sei MarIA, l\'assistente familiare di Famylia. Analizza il contenuto e rispondi SOLO con JSON valido.';
    final userPrompt =
        '''Analizza il seguente contenuto condiviso e estrai le informazioni per creare un task in un\'app familiare.
Rispondi SOLO con un JSON valido con questi campi:
{"title": "titolo breve del task, max 60 caratteri", "description": "descrizione opzionale, può essere vuota", "suggestedDeadline": "YYYY-MM-DD o null"}

Contenuto da analizzare:
$truncated''';

    try {
      final aiResult =
          await AiConfigUtil.callAi(session, systemPrompt, userPrompt);
      final result = jsonDecode(aiResult.text) as Map<String, dynamic>;

      // Log usage (familyId 0 as fallback — share has no family context)
      final config = await AiConfigUtil.getConfig(session);
      final cost = AiConfigUtil.estimateCost(
        config.provider.name,
        config.modelName,
        aiResult.inputTokens,
        aiResult.outputTokens,
      );
      await AiConfigUtil.logUsage(
        session,
        familyId: 0,
        feature: 'share',
        provider: config.provider.name,
        modelName: config.modelName,
        inputTokens: aiResult.inputTokens,
        outputTokens: aiResult.outputTokens,
        costUsd: cost,
      );

      return SharedContentAnalysis(
        title: (result['title'] as String?) ?? '',
        description: (result['description'] as String?) ?? '',
        suggestedDeadline: result['suggestedDeadline'] as String?,
      );
    } catch (_) {}

    final title = content.length > 80 ? content.substring(0, 80) : content;
    return SharedContentAnalysis(
      title: title,
      description: content,
      suggestedDeadline: null,
    );
  }
}
