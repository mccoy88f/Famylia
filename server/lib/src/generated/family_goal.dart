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
import 'family_goal_status.dart' as _i2;

/// Obiettivo con premio in denaro per un membro della famiglia.
abstract class FamilyGoal
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  FamilyGoal._({
    this.id,
    required this.familyId,
    required this.createdBy,
    required this.targetUserId,
    required this.title,
    this.description,
    required this.targetPoints,
    required this.rewardAmount,
    this.deadline,
    _i2.FamilyGoalStatus? status,
    this.completedAt,
    this.paidAt,
    this.paidBy,
  }) : status = status ?? _i2.FamilyGoalStatus.active;

  factory FamilyGoal({
    int? id,
    required int familyId,
    required int createdBy,
    required int targetUserId,
    required String title,
    String? description,
    required int targetPoints,
    required double rewardAmount,
    DateTime? deadline,
    _i2.FamilyGoalStatus? status,
    DateTime? completedAt,
    DateTime? paidAt,
    int? paidBy,
  }) = _FamilyGoalImpl;

  factory FamilyGoal.fromJson(Map<String, dynamic> jsonSerialization) {
    return FamilyGoal(
      id: jsonSerialization['id'] as int?,
      familyId: jsonSerialization['familyId'] as int,
      createdBy: jsonSerialization['createdBy'] as int,
      targetUserId: jsonSerialization['targetUserId'] as int,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      targetPoints: jsonSerialization['targetPoints'] as int,
      rewardAmount: (jsonSerialization['rewardAmount'] as num).toDouble(),
      deadline: jsonSerialization['deadline'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['deadline']),
      status: _i2.FamilyGoalStatus.fromJson(
          (jsonSerialization['status'] as String)),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt']),
      paidAt: jsonSerialization['paidAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['paidAt']),
      paidBy: jsonSerialization['paidBy'] as int?,
    );
  }

  static final t = FamilyGoalTable();

  static const db = FamilyGoalRepository._();

  @override
  int? id;

  int familyId;

  int createdBy;

  int targetUserId;

  String title;

  String? description;

  int targetPoints;

  double rewardAmount;

  DateTime? deadline;

  _i2.FamilyGoalStatus status;

  DateTime? completedAt;

  DateTime? paidAt;

  int? paidBy;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [FamilyGoal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FamilyGoal copyWith({
    int? id,
    int? familyId,
    int? createdBy,
    int? targetUserId,
    String? title,
    String? description,
    int? targetPoints,
    double? rewardAmount,
    DateTime? deadline,
    _i2.FamilyGoalStatus? status,
    DateTime? completedAt,
    DateTime? paidAt,
    int? paidBy,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'familyId': familyId,
      'createdBy': createdBy,
      'targetUserId': targetUserId,
      'title': title,
      if (description != null) 'description': description,
      'targetPoints': targetPoints,
      'rewardAmount': rewardAmount,
      if (deadline != null) 'deadline': deadline?.toJson(),
      'status': status.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (paidAt != null) 'paidAt': paidAt?.toJson(),
      if (paidBy != null) 'paidBy': paidBy,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'familyId': familyId,
      'createdBy': createdBy,
      'targetUserId': targetUserId,
      'title': title,
      if (description != null) 'description': description,
      'targetPoints': targetPoints,
      'rewardAmount': rewardAmount,
      if (deadline != null) 'deadline': deadline?.toJson(),
      'status': status.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (paidAt != null) 'paidAt': paidAt?.toJson(),
      if (paidBy != null) 'paidBy': paidBy,
    };
  }

  static FamilyGoalInclude include() {
    return FamilyGoalInclude._();
  }

  static FamilyGoalIncludeList includeList({
    _i1.WhereExpressionBuilder<FamilyGoalTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FamilyGoalTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FamilyGoalTable>? orderByList,
    FamilyGoalInclude? include,
  }) {
    return FamilyGoalIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FamilyGoal.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(FamilyGoal.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FamilyGoalImpl extends FamilyGoal {
  _FamilyGoalImpl({
    int? id,
    required int familyId,
    required int createdBy,
    required int targetUserId,
    required String title,
    String? description,
    required int targetPoints,
    required double rewardAmount,
    DateTime? deadline,
    _i2.FamilyGoalStatus? status,
    DateTime? completedAt,
    DateTime? paidAt,
    int? paidBy,
  }) : super._(
          id: id,
          familyId: familyId,
          createdBy: createdBy,
          targetUserId: targetUserId,
          title: title,
          description: description,
          targetPoints: targetPoints,
          rewardAmount: rewardAmount,
          deadline: deadline,
          status: status,
          completedAt: completedAt,
          paidAt: paidAt,
          paidBy: paidBy,
        );

  /// Returns a shallow copy of this [FamilyGoal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FamilyGoal copyWith({
    Object? id = _Undefined,
    int? familyId,
    int? createdBy,
    int? targetUserId,
    String? title,
    Object? description = _Undefined,
    int? targetPoints,
    double? rewardAmount,
    Object? deadline = _Undefined,
    _i2.FamilyGoalStatus? status,
    Object? completedAt = _Undefined,
    Object? paidAt = _Undefined,
    Object? paidBy = _Undefined,
  }) {
    return FamilyGoal(
      id: id is int? ? id : this.id,
      familyId: familyId ?? this.familyId,
      createdBy: createdBy ?? this.createdBy,
      targetUserId: targetUserId ?? this.targetUserId,
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      targetPoints: targetPoints ?? this.targetPoints,
      rewardAmount: rewardAmount ?? this.rewardAmount,
      deadline: deadline is DateTime? ? deadline : this.deadline,
      status: status ?? this.status,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
      paidAt: paidAt is DateTime? ? paidAt : this.paidAt,
      paidBy: paidBy is int? ? paidBy : this.paidBy,
    );
  }
}

class FamilyGoalTable extends _i1.Table<int> {
  FamilyGoalTable({super.tableRelation}) : super(tableName: 'family_goal') {
    familyId = _i1.ColumnInt(
      'familyId',
      this,
    );
    createdBy = _i1.ColumnInt(
      'createdBy',
      this,
    );
    targetUserId = _i1.ColumnInt(
      'targetUserId',
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
    targetPoints = _i1.ColumnInt(
      'targetPoints',
      this,
    );
    rewardAmount = _i1.ColumnDouble(
      'rewardAmount',
      this,
    );
    deadline = _i1.ColumnDateTime(
      'deadline',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    completedAt = _i1.ColumnDateTime(
      'completedAt',
      this,
    );
    paidAt = _i1.ColumnDateTime(
      'paidAt',
      this,
    );
    paidBy = _i1.ColumnInt(
      'paidBy',
      this,
    );
  }

  late final _i1.ColumnInt familyId;

  late final _i1.ColumnInt createdBy;

  late final _i1.ColumnInt targetUserId;

  late final _i1.ColumnString title;

  late final _i1.ColumnString description;

  late final _i1.ColumnInt targetPoints;

  late final _i1.ColumnDouble rewardAmount;

  late final _i1.ColumnDateTime deadline;

  late final _i1.ColumnEnum<_i2.FamilyGoalStatus> status;

  late final _i1.ColumnDateTime completedAt;

  late final _i1.ColumnDateTime paidAt;

  late final _i1.ColumnInt paidBy;

  @override
  List<_i1.Column> get columns => [
        id,
        familyId,
        createdBy,
        targetUserId,
        title,
        description,
        targetPoints,
        rewardAmount,
        deadline,
        status,
        completedAt,
        paidAt,
        paidBy,
      ];
}

class FamilyGoalInclude extends _i1.IncludeObject {
  FamilyGoalInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int> get table => FamilyGoal.t;
}

class FamilyGoalIncludeList extends _i1.IncludeList {
  FamilyGoalIncludeList._({
    _i1.WhereExpressionBuilder<FamilyGoalTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FamilyGoal.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => FamilyGoal.t;
}

class FamilyGoalRepository {
  const FamilyGoalRepository._();

  /// Returns a list of [FamilyGoal]s matching the given query parameters.
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
  Future<List<FamilyGoal>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FamilyGoalTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FamilyGoalTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FamilyGoalTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<FamilyGoal>(
      where: where?.call(FamilyGoal.t),
      orderBy: orderBy?.call(FamilyGoal.t),
      orderByList: orderByList?.call(FamilyGoal.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [FamilyGoal] matching the given query parameters.
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
  Future<FamilyGoal?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FamilyGoalTable>? where,
    int? offset,
    _i1.OrderByBuilder<FamilyGoalTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FamilyGoalTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<FamilyGoal>(
      where: where?.call(FamilyGoal.t),
      orderBy: orderBy?.call(FamilyGoal.t),
      orderByList: orderByList?.call(FamilyGoal.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [FamilyGoal] by its [id] or null if no such row exists.
  Future<FamilyGoal?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<FamilyGoal>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [FamilyGoal]s in the list and returns the inserted rows.
  ///
  /// The returned [FamilyGoal]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<FamilyGoal>> insertRows(
    _i1.Session session,
    List<FamilyGoal> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<FamilyGoal>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [FamilyGoal] and returns the inserted row.
  ///
  /// The returned [FamilyGoal] will have its `id` field set.
  Future<FamilyGoal> insertRow(
    _i1.Session session,
    FamilyGoal row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<FamilyGoal>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [FamilyGoal]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<FamilyGoal>> updateRows(
    _i1.Session session,
    List<FamilyGoal> rows, {
    _i1.ColumnSelections<FamilyGoalTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<FamilyGoal>(
      rows,
      columns: columns?.call(FamilyGoal.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FamilyGoal]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FamilyGoal> updateRow(
    _i1.Session session,
    FamilyGoal row, {
    _i1.ColumnSelections<FamilyGoalTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<FamilyGoal>(
      row,
      columns: columns?.call(FamilyGoal.t),
      transaction: transaction,
    );
  }

  /// Deletes all [FamilyGoal]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<FamilyGoal>> deleteRows(
    _i1.Session session,
    List<FamilyGoal> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<FamilyGoal>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [FamilyGoal].
  Future<FamilyGoal> deleteRow(
    _i1.Session session,
    FamilyGoal row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FamilyGoal>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<FamilyGoal>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<FamilyGoalTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<FamilyGoal>(
      where: where(FamilyGoal.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FamilyGoalTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<FamilyGoal>(
      where: where?.call(FamilyGoal.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
