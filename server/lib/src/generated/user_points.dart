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

/// Punti gamification per membro.
abstract class UserPoints
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  UserPoints._({
    this.id,
    required this.userId,
    required this.familyId,
    int? points,
    int? streakDays,
    String? badgesJson,
  })  : points = points ?? 0,
        streakDays = streakDays ?? 0,
        badgesJson = badgesJson ?? '[]';

  factory UserPoints({
    int? id,
    required int userId,
    required int familyId,
    int? points,
    int? streakDays,
    String? badgesJson,
  }) = _UserPointsImpl;

  factory UserPoints.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserPoints(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      familyId: jsonSerialization['familyId'] as int,
      points: jsonSerialization['points'] as int,
      streakDays: jsonSerialization['streakDays'] as int,
      badgesJson: jsonSerialization['badgesJson'] as String,
    );
  }

  static final t = UserPointsTable();

  static const db = UserPointsRepository._();

  @override
  int? id;

  int userId;

  int familyId;

  int points;

  int streakDays;

  String badgesJson;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [UserPoints]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserPoints copyWith({
    int? id,
    int? userId,
    int? familyId,
    int? points,
    int? streakDays,
    String? badgesJson,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'familyId': familyId,
      'points': points,
      'streakDays': streakDays,
      'badgesJson': badgesJson,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'familyId': familyId,
      'points': points,
      'streakDays': streakDays,
      'badgesJson': badgesJson,
    };
  }

  static UserPointsInclude include() {
    return UserPointsInclude._();
  }

  static UserPointsIncludeList includeList({
    _i1.WhereExpressionBuilder<UserPointsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserPointsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserPointsTable>? orderByList,
    UserPointsInclude? include,
  }) {
    return UserPointsIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserPoints.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(UserPoints.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserPointsImpl extends UserPoints {
  _UserPointsImpl({
    int? id,
    required int userId,
    required int familyId,
    int? points,
    int? streakDays,
    String? badgesJson,
  }) : super._(
          id: id,
          userId: userId,
          familyId: familyId,
          points: points,
          streakDays: streakDays,
          badgesJson: badgesJson,
        );

  /// Returns a shallow copy of this [UserPoints]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserPoints copyWith({
    Object? id = _Undefined,
    int? userId,
    int? familyId,
    int? points,
    int? streakDays,
    String? badgesJson,
  }) {
    return UserPoints(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      familyId: familyId ?? this.familyId,
      points: points ?? this.points,
      streakDays: streakDays ?? this.streakDays,
      badgesJson: badgesJson ?? this.badgesJson,
    );
  }
}

class UserPointsTable extends _i1.Table<int> {
  UserPointsTable({super.tableRelation}) : super(tableName: 'user_points') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    familyId = _i1.ColumnInt(
      'familyId',
      this,
    );
    points = _i1.ColumnInt(
      'points',
      this,
      hasDefault: true,
    );
    streakDays = _i1.ColumnInt(
      'streakDays',
      this,
      hasDefault: true,
    );
    badgesJson = _i1.ColumnString(
      'badgesJson',
      this,
      hasDefault: true,
    );
  }

  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt familyId;

  late final _i1.ColumnInt points;

  late final _i1.ColumnInt streakDays;

  late final _i1.ColumnString badgesJson;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        familyId,
        points,
        streakDays,
        badgesJson,
      ];
}

class UserPointsInclude extends _i1.IncludeObject {
  UserPointsInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int> get table => UserPoints.t;
}

class UserPointsIncludeList extends _i1.IncludeList {
  UserPointsIncludeList._({
    _i1.WhereExpressionBuilder<UserPointsTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserPoints.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => UserPoints.t;
}

class UserPointsRepository {
  const UserPointsRepository._();

  /// Returns a list of [UserPoints]s matching the given query parameters.
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
  Future<List<UserPoints>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserPointsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserPointsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserPointsTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<UserPoints>(
      where: where?.call(UserPoints.t),
      orderBy: orderBy?.call(UserPoints.t),
      orderByList: orderByList?.call(UserPoints.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [UserPoints] matching the given query parameters.
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
  Future<UserPoints?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserPointsTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserPointsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserPointsTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<UserPoints>(
      where: where?.call(UserPoints.t),
      orderBy: orderBy?.call(UserPoints.t),
      orderByList: orderByList?.call(UserPoints.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [UserPoints] by its [id] or null if no such row exists.
  Future<UserPoints?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<UserPoints>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [UserPoints]s in the list and returns the inserted rows.
  ///
  /// The returned [UserPoints]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<UserPoints>> insert(
    _i1.Session session,
    List<UserPoints> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<UserPoints>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [UserPoints] and returns the inserted row.
  ///
  /// The returned [UserPoints] will have its `id` field set.
  Future<UserPoints> insertRow(
    _i1.Session session,
    UserPoints row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserPoints>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [UserPoints]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<UserPoints>> update(
    _i1.Session session,
    List<UserPoints> rows, {
    _i1.ColumnSelections<UserPointsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<UserPoints>(
      rows,
      columns: columns?.call(UserPoints.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserPoints]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserPoints> updateRow(
    _i1.Session session,
    UserPoints row, {
    _i1.ColumnSelections<UserPointsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserPoints>(
      row,
      columns: columns?.call(UserPoints.t),
      transaction: transaction,
    );
  }

  /// Deletes all [UserPoints]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<UserPoints>> delete(
    _i1.Session session,
    List<UserPoints> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<UserPoints>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [UserPoints].
  Future<UserPoints> deleteRow(
    _i1.Session session,
    UserPoints row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserPoints>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<UserPoints>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<UserPointsTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<UserPoints>(
      where: where(UserPoints.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserPointsTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<UserPoints>(
      where: where?.call(UserPoints.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
