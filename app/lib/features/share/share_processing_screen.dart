import 'package:flutter/material.dart';

import '../../core/api/share_repository.dart';
import '../shell/nuova_attivita_modal.dart';

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
    } catch (_) {
      if (!mounted) return;
      Navigator.of(context).pop();
      final title = widget.content.length > 80
          ? widget.content.substring(0, 80)
          : widget.content;
      NuovaAttivitaModal.showWithSharePrefill(
        context,
        prefillTitle: title,
      );
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
