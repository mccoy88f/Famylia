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

/// Opzione sondaggio bacheca.
abstract class PollOption
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  PollOption._({
    this.id,
    required this.boardPostId,
    required this.text,
    String? votesJson,
  }) : votesJson = votesJson ?? '[]';

  factory PollOption({
    int? id,
    required int boardPostId,
    required String text,
    String? votesJson,
  }) = _PollOptionImpl;

  factory PollOption.fromJson(Map<String, dynamic> jsonSerialization) {
    return PollOption(
      id: jsonSerialization['id'] as int?,
      boardPostId: jsonSerialization['boardPostId'] as int,
      text: jsonSerialization['text'] as String,
      votesJson: jsonSerialization['votesJson'] as String,
    );
  }

  static final t = PollOptionTable();

  static const db = PollOptionRepository._();

  @override
  int? id;

  int boardPostId;

  String text;

  String votesJson;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [PollOption]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PollOption copyWith({
    int? id,
    int? boardPostId,
    String? text,
    String? votesJson,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'boardPostId': boardPostId,
      'text': text,
      'votesJson': votesJson,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'boardPostId': boardPostId,
      'text': text,
      'votesJson': votesJson,
    };
  }

  static PollOptionInclude include() {
    return PollOptionInclude._();
  }

  static PollOptionIncludeList includeList({
    _i1.WhereExpressionBuilder<PollOptionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PollOptionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PollOptionTable>? orderByList,
    PollOptionInclude? include,
  }) {
    return PollOptionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PollOption.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PollOption.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PollOptionImpl extends PollOption {
  _PollOptionImpl({
    int? id,
    required int boardPostId,
    required String text,
    String? votesJson,
  }) : super._(
          id: id,
          boardPostId: boardPostId,
          text: text,
          votesJson: votesJson,
        );

  /// Returns a shallow copy of this [PollOption]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PollOption copyWith({
    Object? id = _Undefined,
    int? boardPostId,
    String? text,
    String? votesJson,
  }) {
    return PollOption(
      id: id is int? ? id : this.id,
      boardPostId: boardPostId ?? this.boardPostId,
      text: text ?? this.text,
      votesJson: votesJson ?? this.votesJson,
    );
  }
}

class PollOptionTable extends _i1.Table<int> {
  PollOptionTable({super.tableRelation}) : super(tableName: 'poll_option') {
    boardPostId = _i1.ColumnInt(
      'boardPostId',
      this,
    );
    text = _i1.ColumnString(
      'text',
      this,
    );
    votesJson = _i1.ColumnString(
      'votesJson',
      this,
      hasDefault: true,
    );
  }

  late final _i1.ColumnInt boardPostId;

  late final _i1.ColumnString text;

  late final _i1.ColumnString votesJson;

  @override
  List<_i1.Column> get columns => [
        id,
        boardPostId,
        text,
        votesJson,
      ];
}

class PollOptionInclude extends _i1.IncludeObject {
  PollOptionInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int> get table => PollOption.t;
}

class PollOptionIncludeList extends _i1.IncludeList {
  PollOptionIncludeList._({
    _i1.WhereExpressionBuilder<PollOptionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PollOption.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => PollOption.t;
}

class PollOptionRepository {
  const PollOptionRepository._();

  /// Returns a list of [PollOption]s matching the given query parameters.
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
  Future<List<PollOption>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PollOptionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PollOptionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PollOptionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<PollOption>(
      where: where?.call(PollOption.t),
      orderBy: orderBy?.call(PollOption.t),
      orderByList: orderByList?.call(PollOption.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [PollOption] matching the given query parameters.
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
  Future<PollOption?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PollOptionTable>? where,
    int? offset,
    _i1.OrderByBuilder<PollOptionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PollOptionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<PollOption>(
      where: where?.call(PollOption.t),
      orderBy: orderBy?.call(PollOption.t),
      orderByList: orderByList?.call(PollOption.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [PollOption] by its [id] or null if no such row exists.
  Future<PollOption?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<PollOption>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [PollOption]s in the list and returns the inserted rows.
  ///
  /// The returned [PollOption]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<PollOption>> insert(
    _i1.Session session,
    List<PollOption> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<PollOption>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [PollOption] and returns the inserted row.
  ///
  /// The returned [PollOption] will have its `id` field set.
  Future<PollOption> insertRow(
    _i1.Session session,
    PollOption row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PollOption>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PollOption]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PollOption>> update(
    _i1.Session session,
    List<PollOption> rows, {
    _i1.ColumnSelections<PollOptionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PollOption>(
      rows,
      columns: columns?.call(PollOption.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PollOption]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PollOption> updateRow(
    _i1.Session session,
    PollOption row, {
    _i1.ColumnSelections<PollOptionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PollOption>(
      row,
      columns: columns?.call(PollOption.t),
      transaction: transaction,
    );
  }

  /// Deletes all [PollOption]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PollOption>> delete(
    _i1.Session session,
    List<PollOption> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PollOption>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PollOption].
  Future<PollOption> deleteRow(
    _i1.Session session,
    PollOption row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PollOption>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PollOption>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PollOptionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PollOption>(
      where: where(PollOption.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PollOptionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PollOption>(
      where: where?.call(PollOption.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
