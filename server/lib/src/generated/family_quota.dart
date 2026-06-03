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

/// Limiti mensili di utilizzo AI per famiglia.
abstract class FamilyQuota
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  FamilyQuota._({
    this.id,
    required this.familyId,
    this.monthlyTokenLimit,
    this.monthlyCostLimitUsd,
    required this.updatedAt,
  });

  factory FamilyQuota({
    int? id,
    required int familyId,
    int? monthlyTokenLimit,
    double? monthlyCostLimitUsd,
    required DateTime updatedAt,
  }) = _FamilyQuotaImpl;

  factory FamilyQuota.fromJson(Map<String, dynamic> jsonSerialization) {
    return FamilyQuota(
      id: jsonSerialization['id'] as int?,
      familyId: jsonSerialization['familyId'] as int,
      monthlyTokenLimit: jsonSerialization['monthlyTokenLimit'] as int?,
      monthlyCostLimitUsd:
          (jsonSerialization['monthlyCostLimitUsd'] as num?)?.toDouble(),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = FamilyQuotaTable();

  static const db = FamilyQuotaRepository._();

  @override
  int? id;

  int familyId;

  int? monthlyTokenLimit;

  double? monthlyCostLimitUsd;

  DateTime updatedAt;

  @override
  _i1.Table<int> get table => t;

  @_i1.useResult
  FamilyQuota copyWith({
    int? id,
    int? familyId,
    int? monthlyTokenLimit,
    double? monthlyCostLimitUsd,
    DateTime? updatedAt,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'familyId': familyId,
      if (monthlyTokenLimit != null) 'monthlyTokenLimit': monthlyTokenLimit,
      if (monthlyCostLimitUsd != null)
        'monthlyCostLimitUsd': monthlyCostLimitUsd,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'familyId': familyId,
      if (monthlyTokenLimit != null) 'monthlyTokenLimit': monthlyTokenLimit,
      if (monthlyCostLimitUsd != null)
        'monthlyCostLimitUsd': monthlyCostLimitUsd,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static FamilyQuotaInclude include() {
    return FamilyQuotaInclude._();
  }

  static FamilyQuotaIncludeList includeList({
    _i1.WhereExpressionBuilder<FamilyQuotaTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FamilyQuotaTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FamilyQuotaTable>? orderByList,
    FamilyQuotaInclude? include,
  }) {
    return FamilyQuotaIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FamilyQuota.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(FamilyQuota.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FamilyQuotaImpl extends FamilyQuota {
  _FamilyQuotaImpl({
    int? id,
    required int familyId,
    int? monthlyTokenLimit,
    double? monthlyCostLimitUsd,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          familyId: familyId,
          monthlyTokenLimit: monthlyTokenLimit,
          monthlyCostLimitUsd: monthlyCostLimitUsd,
          updatedAt: updatedAt,
        );

  @_i1.useResult
  @override
  FamilyQuota copyWith({
    Object? id = _Undefined,
    int? familyId,
    Object? monthlyTokenLimit = _Undefined,
    Object? monthlyCostLimitUsd = _Undefined,
    DateTime? updatedAt,
  }) {
    return FamilyQuota(
      id: id is int? ? id : this.id,
      familyId: familyId ?? this.familyId,
      monthlyTokenLimit:
          monthlyTokenLimit is int? ? monthlyTokenLimit : this.monthlyTokenLimit,
      monthlyCostLimitUsd: monthlyCostLimitUsd is double?
          ? monthlyCostLimitUsd
          : this.monthlyCostLimitUsd,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class FamilyQuotaTable extends _i1.Table<int> {
  FamilyQuotaTable({super.tableRelation}) : super(tableName: 'family_quota') {
    familyId = _i1.ColumnInt(
      'familyId',
      this,
    );
    monthlyTokenLimit = _i1.ColumnInt(
      'monthlyTokenLimit',
      this,
    );
    monthlyCostLimitUsd = _i1.ColumnDouble(
      'monthlyCostLimitUsd',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final _i1.ColumnInt familyId;

  late final _i1.ColumnInt monthlyTokenLimit;

  late final _i1.ColumnDouble monthlyCostLimitUsd;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        familyId,
        monthlyTokenLimit,
        monthlyCostLimitUsd,
        updatedAt,
      ];
}

class FamilyQuotaInclude extends _i1.IncludeObject {
  FamilyQuotaInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int> get table => FamilyQuota.t;
}

class FamilyQuotaIncludeList extends _i1.IncludeList {
  FamilyQuotaIncludeList._({
    _i1.WhereExpressionBuilder<FamilyQuotaTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FamilyQuota.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => FamilyQuota.t;
}

class FamilyQuotaRepository {
  const FamilyQuotaRepository._();

  Future<List<FamilyQuota>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FamilyQuotaTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FamilyQuotaTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FamilyQuotaTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<FamilyQuota>(
      where: where?.call(FamilyQuota.t),
      orderBy: orderBy?.call(FamilyQuota.t),
      orderByList: orderByList?.call(FamilyQuota.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<FamilyQuota?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FamilyQuotaTable>? where,
    int? offset,
    _i1.OrderByBuilder<FamilyQuotaTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FamilyQuotaTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<FamilyQuota>(
      where: where?.call(FamilyQuota.t),
      orderBy: orderBy?.call(FamilyQuota.t),
      orderByList: orderByList?.call(FamilyQuota.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<FamilyQuota?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<FamilyQuota>(
      id,
      transaction: transaction,
    );
  }

  Future<List<FamilyQuota>> insertRows(
    _i1.Session session,
    List<FamilyQuota> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<FamilyQuota>(
      rows,
      transaction: transaction,
    );
  }

  Future<FamilyQuota> insertRow(
    _i1.Session session,
    FamilyQuota row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<FamilyQuota>(
      row,
      transaction: transaction,
    );
  }

  Future<List<FamilyQuota>> updateRows(
    _i1.Session session,
    List<FamilyQuota> rows, {
    _i1.ColumnSelections<FamilyQuotaTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<FamilyQuota>(
      rows,
      columns: columns?.call(FamilyQuota.t),
      transaction: transaction,
    );
  }

  Future<FamilyQuota> updateRow(
    _i1.Session session,
    FamilyQuota row, {
    _i1.ColumnSelections<FamilyQuotaTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<FamilyQuota>(
      row,
      columns: columns?.call(FamilyQuota.t),
      transaction: transaction,
    );
  }

  Future<List<FamilyQuota>> deleteRows(
    _i1.Session session,
    List<FamilyQuota> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<FamilyQuota>(
      rows,
      transaction: transaction,
    );
  }

  Future<FamilyQuota> deleteRow(
    _i1.Session session,
    FamilyQuota row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FamilyQuota>(
      row,
      transaction: transaction,
    );
  }

  Future<List<FamilyQuota>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<FamilyQuotaTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<FamilyQuota>(
      where: where(FamilyQuota.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FamilyQuotaTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<FamilyQuota>(
      where: where?.call(FamilyQuota.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
