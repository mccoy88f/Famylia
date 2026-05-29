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
import 'board_post_type.dart' as _i2;

/// Post bacheca familiare.
abstract class BoardPost
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  BoardPost._({
    this.id,
    required this.familyId,
    required this.createdBy,
    this.title,
    required this.content,
    _i2.BoardPostType? type,
    bool? isPinned,
    this.expiresAt,
    String? reactionsJson,
    String? commentsJson,
  })  : type = type ?? _i2.BoardPostType.note,
        isPinned = isPinned ?? false,
        reactionsJson = reactionsJson ?? '{}',
        commentsJson = commentsJson ?? '[]';

  factory BoardPost({
    int? id,
    required int familyId,
    required int createdBy,
    String? title,
    required String content,
    _i2.BoardPostType? type,
    bool? isPinned,
    DateTime? expiresAt,
    String? reactionsJson,
    String? commentsJson,
  }) = _BoardPostImpl;

  factory BoardPost.fromJson(Map<String, dynamic> jsonSerialization) {
    return BoardPost(
      id: jsonSerialization['id'] as int?,
      familyId: jsonSerialization['familyId'] as int,
      createdBy: jsonSerialization['createdBy'] as int,
      title: jsonSerialization['title'] as String?,
      content: jsonSerialization['content'] as String,
      type: _i2.BoardPostType.fromJson((jsonSerialization['type'] as String)),
      isPinned: jsonSerialization['isPinned'] as bool,
      expiresAt: jsonSerialization['expiresAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
      reactionsJson: jsonSerialization['reactionsJson'] as String,
      commentsJson: jsonSerialization['commentsJson'] as String,
    );
  }

  static final t = BoardPostTable();

  static const db = BoardPostRepository._();

  @override
  int? id;

  int familyId;

  int createdBy;

  String? title;

  String content;

  _i2.BoardPostType type;

  bool isPinned;

  DateTime? expiresAt;

  String reactionsJson;

  String commentsJson;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [BoardPost]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BoardPost copyWith({
    int? id,
    int? familyId,
    int? createdBy,
    String? title,
    String? content,
    _i2.BoardPostType? type,
    bool? isPinned,
    DateTime? expiresAt,
    String? reactionsJson,
    String? commentsJson,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'familyId': familyId,
      'createdBy': createdBy,
      if (title != null) 'title': title,
      'content': content,
      'type': type.toJson(),
      'isPinned': isPinned,
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
      'reactionsJson': reactionsJson,
      'commentsJson': commentsJson,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'familyId': familyId,
      'createdBy': createdBy,
      if (title != null) 'title': title,
      'content': content,
      'type': type.toJson(),
      'isPinned': isPinned,
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
      'reactionsJson': reactionsJson,
      'commentsJson': commentsJson,
    };
  }

  static BoardPostInclude include() {
    return BoardPostInclude._();
  }

  static BoardPostIncludeList includeList({
    _i1.WhereExpressionBuilder<BoardPostTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BoardPostTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BoardPostTable>? orderByList,
    BoardPostInclude? include,
  }) {
    return BoardPostIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BoardPost.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(BoardPost.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BoardPostImpl extends BoardPost {
  _BoardPostImpl({
    int? id,
    required int familyId,
    required int createdBy,
    String? title,
    required String content,
    _i2.BoardPostType? type,
    bool? isPinned,
    DateTime? expiresAt,
    String? reactionsJson,
    String? commentsJson,
  }) : super._(
          id: id,
          familyId: familyId,
          createdBy: createdBy,
          title: title,
          content: content,
          type: type,
          isPinned: isPinned,
          expiresAt: expiresAt,
          reactionsJson: reactionsJson,
          commentsJson: commentsJson,
        );

  /// Returns a shallow copy of this [BoardPost]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BoardPost copyWith({
    Object? id = _Undefined,
    int? familyId,
    int? createdBy,
    Object? title = _Undefined,
    String? content,
    _i2.BoardPostType? type,
    bool? isPinned,
    Object? expiresAt = _Undefined,
    String? reactionsJson,
    String? commentsJson,
  }) {
    return BoardPost(
      id: id is int? ? id : this.id,
      familyId: familyId ?? this.familyId,
      createdBy: createdBy ?? this.createdBy,
      title: title is String? ? title : this.title,
      content: content ?? this.content,
      type: type ?? this.type,
      isPinned: isPinned ?? this.isPinned,
      expiresAt: expiresAt is DateTime? ? expiresAt : this.expiresAt,
      reactionsJson: reactionsJson ?? this.reactionsJson,
      commentsJson: commentsJson ?? this.commentsJson,
    );
  }
}

class BoardPostTable extends _i1.Table<int> {
  BoardPostTable({super.tableRelation}) : super(tableName: 'board_post') {
    familyId = _i1.ColumnInt(
      'familyId',
      this,
    );
    createdBy = _i1.ColumnInt(
      'createdBy',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    content = _i1.ColumnString(
      'content',
      this,
    );
    type = _i1.ColumnEnum(
      'type',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    isPinned = _i1.ColumnBool(
      'isPinned',
      this,
      hasDefault: true,
    );
    expiresAt = _i1.ColumnDateTime(
      'expiresAt',
      this,
    );
    reactionsJson = _i1.ColumnString(
      'reactionsJson',
      this,
      hasDefault: true,
    );
    commentsJson = _i1.ColumnString(
      'commentsJson',
      this,
      hasDefault: true,
    );
  }

  late final _i1.ColumnInt familyId;

  late final _i1.ColumnInt createdBy;

  late final _i1.ColumnString title;

  late final _i1.ColumnString content;

  late final _i1.ColumnEnum<_i2.BoardPostType> type;

  late final _i1.ColumnBool isPinned;

  late final _i1.ColumnDateTime expiresAt;

  late final _i1.ColumnString reactionsJson;

  late final _i1.ColumnString commentsJson;

  @override
  List<_i1.Column> get columns => [
        id,
        familyId,
        createdBy,
        title,
        content,
        type,
        isPinned,
        expiresAt,
        reactionsJson,
        commentsJson,
      ];
}

class BoardPostInclude extends _i1.IncludeObject {
  BoardPostInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int> get table => BoardPost.t;
}

class BoardPostIncludeList extends _i1.IncludeList {
  BoardPostIncludeList._({
    _i1.WhereExpressionBuilder<BoardPostTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(BoardPost.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => BoardPost.t;
}

class BoardPostRepository {
  const BoardPostRepository._();

  /// Returns a list of [BoardPost]s matching the given query parameters.
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
  Future<List<BoardPost>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BoardPostTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BoardPostTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BoardPostTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<BoardPost>(
      where: where?.call(BoardPost.t),
      orderBy: orderBy?.call(BoardPost.t),
      orderByList: orderByList?.call(BoardPost.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [BoardPost] matching the given query parameters.
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
  Future<BoardPost?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BoardPostTable>? where,
    int? offset,
    _i1.OrderByBuilder<BoardPostTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BoardPostTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<BoardPost>(
      where: where?.call(BoardPost.t),
      orderBy: orderBy?.call(BoardPost.t),
      orderByList: orderByList?.call(BoardPost.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [BoardPost] by its [id] or null if no such row exists.
  Future<BoardPost?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<BoardPost>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [BoardPost]s in the list and returns the inserted rows.
  ///
  /// The returned [BoardPost]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<BoardPost>> insert(
    _i1.Session session,
    List<BoardPost> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<BoardPost>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [BoardPost] and returns the inserted row.
  ///
  /// The returned [BoardPost] will have its `id` field set.
  Future<BoardPost> insertRow(
    _i1.Session session,
    BoardPost row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<BoardPost>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [BoardPost]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<BoardPost>> update(
    _i1.Session session,
    List<BoardPost> rows, {
    _i1.ColumnSelections<BoardPostTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<BoardPost>(
      rows,
      columns: columns?.call(BoardPost.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BoardPost]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<BoardPost> updateRow(
    _i1.Session session,
    BoardPost row, {
    _i1.ColumnSelections<BoardPostTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<BoardPost>(
      row,
      columns: columns?.call(BoardPost.t),
      transaction: transaction,
    );
  }

  /// Deletes all [BoardPost]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<BoardPost>> delete(
    _i1.Session session,
    List<BoardPost> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<BoardPost>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [BoardPost].
  Future<BoardPost> deleteRow(
    _i1.Session session,
    BoardPost row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<BoardPost>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<BoardPost>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<BoardPostTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<BoardPost>(
      where: where(BoardPost.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BoardPostTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<BoardPost>(
      where: where?.call(BoardPost.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
