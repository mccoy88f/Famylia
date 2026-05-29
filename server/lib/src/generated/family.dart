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

/// Gruppo familiare Famylia.
abstract class Family implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  Family._({
    this.id,
    required this.name,
    required this.inviteCode,
    this.settings,
  });

  factory Family({
    int? id,
    required String name,
    required String inviteCode,
    String? settings,
  }) = _FamilyImpl;

  factory Family.fromJson(Map<String, dynamic> jsonSerialization) {
    return Family(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      inviteCode: jsonSerialization['inviteCode'] as String,
      settings: jsonSerialization['settings'] as String?,
    );
  }

  static final t = FamilyTable();

  static const db = FamilyRepository._();

  @override
  int? id;

  String name;

  String inviteCode;

  String? settings;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [Family]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Family copyWith({
    int? id,
    String? name,
    String? inviteCode,
    String? settings,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'inviteCode': inviteCode,
      if (settings != null) 'settings': settings,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'inviteCode': inviteCode,
      if (settings != null) 'settings': settings,
    };
  }

  static FamilyInclude include() {
    return FamilyInclude._();
  }

  static FamilyIncludeList includeList({
    _i1.WhereExpressionBuilder<FamilyTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FamilyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FamilyTable>? orderByList,
    FamilyInclude? include,
  }) {
    return FamilyIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Family.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Family.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FamilyImpl extends Family {
  _FamilyImpl({
    int? id,
    required String name,
    required String inviteCode,
    String? settings,
  }) : super._(
          id: id,
          name: name,
          inviteCode: inviteCode,
          settings: settings,
        );

  /// Returns a shallow copy of this [Family]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Family copyWith({
    Object? id = _Undefined,
    String? name,
    String? inviteCode,
    Object? settings = _Undefined,
  }) {
    return Family(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      inviteCode: inviteCode ?? this.inviteCode,
      settings: settings is String? ? settings : this.settings,
    );
  }
}

class FamilyTable extends _i1.Table<int> {
  FamilyTable({super.tableRelation}) : super(tableName: 'family') {
    name = _i1.ColumnString(
      'name',
      this,
    );
    inviteCode = _i1.ColumnString(
      'inviteCode',
      this,
    );
    settings = _i1.ColumnString(
      'settings',
      this,
      hasDefault: true,
    );
  }

  late final _i1.ColumnString name;

  late final _i1.ColumnString inviteCode;

  late final _i1.ColumnString settings;

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        inviteCode,
        settings,
      ];
}

class FamilyInclude extends _i1.IncludeObject {
  FamilyInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int> get table => Family.t;
}

class FamilyIncludeList extends _i1.IncludeList {
  FamilyIncludeList._({
    _i1.WhereExpressionBuilder<FamilyTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Family.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => Family.t;
}

class FamilyRepository {
  const FamilyRepository._();

  /// Returns a list of [Family]s matching the given query parameters.
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
  Future<List<Family>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FamilyTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FamilyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FamilyTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Family>(
      where: where?.call(Family.t),
      orderBy: orderBy?.call(Family.t),
      orderByList: orderByList?.call(Family.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Family] matching the given query parameters.
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
  Future<Family?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FamilyTable>? where,
    int? offset,
    _i1.OrderByBuilder<FamilyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FamilyTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Family>(
      where: where?.call(Family.t),
      orderBy: orderBy?.call(Family.t),
      orderByList: orderByList?.call(Family.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Family] by its [id] or null if no such row exists.
  Future<Family?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Family>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Family]s in the list and returns the inserted rows.
  ///
  /// The returned [Family]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Family>> insert(
    _i1.Session session,
    List<Family> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Family>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Family] and returns the inserted row.
  ///
  /// The returned [Family] will have its `id` field set.
  Future<Family> insertRow(
    _i1.Session session,
    Family row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Family>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Family]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Family>> update(
    _i1.Session session,
    List<Family> rows, {
    _i1.ColumnSelections<FamilyTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Family>(
      rows,
      columns: columns?.call(Family.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Family]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Family> updateRow(
    _i1.Session session,
    Family row, {
    _i1.ColumnSelections<FamilyTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Family>(
      row,
      columns: columns?.call(Family.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Family]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Family>> delete(
    _i1.Session session,
    List<Family> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Family>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Family].
  Future<Family> deleteRow(
    _i1.Session session,
    Family row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Family>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Family>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<FamilyTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Family>(
      where: where(Family.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FamilyTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Family>(
      where: where?.call(Family.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
