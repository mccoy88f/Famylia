import 'package:flutter/material.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'dart:async';

import '../../features/share/share_processing_screen.dart';

class ShareHandler {
  static StreamSubscription? _sub;

  static void init(BuildContext Function() contextGetter) {
    // Handle share while app is open
    _sub = ReceiveSharingIntent.instance.getMediaStream().listen((files) {
      _handleFiles(files, contextGetter());
    });

    // Handle share that launched the app
    ReceiveSharingIntent.instance.getInitialMedia().then((files) {
      if (files.isNotEmpty) {
        _handleFiles(files, contextGetter());
        ReceiveSharingIntent.instance.reset();
      }
    });
  }

  static void dispose() {
    _sub?.cancel();
  }

  static void _handleFiles(List<SharedMediaFile> files, BuildContext context) {
    if (files.isEmpty) return;
    final file = files.first;
    final text = file.path.startsWith('content://') || file.path.startsWith('/')
        ? null
        : file.path;
    final content = text ?? file.message ?? '';
    if (content.isEmpty && file.path.isEmpty) return;

    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (_) => ShareProcessingScreen(
          content: content,
          filePath: file.path,
          mimeType: file.mimeType,
        ),
      ),
    );
  }
}
