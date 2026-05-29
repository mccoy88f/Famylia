/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'document_file_type.dart' as _i2;
import 'document_category.dart' as _i3;
import 'document_access_level.dart' as _i4;

/// Documento o ricevuta familiare.
abstract class DocumentRecord
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
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

  static final t = DocumentRecordTable();

  static const db = DocumentRecordRepository._();

  @override
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

  @override
  _i1.Table<int> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static DocumentRecordInclude include() {
    return DocumentRecordInclude._();
  }

  static DocumentRecordIncludeList includeList({
    _i1.WhereExpressionBuilder<DocumentRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DocumentRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DocumentRecordTable>? orderByList,
    DocumentRecordInclude? include,
  }) {
    return DocumentRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DocumentRecord.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DocumentRecord.t),
      include: include,
    );
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

class DocumentRecordTable extends _i1.Table<int> {
  DocumentRecordTable({super.tableRelation})
      : super(tableName: 'document_record') {
    familyId = _i1.ColumnInt(
      'familyId',
      this,
    );
    uploadedBy = _i1.ColumnInt(
      'uploadedBy',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    fileUrl = _i1.ColumnString(
      'fileUrl',
      this,
    );
    fileType = _i1.ColumnEnum(
      'fileType',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    fileSizeBytes = _i1.ColumnInt(
      'fileSizeBytes',
      this,
    );
    category = _i1.ColumnEnum(
      'category',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    relatedDeadlineId = _i1.ColumnInt(
      'relatedDeadlineId',
      this,
    );
    relatedExpenseId = _i1.ColumnInt(
      'relatedExpenseId',
      this,
    );
    ocrDataJson = _i1.ColumnString(
      'ocrDataJson',
      this,
    );
    accessLevel = _i1.ColumnEnum(
      'accessLevel',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
  }

  late final _i1.ColumnInt familyId;

  late final _i1.ColumnInt uploadedBy;

  late final _i1.ColumnString title;

  late final _i1.ColumnString description;

  late final _i1.ColumnString fileUrl;

  late final _i1.ColumnEnum<_i2.DocumentFileType> fileType;

  late final _i1.ColumnInt fileSizeBytes;

  late final _i1.ColumnEnum<_i3.DocumentCategory> category;

  late final _i1.ColumnInt relatedDeadlineId;

  late final _i1.ColumnInt relatedExpenseId;

  late final _i1.ColumnString ocrDataJson;

  late final _i1.ColumnEnum<_i4.DocumentAccessLevel> accessLevel;

  @override
  List<_i1.Column> get columns => [
        id,
        familyId,
        uploadedBy,
        title,
        description,
        fileUrl,
        fileType,
        fileSizeBytes,
        category,
        relatedDeadlineId,
        relatedExpenseId,
        ocrDataJson,
        accessLevel,
      ];
}

class DocumentRecordInclude extends _i1.IncludeObject {
  DocumentRecordInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int> get table => DocumentRecord.t;
}

class DocumentRecordIncludeList extends _i1.IncludeList {
  DocumentRecordIncludeList._({
    _i1.WhereExpressionBuilder<DocumentRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DocumentRecord.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => DocumentRecord.t;
}

class DocumentRecordRepository {
  const DocumentRecordRepository._();

  /// Returns a list of [DocumentRecord]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<DocumentRecord>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DocumentRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DocumentRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DocumentRecordTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<DocumentRecord>(
      where: where?.call(DocumentRecord.t),
      orderBy: orderBy?.call(DocumentRecord.t),
      orderByList: orderByList?.call(DocumentRecord.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [DocumentRecord] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<DocumentRecord?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DocumentRecordTable>? where,
    int? offset,
    _i1.OrderByBuilder<DocumentRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DocumentRecordTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<DocumentRecord>(
      where: where?.call(DocumentRecord.t),
      orderBy: orderBy?.call(DocumentRecord.t),
      orderByList: orderByList?.call(DocumentRecord.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [DocumentRecord] by its [id] or null if no such row exists.
  Future<DocumentRecord?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<DocumentRecord>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [DocumentRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [DocumentRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<DocumentRecord>> insert(
    _i1.Session session,
    List<DocumentRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<DocumentRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [DocumentRecord] and returns the inserted row.
  ///
  /// The returned [DocumentRecord] will have its `id` field set.
  Future<DocumentRecord> insertRow(
    _i1.Session session,
    DocumentRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DocumentRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DocumentRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DocumentRecord>> update(
    _i1.Session session,
    List<DocumentRecord> rows, {
    _i1.ColumnSelections<DocumentRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DocumentRecord>(
      rows,
      columns: columns?.call(DocumentRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DocumentRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DocumentRecord> updateRow(
    _i1.Session session,
    DocumentRecord row, {
    _i1.ColumnSelections<DocumentRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DocumentRecord>(
      row,
      columns: columns?.call(DocumentRecord.t),
      transaction: transaction,
    );
  }

  /// Deletes all [DocumentRecord]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DocumentRecord>> delete(
    _i1.Session session,
    List<DocumentRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DocumentRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DocumentRecord].
  Future<DocumentRecord> deleteRow(
    _i1.Session session,
    DocumentRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DocumentRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DocumentRecord>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<DocumentRecordTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DocumentRecord>(
      where: where(DocumentRecord.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DocumentRecordTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DocumentRecord>(
      where: where?.call(DocumentRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
