import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';
import '../generated/shared_content_analysis.dart';
import '../util/family_access.dart';

class ShareEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<SharedContentAnalysis> analyzeContent(
    Session session,
    String content, {
    String? fileName,
  }) async {
    await requireUserId(session);

    final apiKey = Platform.environment['OPENROUTER_API_KEY'] ?? '';
    if (apiKey.isEmpty) {
      final title = content.length > 80 ? content.substring(0, 80) : content;
      return SharedContentAnalysis(
        title: title,
        description: content,
        suggestedDeadline: null,
      );
    }

    final prompt =
        '''Analizza il seguente contenuto condiviso e estrai le informazioni per creare un task in un\'app familiare.
Rispondi SOLO con un JSON valido con questi campi:
- title: string (titolo breve del task, max 60 caratteri)
- description: string (descrizione opzionale, può essere vuota)
- suggestedDeadline: string|null (data nel formato YYYY-MM-DD se deducibile, altrimenti null)

Contenuto da analizzare:
${content.length > 2000 ? content.substring(0, 2000) : content}''';

    try {
      final response = await http.post(
        Uri.parse('https://openrouter.ai/api/v1/chat/completions'),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
          'HTTP-Referer': 'https://famylia.app',
          'X-Title': 'Famylia',
        },
        body: jsonEncode({
          'model': 'google/gemini-flash-1.5',
          'messages': [
            {'role': 'user', 'content': prompt}
          ],
          'response_format': {'type': 'json_object'},
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final text =
            (data['choices'] as List).first['message']['content'] as String;
        final result = jsonDecode(text) as Map<String, dynamic>;
        return SharedContentAnalysis(
          title: (result['title'] as String?) ?? '',
          description: (result['description'] as String?) ?? '',
          suggestedDeadline: result['suggestedDeadline'] as String?,
        );
      }
    } catch (_) {}

    final title = content.length > 80 ? content.substring(0, 80) : content;
    return SharedContentAnalysis(
      title: title,
      description: content,
      suggestedDeadline: null,
    );
  }
}
