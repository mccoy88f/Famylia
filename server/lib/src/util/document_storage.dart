import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as p;
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Storage locale documenti (dev / self-hosted senza MinIO).
class DocumentStorage {
  DocumentStorage(this.session);

  final Session session;

  static const _baseDir = 'storage/documents';

  Future<String> save({
    required int familyId,
    required String fileName,
    required ByteData bytes,
  }) async {
    final safeName = fileName.replaceAll(RegExp(r'[^\w.\-]'), '_');
    final unique =
        '${DateTime.now().millisecondsSinceEpoch}_$safeName';
    final dir = Directory(p.join(_baseDir, '$familyId'));
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }
    final path = p.join(dir.path, unique);
    final file = File(path);
    await file.writeAsBytes(bytes.buffer.asUint8List());
    session.log('Documento salvato: $path');
    return path;
  }

  static DocumentFileType fileTypeFromName(String name) {
    final lower = name.toLowerCase();
    if (lower.endsWith('.pdf')) return DocumentFileType.pdf;
    if (lower.endsWith('.png') ||
        lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg') ||
        lower.endsWith('.webp') ||
        lower.endsWith('.gif')) {
      return DocumentFileType.image;
    }
    return DocumentFileType.other;
  }
}
