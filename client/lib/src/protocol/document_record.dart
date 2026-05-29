/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'document_file_type.dart' as _i2;
import 'document_category.dart' as _i3;
import 'document_access_level.dart' as _i4;

/// Documento o ricevuta familiare.
abstract class DocumentRecord implements _i1.SerializableModel {
  DocumentRecord._({
    this.id,
    required this.familyId,
    required this.uploadedBy,
    required this.title,
    this.description,
    required this.fileUrl,
    _i2.DocumentFileType? fileType,
    this.fileSizeBytes,
    _i3.DocumentCategory? category,
    this.relatedDeadlineId,
    this.relatedExpenseId,
    this.ocrDataJson,
    _i4.DocumentAccessLevel? accessLevel,
  })  : fileType = fileType ?? _i2.DocumentFileType.other,
        category = category ?? _i3.DocumentCategory.other,
        accessLevel = accessLevel ?? _i4.DocumentAccessLevel.family;

  factory DocumentRecord({
    int? id,
    required int familyId,
    required int uploadedBy,
    required String title,
    String? description,
    required String fileUrl,
    _i2.DocumentFileType? fileType,
    int? fileSizeBytes,
    _i3.DocumentCategory? category,
    int? relatedDeadlineId,
    int? relatedExpenseId,
    String? ocrDataJson,
    _i4.DocumentAccessLevel? accessLevel,
  }) = _DocumentRecordImpl;

  factory DocumentRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return DocumentRecord(
      id: jsonSerialization['id'] as int?,
      familyId: jsonSerialization['familyId'] as int,
      uploadedBy: jsonSerialization['uploadedBy'] as int,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      fileUrl: jsonSerialization['fileUrl'] as String,
      fileType: _i2.DocumentFileType.fromJson(
          (jsonSerialization['fileType'] as String)),
      fileSizeBytes: jsonSerialization['fileSizeBytes'] as int?,
      category: _i3.DocumentCategory.fromJson(
          (jsonSerialization['category'] as String)),
      relatedDeadlineId: jsonSerialization['relatedDeadlineId'] as int?,
      relatedExpenseId: jsonSerialization['relatedExpenseId'] as int?,
      ocrDataJson: jsonSerialization['ocrDataJson'] as String?,
      accessLevel: _i4.DocumentAccessLevel.fromJson(
          (jsonSerialization['accessLevel'] as String)),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int familyId;

  int uploadedBy;

  String title;

  String? description;

  String fileUrl;

  _i2.DocumentFileType fileType;

  int? fileSizeBytes;

  _i3.DocumentCategory category;

  int? relatedDeadlineId;

  int? relatedExpenseId;

  String? ocrDataJson;

  _i4.DocumentAccessLevel accessLevel;

  /// Returns a shallow copy of this [DocumentRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DocumentRecord copyWith({
    int? id,
    int? familyId,
    int? uploadedBy,
    String? title,
    String? description,
    String? fileUrl,
    _i2.DocumentFileType? fileType,
    int? fileSizeBytes,
    _i3.DocumentCategory? category,
    int? relatedDeadlineId,
    int? relatedExpenseId,
    String? ocrDataJson,
    _i4.DocumentAccessLevel? accessLevel,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'familyId': familyId,
      'uploadedBy': uploadedBy,
      'title': title,
      if (description != null) 'description': description,
      'fileUrl': fileUrl,
      'fileType': fileType.toJson(),
      if (fileSizeBytes != null) 'fileSizeBytes': fileSizeBytes,
      'category': category.toJson(),
      if (relatedDeadlineId != null) 'relatedDeadlineId': relatedDeadlineId,
      if (relatedExpenseId != null) 'relatedExpenseId': relatedExpenseId,
      if (ocrDataJson != null) 'ocrDataJson': ocrDataJson,
      'accessLevel': accessLevel.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DocumentRecordImpl extends DocumentRecord {
  _DocumentRecordImpl({
    int? id,
    required int familyId,
    required int uploadedBy,
    required String title,
    String? description,
    required String fileUrl,
    _i2.DocumentFileType? fileType,
    int? fileSizeBytes,
    _i3.DocumentCategory? category,
    int? relatedDeadlineId,
    int? relatedExpenseId,
    String? ocrDataJson,
    _i4.DocumentAccessLevel? accessLevel,
  }) : super._(
          id: id,
          familyId: familyId,
          uploadedBy: uploadedBy,
          title: title,
          description: description,
          fileUrl: fileUrl,
          fileType: fileType,
          fileSizeBytes: fileSizeBytes,
          category: category,
          relatedDeadlineId: relatedDeadlineId,
          relatedExpenseId: relatedExpenseId,
          ocrDataJson: ocrDataJson,
          accessLevel: accessLevel,
        );

  /// Returns a shallow copy of this [DocumentRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DocumentRecord copyWith({
    Object? id = _Undefined,
    int? familyId,
    int? uploadedBy,
    String? title,
    Object? description = _Undefined,
    String? fileUrl,
    _i2.DocumentFileType? fileType,
    Object? fileSizeBytes = _Undefined,
    _i3.DocumentCategory? category,
    Object? relatedDeadlineId = _Undefined,
    Object? relatedExpenseId = _Undefined,
    Object? ocrDataJson = _Undefined,
    _i4.DocumentAccessLevel? accessLevel,
  }) {
    return DocumentRecord(
      id: id is int? ? id : this.id,
      familyId: familyId ?? this.familyId,
      uploadedBy: uploadedBy ?? this.uploadedBy,
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      fileUrl: fileUrl ?? this.fileUrl,
      fileType: fileType ?? this.fileType,
      fileSizeBytes: fileSizeBytes is int? ? fileSizeBytes : this.fileSizeBytes,
      category: category ?? this.category,
      relatedDeadlineId: relatedDeadlineId is int?
          ? relatedDeadlineId
          : this.relatedDeadlineId,
      relatedExpenseId:
          relatedExpenseId is int? ? relatedExpenseId : this.relatedExpenseId,
      ocrDataJson: ocrDataJson is String? ? ocrDataJson : this.ocrDataJson,
      accessLevel: accessLevel ?? this.accessLevel,
    );
  }
}
