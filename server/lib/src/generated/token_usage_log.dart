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

/// Log utilizzo token AI per famiglia.
abstract class TokenUsageLog
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  TokenUsageLog._({
    this.id,
    required this.familyId,
    required this.feature,
    required this.provider,
    required this.modelName,
    required this.inputTokens,
    required this.outputTokens,
    required this.costUsd,
    required this.createdAt,
  });

  factory TokenUsageLog({
    int? id,
    required int familyId,
    required String feature,
    required String provider,
    required String modelName,
    required int inputTokens,
    required int outputTokens,
    required double costUsd,
    required DateTime createdAt,
  }) = _TokenUsageLogImpl;

  factory TokenUsageLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return TokenUsageLog(
      id: jsonSerialization['id'] as int?,
      familyId: jsonSerialization['familyId'] as int,
      feature: jsonSerialization['feature'] as String,
      provider: jsonSerialization['provider'] as String,
      modelName: jsonSerialization['modelName'] as String,
      inputTokens: jsonSerialization['inputTokens'] as int,
      outputTokens: jsonSerialization['outputTokens'] as int,
      costUsd: (jsonSerialization['costUsd'] as num).toDouble(),
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = TokenUsageLogTable();

  static const db = TokenUsageLogRepository._();

  @override
  int? id;

  int familyId;

  String feature;

  String provider;

  String modelName;

  int inputTokens;

  int outputTokens;

  double costUsd;

  DateTime createdAt;

  @override
  _i1.Table<int> get table => t;

  @_i1.useResult
  TokenUsageLog copyWith({
    int? id,
    int? familyId,
    String? feature,
    String? provider,
    String? modelName,
    int? inputTokens,
    int? outputTokens,
    double? costUsd,
    DateTime? createdAt,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'familyId': familyId,
      'feature': feature,
      'provider': provider,
      'modelName': modelName,
      'inputTokens': inputTokens,
      'outputTokens': outputTokens,
      'costUsd': costUsd,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'familyId': familyId,
      'feature': feature,
      'provider': provider,
      'modelName': modelName,
      'inputTokens': inputTokens,
      'outputTokens': outputTokens,
      'costUsd': costUsd,
      'createdAt': createdAt.toJson(),
    };
  }

  static TokenUsageLogInclude include() {
    return TokenUsageLogInclude._();
  }

  static TokenUsageLogIncludeList includeList({
    _i1.WhereExpressionBuilder<TokenUsageLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TokenUsageLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TokenUsageLogTable>? orderByList,
    TokenUsageLogInclude? include,
  }) {
    return TokenUsageLogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TokenUsageLog.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(TokenUsageLog.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TokenUsageLogImpl extends TokenUsageLog {
  _TokenUsageLogImpl({
    int? id,
    required int familyId,
    required String feature,
    required String provider,
    required String modelName,
    required int inputTokens,
    required int outputTokens,
    required double costUsd,
    required DateTime createdAt,
  }) : super._(
          id: id,
          familyId: familyId,
          feature: feature,
          provider: provider,
          modelName: modelName,
          inputTokens: inputTokens,
          outputTokens: outputTokens,
          costUsd: costUsd,
          createdAt: createdAt,
        );

  @_i1.useResult
  @override
  TokenUsageLog copyWith({
    Object? id = _Undefined,
    int? familyId,
    String? feature,
    String? provider,
    String? modelName,
    int? inputTokens,
    int? outputTokens,
    double? costUsd,
    DateTime? createdAt,
  }) {
    return TokenUsageLog(
      id: id is int? ? id : this.id,
      familyId: familyId ?? this.familyId,
      feature: feature ?? this.feature,
      provider: provider ?? this.provider,
      modelName: modelName ?? this.modelName,
      inputTokens: inputTokens ?? this.inputTokens,
      outputTokens: outputTokens ?? this.outputTokens,
      costUsd: costUsd ?? this.costUsd,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class TokenUsageLogTable extends _i1.Table<int> {
  TokenUsageLogTable({super.tableRelation})
      : super(tableName: 'token_usage_log') {
    familyId = _i1.ColumnInt(
      'familyId',
      this,
    );
    feature = _i1.ColumnString(
      'feature',
      this,
    );
    provider = _i1.ColumnString(
      'provider',
      this,
    );
    modelName = _i1.ColumnString(
      'modelName',
      this,
    );
    inputTokens = _i1.ColumnInt(
      'inputTokens',
      this,
    );
    outputTokens = _i1.ColumnInt(
      'outputTokens',
      this,
    );
    costUsd = _i1.ColumnDouble(
      'costUsd',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final _i1.ColumnInt familyId;

  late final _i1.ColumnString feature;

  late final _i1.ColumnString provider;

  late final _i1.ColumnString modelName;

  late final _i1.ColumnInt inputTokens;

  late final _i1.ColumnInt outputTokens;

  late final _i1.ColumnDouble costUsd;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
        id,
        familyId,
        feature,
        provider,
        modelName,
        inputTokens,
        outputTokens,
        costUsd,
        createdAt,
      ];
}

class TokenUsageLogInclude extends _i1.IncludeObject {
  TokenUsageLogInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int> get table => TokenUsageLog.t;
}

class TokenUsageLogIncludeList extends _i1.IncludeList {
  TokenUsageLogIncludeList._({
    _i1.WhereExpressionBuilder<TokenUsageLogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TokenUsageLog.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => TokenUsageLog.t;
}

class TokenUsageLogRepository {
  const TokenUsageLogRepository._();

  Future<List<TokenUsageLog>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TokenUsageLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TokenUsageLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TokenUsageLogTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<TokenUsageLog>(
      where: where?.call(TokenUsageLog.t),
      orderBy: orderBy?.call(TokenUsageLog.t),
      orderByList: orderByList?.call(TokenUsageLog.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<TokenUsageLog?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TokenUsageLogTable>? where,
    int? offset,
    _i1.OrderByBuilder<TokenUsageLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TokenUsageLogTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<TokenUsageLog>(
      where: where?.call(TokenUsageLog.t),
      orderBy: orderBy?.call(TokenUsageLog.t),
      orderByList: orderByList?.call(TokenUsageLog.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<TokenUsageLog?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<TokenUsageLog>(
      id,
      transaction: transaction,
    );
  }

  Future<List<TokenUsageLog>> insertRows(
    _i1.Session session,
    List<TokenUsageLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<TokenUsageLog>(
      rows,
      transaction: transaction,
    );
  }

  Future<TokenUsageLog> insertRow(
    _i1.Session session,
    TokenUsageLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<TokenUsageLog>(
      row,
      transaction: transaction,
    );
  }

  Future<List<TokenUsageLog>> updateRows(
    _i1.Session session,
    List<TokenUsageLog> rows, {
    _i1.ColumnSelections<TokenUsageLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<TokenUsageLog>(
      rows,
      columns: columns?.call(TokenUsageLog.t),
      transaction: transaction,
    );
  }

  Future<TokenUsageLog> updateRow(
    _i1.Session session,
    TokenUsageLog row, {
    _i1.ColumnSelections<TokenUsageLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<TokenUsageLog>(
      row,
      columns: columns?.call(TokenUsageLog.t),
      transaction: transaction,
    );
  }

  Future<List<TokenUsageLog>> deleteRows(
    _i1.Session session,
    List<TokenUsageLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<TokenUsageLog>(
      rows,
      transaction: transaction,
    );
  }

  Future<TokenUsageLog> deleteRow(
    _i1.Session session,
    TokenUsageLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TokenUsageLog>(
      row,
      transaction: transaction,
    );
  }

  Future<List<TokenUsageLog>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<TokenUsageLogTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<TokenUsageLog>(
      where: where(TokenUsageLog.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TokenUsageLogTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<TokenUsageLog>(
      where: where?.call(TokenUsageLog.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
