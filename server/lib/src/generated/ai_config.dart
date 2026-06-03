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
import 'ai_provider.dart' as _i2;

/// Configurazione AI globale (singleton).
abstract class AiConfig
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  AiConfig._({
    this.id,
    _i2.AiProvider? provider,
    String? modelName,
    String? systemPrompt,
    required this.updatedAt,
  })  : provider = provider ?? _i2.AiProvider.openrouter,
        modelName = modelName ?? 'google/gemini-flash-1.5',
        systemPrompt = systemPrompt ??
            'Sei MarIA, l\'assistente familiare di Famylia. Analizza il contenuto e rispondi SOLO con JSON valido.';

  factory AiConfig({
    int? id,
    _i2.AiProvider? provider,
    String? modelName,
    String? systemPrompt,
    required DateTime updatedAt,
  }) = _AiConfigImpl;

  factory AiConfig.fromJson(Map<String, dynamic> jsonSerialization) {
    return AiConfig(
      id: jsonSerialization['id'] as int?,
      provider: _i2.AiProvider.fromJson(
          (jsonSerialization['provider'] as String)),
      modelName: jsonSerialization['modelName'] as String,
      systemPrompt: jsonSerialization['systemPrompt'] as String?,
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = AiConfigTable();

  static const db = AiConfigRepository._();

  @override
  int? id;

  _i2.AiProvider provider;

  String modelName;

  String systemPrompt;

  DateTime updatedAt;

  @override
  _i1.Table<int> get table => t;

  @_i1.useResult
  AiConfig copyWith({
    int? id,
    _i2.AiProvider? provider,
    String? modelName,
    String? systemPrompt,
    DateTime? updatedAt,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'provider': provider.toJson(),
      'modelName': modelName,
      'systemPrompt': systemPrompt,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'provider': provider.toJson(),
      'modelName': modelName,
      'systemPrompt': systemPrompt,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static AiConfigInclude include() {
    return AiConfigInclude._();
  }

  static AiConfigIncludeList includeList({
    _i1.WhereExpressionBuilder<AiConfigTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AiConfigTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AiConfigTable>? orderByList,
    AiConfigInclude? include,
  }) {
    return AiConfigIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AiConfig.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AiConfig.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AiConfigImpl extends AiConfig {
  _AiConfigImpl({
    int? id,
    _i2.AiProvider? provider,
    String? modelName,
    String? systemPrompt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          provider: provider,
          modelName: modelName,
          systemPrompt: systemPrompt,
          updatedAt: updatedAt,
        );

  @_i1.useResult
  @override
  AiConfig copyWith({
    Object? id = _Undefined,
    _i2.AiProvider? provider,
    String? modelName,
    String? systemPrompt,
    DateTime? updatedAt,
  }) {
    return AiConfig(
      id: id is int? ? id : this.id,
      provider: provider ?? this.provider,
      modelName: modelName ?? this.modelName,
      systemPrompt: systemPrompt ?? this.systemPrompt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class AiConfigTable extends _i1.Table<int> {
  AiConfigTable({super.tableRelation}) : super(tableName: 'ai_config') {
    provider = _i1.ColumnEnum(
      'provider',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    modelName = _i1.ColumnString(
      'modelName',
      this,
      hasDefault: true,
    );
    systemPrompt = _i1.ColumnString(
      'systemPrompt',
      this,
      hasDefault: true,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final _i1.ColumnEnum<_i2.AiProvider> provider;

  late final _i1.ColumnString modelName;

  late final _i1.ColumnString systemPrompt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        provider,
        modelName,
        systemPrompt,
        updatedAt,
      ];
}

class AiConfigInclude extends _i1.IncludeObject {
  AiConfigInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int> get table => AiConfig.t;
}

class AiConfigIncludeList extends _i1.IncludeList {
  AiConfigIncludeList._({
    _i1.WhereExpressionBuilder<AiConfigTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AiConfig.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => AiConfig.t;
}

class AiConfigRepository {
  const AiConfigRepository._();

  Future<List<AiConfig>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AiConfigTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AiConfigTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AiConfigTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<AiConfig>(
      where: where?.call(AiConfig.t),
      orderBy: orderBy?.call(AiConfig.t),
      orderByList: orderByList?.call(AiConfig.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<AiConfig?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AiConfigTable>? where,
    int? offset,
    _i1.OrderByBuilder<AiConfigTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AiConfigTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<AiConfig>(
      where: where?.call(AiConfig.t),
      orderBy: orderBy?.call(AiConfig.t),
      orderByList: orderByList?.call(AiConfig.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<AiConfig?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<AiConfig>(
      id,
      transaction: transaction,
    );
  }

  Future<List<AiConfig>> insertRows(
    _i1.Session session,
    List<AiConfig> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<AiConfig>(
      rows,
      transaction: transaction,
    );
  }

  Future<AiConfig> insertRow(
    _i1.Session session,
    AiConfig row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AiConfig>(
      row,
      transaction: transaction,
    );
  }

  Future<List<AiConfig>> updateRows(
    _i1.Session session,
    List<AiConfig> rows, {
    _i1.ColumnSelections<AiConfigTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AiConfig>(
      rows,
      columns: columns?.call(AiConfig.t),
      transaction: transaction,
    );
  }

  Future<AiConfig> updateRow(
    _i1.Session session,
    AiConfig row, {
    _i1.ColumnSelections<AiConfigTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AiConfig>(
      row,
      columns: columns?.call(AiConfig.t),
      transaction: transaction,
    );
  }

  Future<List<AiConfig>> deleteRows(
    _i1.Session session,
    List<AiConfig> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AiConfig>(
      rows,
      transaction: transaction,
    );
  }

  Future<AiConfig> deleteRow(
    _i1.Session session,
    AiConfig row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AiConfig>(
      row,
      transaction: transaction,
    );
  }

  Future<List<AiConfig>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<AiConfigTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AiConfig>(
      where: where(AiConfig.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AiConfigTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AiConfig>(
      where: where?.call(AiConfig.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
