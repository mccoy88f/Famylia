import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../util/document_storage.dart';
import '../util/family_access.dart';

class DocumentEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<DocumentRecord>> listDocuments(
    Session session,
    int familyId, {
    DocumentCategory? category,
  }) async {
    final userId = await requireUserId(session);
    await requireFamilyMember(session, familyId);
    final rows = await DocumentRecord.db.find(
      session,
      where: (t) {
        var expr = t.familyId.equals(familyId);
        if (category != null) {
          expr = expr & t.category.equals(category);
        }
        return expr;
      },
      orderBy: (t) => t.id,
      orderDescending: true,
    );
    return rows.where((d) => _canView(d, userId)).toList();
  }

  Future<DocumentRecord> uploadDocument(
    Session session,
    int familyId,
    String title,
    String fileName,
    ByteData fileBytes, {
    String? description,
    DocumentCategory? category,
    int? relatedDeadlineId,
    int? relatedExpenseId,
  }) async {
    await requireFamilyMemberNotGuest(session, familyId);
    final userId = await requireUserId(session);
    final trimmed = title.trim();
    if (trimmed.isEmpty) {
      throw FamyliaException(message: 'Il titolo è obbligatorio.');
    }

    final storage = DocumentStorage(session);
    final path = await storage.save(
      familyId: familyId,
      fileName: fileName,
      bytes: fileBytes,
    );

    return DocumentRecord.db.insertRow(
      session,
      DocumentRecord(
        familyId: familyId,
        uploadedBy: userId,
        title: trimmed,
        description: description?.trim(),
        fileUrl: path,
        fileType: DocumentStorage.fileTypeFromName(fileName),
        fileSizeBytes: fileBytes.lengthInBytes,
        category: category ?? DocumentCategory.other,
        relatedDeadlineId: relatedDeadlineId,
        relatedExpenseId: relatedExpenseId,
        accessLevel: DocumentAccessLevel.family,
      ),
    );
  }

  /// Placeholder OCR — popola metadati base (estensione futura Tesseract).
  Future<DocumentRecord> runOcr(Session session, int documentId) async {
    final doc = await DocumentRecord.db.findById(session, documentId);
    if (doc == null) {
      throw FamyliaException(message: 'Documento non trovato.');
    }
    await requireFamilyMember(session, doc.familyId);
    return DocumentRecord.db.updateRow(
      session,
      doc.copyWith(
        ocrDataJson:
            '{"status":"pending","message":"OCR Tesseract pianificato"}',
      ),
    );
  }

  Future<bool> deleteDocument(Session session, int documentId) async {
    final doc = await DocumentRecord.db.findById(session, documentId);
    if (doc == null) {
      throw FamyliaException(message: 'Documento non trovato.');
    }
    await requireFamilyMemberNotGuest(session, doc.familyId);
    await DocumentRecord.db.deleteRow(session, doc);
    return true;
  }

  bool _canView(DocumentRecord doc, int userId) {
    if (doc.accessLevel == DocumentAccessLevel.private) {
      return doc.uploadedBy == userId;
    }
    return true;
  }
}
