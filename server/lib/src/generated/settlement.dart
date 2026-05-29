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
import 'settlement_status.dart' as _i2;

/// Registrazione saldo tra membri.
abstract class Settlement
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  Settlement._({
    this.id,
    required this.familyId,
    required this.fromUserId,
    required this.toUserId,
    required this.amount,
    String? currency,
    _i2.SettlementStatus? status,
    this.settledAt,
  })  : currency = currency ?? 'EUR',
        status = status ?? _i2.SettlementStatus.pending;

  factory Settlement({
    int? id,
    required int familyId,
    required int fromUserId,
    required int toUserId,
    required double amount,
    String? currency,
    _i2.SettlementStatus? status,
    DateTime? settledAt,
  }) = _SettlementImpl;

  factory Settlement.fromJson(Map<String, dynamic> jsonSerialization) {
    return Settlement(
      id: jsonSerialization['id'] as int?,
      familyId: jsonSerialization['familyId'] as int,
      fromUserId: jsonSerialization['fromUserId'] as int,
      toUserId: jsonSerialization['toUserId'] as int,
      amount: (jsonSerialization['amount'] as num).toDouble(),
      currency: jsonSerialization['currency'] as String,
      status: _i2.SettlementStatus.fromJson(
          (jsonSerialization['status'] as String)),
      settledAt: jsonSerialization['settledAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['settledAt']),
    );
  }

  static final t = SettlementTable();

  static const db = SettlementRepository._();

  @override
  int? id;

  int familyId;

  int fromUserId;

  int toUserId;

  double amount;

  String currency;

  _i2.SettlementStatus status;

  DateTime? settledAt;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [Settlement]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Settlement copyWith({
    int? id,
    int? familyId,
    int? fromUserId,
    int? toUserId,
    double? amount,
    String? currency,
    _i2.SettlementStatus? status,
    DateTime? settledAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'familyId': familyId,
      'fromUserId': fromUserId,
      'toUserId': toUserId,
      'amount': amount,
      'currency': currency,
      'status': status.toJson(),
      if (settledAt != null) 'settledAt': settledAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'familyId': familyId,
      'fromUserId': fromUserId,
      'toUserId': toUserId,
      'amount': amount,
      'currency': currency,
      'status': status.toJson(),
      if (settledAt != null) 'settledAt': settledAt?.toJson(),
    };
  }

  static SettlementInclude include() {
    return SettlementInclude._();
  }

  static SettlementIncludeList includeList({
    _i1.WhereExpressionBuilder<SettlementTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SettlementTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SettlementTable>? orderByList,
    SettlementInclude? include,
  }) {
    return SettlementIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Settlement.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Settlement.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SettlementImpl extends Settlement {
  _SettlementImpl({
    int? id,
    required int familyId,
    required int fromUserId,
    required int toUserId,
    required double amount,
    String? currency,
    _i2.SettlementStatus? status,
    DateTime? settledAt,
  }) : super._(
          id: id,
          familyId: familyId,
          fromUserId: fromUserId,
          toUserId: toUserId,
          amount: amount,
          currency: currency,
          status: status,
          settledAt: settledAt,
        );

  /// Returns a shallow copy of this [Settlement]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Settlement copyWith({
    Object? id = _Undefined,
    int? familyId,
    int? fromUserId,
    int? toUserId,
    double? amount,
    String? currency,
    _i2.SettlementStatus? status,
    Object? settledAt = _Undefined,
  }) {
    return Settlement(
      id: id is int? ? id : this.id,
      familyId: familyId ?? this.familyId,
      fromUserId: fromUserId ?? this.fromUserId,
      toUserId: toUserId ?? this.toUserId,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      status: status ?? this.status,
      settledAt: settledAt is DateTime? ? settledAt : this.settledAt,
    );
  }
}

class SettlementTable extends _i1.Table<int> {
  SettlementTable({super.tableRelation}) : super(tableName: 'settlement') {
    familyId = _i1.ColumnInt(
      'familyId',
      this,
    );
    fromUserId = _i1.ColumnInt(
      'fromUserId',
      this,
    );
    toUserId = _i1.ColumnInt(
      'toUserId',
      this,
    );
    amount = _i1.ColumnDouble(
      'amount',
      this,
    );
    currency = _i1.ColumnString(
      'currency',
      this,
      hasDefault: true,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    settledAt = _i1.ColumnDateTime(
      'settledAt',
      this,
    );
  }

  late final _i1.ColumnInt familyId;

  late final _i1.ColumnInt fromUserId;

  late final _i1.ColumnInt toUserId;

  late final _i1.ColumnDouble amount;

  late final _i1.ColumnString currency;

  late final _i1.ColumnEnum<_i2.SettlementStatus> status;

  late final _i1.ColumnDateTime settledAt;

  @override
  List<_i1.Column> get columns => [
        id,
        familyId,
        fromUserId,
        toUserId,
        amount,
        currency,
        status,
        settledAt,
      ];
}

class SettlementInclude extends _i1.IncludeObject {
  SettlementInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int> get table => Settlement.t;
}

class SettlementIncludeList extends _i1.IncludeList {
  SettlementIncludeList._({
    _i1.WhereExpressionBuilder<SettlementTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Settlement.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => Settlement.t;
}

class SettlementRepository {
  const SettlementRepository._();

  /// Returns a list of [Settlement]s matching the given query parameters.
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
  Future<List<Settlement>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SettlementTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SettlementTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SettlementTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Settlement>(
      where: where?.call(Settlement.t),
      orderBy: orderBy?.call(Settlement.t),
      orderByList: orderByList?.call(Settlement.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Settlement] matching the given query parameters.
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
  Future<Settlement?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SettlementTable>? where,
    int? offset,
    _i1.OrderByBuilder<SettlementTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SettlementTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Settlement>(
      where: where?.call(Settlement.t),
      orderBy: orderBy?.call(Settlement.t),
      orderByList: orderByList?.call(Settlement.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Settlement] by its [id] or null if no such row exists.
  Future<Settlement?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Settlement>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Settlement]s in the list and returns the inserted rows.
  ///
  /// The returned [Settlement]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Settlement>> insert(
    _i1.Session session,
    List<Settlement> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Settlement>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Settlement] and returns the inserted row.
  ///
  /// The returned [Settlement] will have its `id` field set.
  Future<Settlement> insertRow(
    _i1.Session session,
    Settlement row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Settlement>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Settlement]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Settlement>> update(
    _i1.Session session,
    List<Settlement> rows, {
    _i1.ColumnSelections<SettlementTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Settlement>(
      rows,
      columns: columns?.call(Settlement.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Settlement]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Settlement> updateRow(
    _i1.Session session,
    Settlement row, {
    _i1.ColumnSelections<SettlementTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Settlement>(
      row,
      columns: columns?.call(Settlement.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Settlement]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Settlement>> delete(
    _i1.Session session,
    List<Settlement> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Settlement>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Settlement].
  Future<Settlement> deleteRow(
    _i1.Session session,
    Settlement row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Settlement>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Settlement>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SettlementTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Settlement>(
      where: where(Settlement.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SettlementTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Settlement>(
      where: where?.call(Settlement.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
