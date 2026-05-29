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
import 'family_role.dart' as _i2;

/// Appartenenza utente ↔ famiglia.
abstract class FamilyMember
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  FamilyMember._({
    this.id,
    required this.userId,
    required this.familyId,
    _i2.FamilyRole? role,
  }) : role = role ?? _i2.FamilyRole.member;

  factory FamilyMember({
    int? id,
    required int userId,
    required int familyId,
    _i2.FamilyRole? role,
  }) = _FamilyMemberImpl;

  factory FamilyMember.fromJson(Map<String, dynamic> jsonSerialization) {
    return FamilyMember(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      familyId: jsonSerialization['familyId'] as int,
      role: _i2.FamilyRole.fromJson((jsonSerialization['role'] as String)),
    );
  }

  static final t = FamilyMemberTable();

  static const db = FamilyMemberRepository._();

  @override
  int? id;

  int userId;

  int familyId;

  _i2.FamilyRole role;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [FamilyMember]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FamilyMember copyWith({
    int? id,
    int? userId,
    int? familyId,
    _i2.FamilyRole? role,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'familyId': familyId,
      'role': role.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'familyId': familyId,
      'role': role.toJson(),
    };
  }

  static FamilyMemberInclude include() {
    return FamilyMemberInclude._();
  }

  static FamilyMemberIncludeList includeList({
    _i1.WhereExpressionBuilder<FamilyMemberTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FamilyMemberTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FamilyMemberTable>? orderByList,
    FamilyMemberInclude? include,
  }) {
    return FamilyMemberIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FamilyMember.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(FamilyMember.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FamilyMemberImpl extends FamilyMember {
  _FamilyMemberImpl({
    int? id,
    required int userId,
    required int familyId,
    _i2.FamilyRole? role,
  }) : super._(
          id: id,
          userId: userId,
          familyId: familyId,
          role: role,
        );

  /// Returns a shallow copy of this [FamilyMember]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FamilyMember copyWith({
    Object? id = _Undefined,
    int? userId,
    int? familyId,
    _i2.FamilyRole? role,
  }) {
    return FamilyMember(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      familyId: familyId ?? this.familyId,
      role: role ?? this.role,
    );
  }
}

class FamilyMemberTable extends _i1.Table<int> {
  FamilyMemberTable({super.tableRelation}) : super(tableName: 'family_member') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    familyId = _i1.ColumnInt(
      'familyId',
      this,
    );
    role = _i1.ColumnEnum(
      'role',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
  }

  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt familyId;

  late final _i1.ColumnEnum<_i2.FamilyRole> role;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        familyId,
        role,
      ];
}

class FamilyMemberInclude extends _i1.IncludeObject {
  FamilyMemberInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int> get table => FamilyMember.t;
}

class FamilyMemberIncludeList extends _i1.IncludeList {
  FamilyMemberIncludeList._({
    _i1.WhereExpressionBuilder<FamilyMemberTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FamilyMember.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => FamilyMember.t;
}

class FamilyMemberRepository {
  const FamilyMemberRepository._();

  /// Returns a list of [FamilyMember]s matching the given query parameters.
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
  Future<List<FamilyMember>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FamilyMemberTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FamilyMemberTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FamilyMemberTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<FamilyMember>(
      where: where?.call(FamilyMember.t),
      orderBy: orderBy?.call(FamilyMember.t),
      orderByList: orderByList?.call(FamilyMember.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [FamilyMember] matching the given query parameters.
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
  Future<FamilyMember?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FamilyMemberTable>? where,
    int? offset,
    _i1.OrderByBuilder<FamilyMemberTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FamilyMemberTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<FamilyMember>(
      where: where?.call(FamilyMember.t),
      orderBy: orderBy?.call(FamilyMember.t),
      orderByList: orderByList?.call(FamilyMember.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [FamilyMember] by its [id] or null if no such row exists.
  Future<FamilyMember?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<FamilyMember>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [FamilyMember]s in the list and returns the inserted rows.
  ///
  /// The returned [FamilyMember]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<FamilyMember>> insert(
    _i1.Session session,
    List<FamilyMember> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<FamilyMember>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [FamilyMember] and returns the inserted row.
  ///
  /// The returned [FamilyMember] will have its `id` field set.
  Future<FamilyMember> insertRow(
    _i1.Session session,
    FamilyMember row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<FamilyMember>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [FamilyMember]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<FamilyMember>> update(
    _i1.Session session,
    List<FamilyMember> rows, {
    _i1.ColumnSelections<FamilyMemberTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<FamilyMember>(
      rows,
      columns: columns?.call(FamilyMember.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FamilyMember]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FamilyMember> updateRow(
    _i1.Session session,
    FamilyMember row, {
    _i1.ColumnSelections<FamilyMemberTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<FamilyMember>(
      row,
      columns: columns?.call(FamilyMember.t),
      transaction: transaction,
    );
  }

  /// Deletes all [FamilyMember]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<FamilyMember>> delete(
    _i1.Session session,
    List<FamilyMember> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<FamilyMember>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [FamilyMember].
  Future<FamilyMember> deleteRow(
    _i1.Session session,
    FamilyMember row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FamilyMember>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<FamilyMember>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<FamilyMemberTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<FamilyMember>(
      where: where(FamilyMember.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FamilyMemberTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<FamilyMember>(
      where: where?.call(FamilyMember.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
