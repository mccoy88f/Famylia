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
import 'shopping_list_status.dart' as _i2;

/// Lista della spesa.
abstract class ShoppingList
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  ShoppingList._({
    this.id,
    required this.familyId,
    required this.createdBy,
    required this.name,
    this.store,
    _i2.ShoppingListStatus? status,
    this.assignedTo,
    this.dueDate,
  }) : status = status ?? _i2.ShoppingListStatus.active;

  factory ShoppingList({
    int? id,
    required int familyId,
    required int createdBy,
    required String name,
    String? store,
    _i2.ShoppingListStatus? status,
    int? assignedTo,
    DateTime? dueDate,
  }) = _ShoppingListImpl;

  factory ShoppingList.fromJson(Map<String, dynamic> jsonSerialization) {
    return ShoppingList(
      id: jsonSerialization['id'] as int?,
      familyId: jsonSerialization['familyId'] as int,
      createdBy: jsonSerialization['createdBy'] as int,
      name: jsonSerialization['name'] as String,
      store: jsonSerialization['store'] as String?,
      status: _i2.ShoppingListStatus.fromJson(
          (jsonSerialization['status'] as String)),
      assignedTo: jsonSerialization['assignedTo'] as int?,
      dueDate: jsonSerialization['dueDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dueDate']),
    );
  }

  static final t = ShoppingListTable();

  static const db = ShoppingListRepository._();

  @override
  int? id;

  int familyId;

  int createdBy;

  String name;

  String? store;

  _i2.ShoppingListStatus status;

  int? assignedTo;

  DateTime? dueDate;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [ShoppingList]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ShoppingList copyWith({
    int? id,
    int? familyId,
    int? createdBy,
    String? name,
    String? store,
    _i2.ShoppingListStatus? status,
    int? assignedTo,
    DateTime? dueDate,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'familyId': familyId,
      'createdBy': createdBy,
      'name': name,
      if (store != null) 'store': store,
      'status': status.toJson(),
      if (assignedTo != null) 'assignedTo': assignedTo,
      if (dueDate != null) 'dueDate': dueDate?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'familyId': familyId,
      'createdBy': createdBy,
      'name': name,
      if (store != null) 'store': store,
      'status': status.toJson(),
      if (assignedTo != null) 'assignedTo': assignedTo,
      if (dueDate != null) 'dueDate': dueDate?.toJson(),
    };
  }

  static ShoppingListInclude include() {
    return ShoppingListInclude._();
  }

  static ShoppingListIncludeList includeList({
    _i1.WhereExpressionBuilder<ShoppingListTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ShoppingListTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ShoppingListTable>? orderByList,
    ShoppingListInclude? include,
  }) {
    return ShoppingListIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ShoppingList.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ShoppingList.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ShoppingListImpl extends ShoppingList {
  _ShoppingListImpl({
    int? id,
    required int familyId,
    required int createdBy,
    required String name,
    String? store,
    _i2.ShoppingListStatus? status,
    int? assignedTo,
    DateTime? dueDate,
  }) : super._(
          id: id,
          familyId: familyId,
          createdBy: createdBy,
          name: name,
          store: store,
          status: status,
          assignedTo: assignedTo,
          dueDate: dueDate,
        );

  /// Returns a shallow copy of this [ShoppingList]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ShoppingList copyWith({
    Object? id = _Undefined,
    int? familyId,
    int? createdBy,
    String? name,
    Object? store = _Undefined,
    _i2.ShoppingListStatus? status,
    Object? assignedTo = _Undefined,
    Object? dueDate = _Undefined,
  }) {
    return ShoppingList(
      id: id is int? ? id : this.id,
      familyId: familyId ?? this.familyId,
      createdBy: createdBy ?? this.createdBy,
      name: name ?? this.name,
      store: store is String? ? store : this.store,
      status: status ?? this.status,
      assignedTo: assignedTo is int? ? assignedTo : this.assignedTo,
      dueDate: dueDate is DateTime? ? dueDate : this.dueDate,
    );
  }
}

class ShoppingListTable extends _i1.Table<int> {
  ShoppingListTable({super.tableRelation}) : super(tableName: 'shopping_list') {
    familyId = _i1.ColumnInt(
      'familyId',
      this,
    );
    createdBy = _i1.ColumnInt(
      'createdBy',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    store = _i1.ColumnString(
      'store',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    assignedTo = _i1.ColumnInt(
      'assignedTo',
      this,
    );
    dueDate = _i1.ColumnDateTime(
      'dueDate',
      this,
    );
  }

  late final _i1.ColumnInt familyId;

  late final _i1.ColumnInt createdBy;

  late final _i1.ColumnString name;

  late final _i1.ColumnString store;

  late final _i1.ColumnEnum<_i2.ShoppingListStatus> status;

  late final _i1.ColumnInt assignedTo;

  late final _i1.ColumnDateTime dueDate;

  @override
  List<_i1.Column> get columns => [
        id,
        familyId,
        createdBy,
        name,
        store,
        status,
        assignedTo,
        dueDate,
      ];
}

class ShoppingListInclude extends _i1.IncludeObject {
  ShoppingListInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int> get table => ShoppingList.t;
}

class ShoppingListIncludeList extends _i1.IncludeList {
  ShoppingListIncludeList._({
    _i1.WhereExpressionBuilder<ShoppingListTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ShoppingList.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => ShoppingList.t;
}

class ShoppingListRepository {
  const ShoppingListRepository._();

  /// Returns a list of [ShoppingList]s matching the given query parameters.
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
  Future<List<ShoppingList>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ShoppingListTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ShoppingListTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ShoppingListTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ShoppingList>(
      where: where?.call(ShoppingList.t),
      orderBy: orderBy?.call(ShoppingList.t),
      orderByList: orderByList?.call(ShoppingList.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [ShoppingList] matching the given query parameters.
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
  Future<ShoppingList?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ShoppingListTable>? where,
    int? offset,
    _i1.OrderByBuilder<ShoppingListTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ShoppingListTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<ShoppingList>(
      where: where?.call(ShoppingList.t),
      orderBy: orderBy?.call(ShoppingList.t),
      orderByList: orderByList?.call(ShoppingList.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [ShoppingList] by its [id] or null if no such row exists.
  Future<ShoppingList?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<ShoppingList>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [ShoppingList]s in the list and returns the inserted rows.
  ///
  /// The returned [ShoppingList]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ShoppingList>> insert(
    _i1.Session session,
    List<ShoppingList> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ShoppingList>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ShoppingList] and returns the inserted row.
  ///
  /// The returned [ShoppingList] will have its `id` field set.
  Future<ShoppingList> insertRow(
    _i1.Session session,
    ShoppingList row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ShoppingList>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ShoppingList]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ShoppingList>> update(
    _i1.Session session,
    List<ShoppingList> rows, {
    _i1.ColumnSelections<ShoppingListTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ShoppingList>(
      rows,
      columns: columns?.call(ShoppingList.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ShoppingList]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ShoppingList> updateRow(
    _i1.Session session,
    ShoppingList row, {
    _i1.ColumnSelections<ShoppingListTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ShoppingList>(
      row,
      columns: columns?.call(ShoppingList.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ShoppingList]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ShoppingList>> delete(
    _i1.Session session,
    List<ShoppingList> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ShoppingList>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ShoppingList].
  Future<ShoppingList> deleteRow(
    _i1.Session session,
    ShoppingList row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ShoppingList>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ShoppingList>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ShoppingListTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ShoppingList>(
      where: where(ShoppingList.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ShoppingListTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ShoppingList>(
      where: where?.call(ShoppingList.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
