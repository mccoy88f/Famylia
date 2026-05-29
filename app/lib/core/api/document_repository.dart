import 'dart:typed_data';

import 'package:famylia_client/famylia_client.dart';

import 'famylia_services.dart';

class DocumentRepository {
  DocumentRepository({FamyliaServices? services})
      : _client = (services ?? FamyliaServices.instance).client;

  final Client _client;

  Future<List<DocumentRecord>> list(int familyId) =>
      _client.document.listDocuments(familyId);

  Future<DocumentRecord> upload(
    int familyId,
    String title,
    String fileName,
    Uint8List bytes,
  ) =>
      _client.document.uploadDocument(
        familyId,
        title,
        fileName,
        ByteData.sublistView(bytes),
      );

  Future<DocumentRecord> runOcr(int id) => _client.document.runOcr(id);

  Future<bool> delete(int id) => _client.document.deleteDocument(id);

  String errorMessage(Object e) {
    if (e is FamyliaException) return e.message;
    return 'Errore: $e';
  }
}
