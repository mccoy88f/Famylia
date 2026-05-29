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

/// Piano pasti settimanale.
abstract class MealPlan
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  MealPlan._({
    this.id,
    required this.familyId,
    required this.createdBy,
    required this.weekStart,
    String? mealsJson,
  }) : mealsJson = mealsJson ?? '[]';

  factory MealPlan({
    int? id,
    required int familyId,
    required int createdBy,
    required DateTime weekStart,
    String? mealsJson,
  }) = _MealPlanImpl;

  factory MealPlan.fromJson(Map<String, dynamic> jsonSerialization) {
    return MealPlan(
      id: jsonSerialization['id'] as int?,
      familyId: jsonSerialization['familyId'] as int,
      createdBy: jsonSerialization['createdBy'] as int,
      weekStart:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['weekStart']),
      mealsJson: jsonSerialization['mealsJson'] as String,
    );
  }

  static final t = MealPlanTable();

  static const db = MealPlanRepository._();

  @override
  int? id;

  int familyId;

  int createdBy;

  DateTime weekStart;

  String mealsJson;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [MealPlan]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MealPlan copyWith({
    int? id,
    int? familyId,
    int? createdBy,
    DateTime? weekStart,
    String? mealsJson,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'familyId': familyId,
      'createdBy': createdBy,
      'weekStart': weekStart.toJson(),
      'mealsJson': mealsJson,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'familyId': familyId,
      'createdBy': createdBy,
      'weekStart': weekStart.toJson(),
      'mealsJson': mealsJson,
    };
  }

  static MealPlanInclude include() {
    return MealPlanInclude._();
  }

  static MealPlanIncludeList includeList({
    _i1.WhereExpressionBuilder<MealPlanTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MealPlanTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MealPlanTable>? orderByList,
    MealPlanInclude? include,
  }) {
    return MealPlanIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MealPlan.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(MealPlan.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MealPlanImpl extends MealPlan {
  _MealPlanImpl({
    int? id,
    required int familyId,
    required int createdBy,
    required DateTime weekStart,
    String? mealsJson,
  }) : super._(
          id: id,
          familyId: familyId,
          createdBy: createdBy,
          weekStart: weekStart,
          mealsJson: mealsJson,
        );

  /// Returns a shallow copy of this [MealPlan]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MealPlan copyWith({
    Object? id = _Undefined,
    int? familyId,
    int? createdBy,
    DateTime? weekStart,
    String? mealsJson,
  }) {
    return MealPlan(
      id: id is int? ? id : this.id,
      familyId: familyId ?? this.familyId,
      createdBy: createdBy ?? this.createdBy,
      weekStart: weekStart ?? this.weekStart,
      mealsJson: mealsJson ?? this.mealsJson,
    );
  }
}

class MealPlanTable extends _i1.Table<int> {
  MealPlanTable({super.tableRelation}) : super(tableName: 'meal_plan') {
    familyId = _i1.ColumnInt(
      'familyId',
      this,
    );
    createdBy = _i1.ColumnInt(
      'createdBy',
      this,
    );
    weekStart = _i1.ColumnDateTime(
      'weekStart',
      this,
    );
    mealsJson = _i1.ColumnString(
      'mealsJson',
      this,
      hasDefault: true,
    );
  }

  late final _i1.ColumnInt familyId;

  late final _i1.ColumnInt createdBy;

  late final _i1.ColumnDateTime weekStart;

  late final _i1.ColumnString mealsJson;

  @override
  List<_i1.Column> get columns => [
        id,
        familyId,
        createdBy,
        weekStart,
        mealsJson,
      ];
}

class MealPlanInclude extends _i1.IncludeObject {
  MealPlanInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int> get table => MealPlan.t;
}

class MealPlanIncludeList extends _i1.IncludeList {
  MealPlanIncludeList._({
    _i1.WhereExpressionBuilder<MealPlanTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MealPlan.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => MealPlan.t;
}

class MealPlanRepository {
  const MealPlanRepository._();

  /// Returns a list of [MealPlan]s matching the given query parameters.
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
  Future<List<MealPlan>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MealPlanTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MealPlanTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MealPlanTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<MealPlan>(
      where: where?.call(MealPlan.t),
      orderBy: orderBy?.call(MealPlan.t),
      orderByList: orderByList?.call(MealPlan.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [MealPlan] matching the given query parameters.
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
  Future<MealPlan?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MealPlanTable>? where,
    int? offset,
    _i1.OrderByBuilder<MealPlanTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MealPlanTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<MealPlan>(
      where: where?.call(MealPlan.t),
      orderBy: orderBy?.call(MealPlan.t),
      orderByList: orderByList?.call(MealPlan.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [MealPlan] by its [id] or null if no such row exists.
  Future<MealPlan?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<MealPlan>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [MealPlan]s in the list and returns the inserted rows.
  ///
  /// The returned [MealPlan]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<MealPlan>> insert(
    _i1.Session session,
    List<MealPlan> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<MealPlan>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [MealPlan] and returns the inserted row.
  ///
  /// The returned [MealPlan] will have its `id` field set.
  Future<MealPlan> insertRow(
    _i1.Session session,
    MealPlan row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<MealPlan>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [MealPlan]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<MealPlan>> update(
    _i1.Session session,
    List<MealPlan> rows, {
    _i1.ColumnSelections<MealPlanTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<MealPlan>(
      rows,
      columns: columns?.call(MealPlan.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MealPlan]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MealPlan> updateRow(
    _i1.Session session,
    MealPlan row, {
    _i1.ColumnSelections<MealPlanTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<MealPlan>(
      row,
      columns: columns?.call(MealPlan.t),
      transaction: transaction,
    );
  }

  /// Deletes all [MealPlan]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<MealPlan>> delete(
    _i1.Session session,
    List<MealPlan> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<MealPlan>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [MealPlan].
  Future<MealPlan> deleteRow(
    _i1.Session session,
    MealPlan row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MealPlan>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<MealPlan>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<MealPlanTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<MealPlan>(
      where: where(MealPlan.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MealPlanTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<MealPlan>(
      where: where?.call(MealPlan.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
