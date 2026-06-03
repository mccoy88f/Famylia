import 'dart:convert';

import 'package:flutter/material.dart';

import '../../core/api/share_repository.dart';
import '../shell/nuova_attivita_modal.dart';
import 'quota_exceeded_dialog.dart';

class ShareProcessingScreen extends StatefulWidget {
  const ShareProcessingScreen({
    required this.content,
    this.filePath,
    this.mimeType,
    super.key,
  });

  final String content;
  final String? filePath;
  final String? mimeType;

  @override
  State<ShareProcessingScreen> createState() => _ShareProcessingScreenState();
}

class _ShareProcessingScreenState extends State<ShareProcessingScreen> {
  @override
  void initState() {
    super.initState();
    _analyze();
  }

  Future<void> _analyze() async {
    try {
      final result = await ShareRepository().analyzeContent(
        widget.content,
        fileName: widget.filePath,
      );
      if (!mounted) return;
      Navigator.of(context).pop();
      NuovaAttivitaModal.showWithSharePrefill(
        context,
        prefillTitle: result.title,
        prefillDescription: result.description.isEmpty ? null : result.description,
      );
    } catch (e) {
      if (!mounted) return;
      final msg = e.toString();
      if (msg.contains('QuotaExceeded')) {
        try {
          final json = jsonDecode(msg.substring(msg.indexOf('{'))) as Map<String, dynamic>;
          final resetDate = DateTime.parse(json['resetDate'] as String);
          final isTokenLimit = json['isTokenLimit'] as bool? ?? true;
          Navigator.of(context).pop();
          await QuotaExceededDialog.show(context,
              resetDate: resetDate, isTokenLimit: isTokenLimit);
          return;
        } catch (_) {}
      }
      Navigator.of(context).pop();
      NuovaAttivitaModal.showWithSharePrefill(context,
          prefillTitle: widget.content.length > 80
              ? widget.content.substring(0, 80)
              : widget.content);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              'MarIA sta analizzando...',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
