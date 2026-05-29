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

/// Impostazioni emergenza per famiglia.
abstract class EmergencySettings
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  EmergencySettings._({
    this.id,
    required this.familyId,
    bool? panicButtonEnabled,
    bool? requireConfirmation,
    int? confirmationSeconds,
    String? escalationMinutesJson,
  })  : panicButtonEnabled = panicButtonEnabled ?? true,
        requireConfirmation = requireConfirmation ?? true,
        confirmationSeconds = confirmationSeconds ?? 3,
        escalationMinutesJson = escalationMinutesJson ?? '[5,15,30]';

  factory EmergencySettings({
    int? id,
    required int familyId,
    bool? panicButtonEnabled,
    bool? requireConfirmation,
    int? confirmationSeconds,
    String? escalationMinutesJson,
  }) = _EmergencySettingsImpl;

  factory EmergencySettings.fromJson(Map<String, dynamic> jsonSerialization) {
    return EmergencySettings(
      id: jsonSerialization['id'] as int?,
      familyId: jsonSerialization['familyId'] as int,
      panicButtonEnabled: jsonSerialization['panicButtonEnabled'] as bool,
      requireConfirmation: jsonSerialization['requireConfirmation'] as bool,
      confirmationSeconds: jsonSerialization['confirmationSeconds'] as int,
      escalationMinutesJson:
          jsonSerialization['escalationMinutesJson'] as String,
    );
  }

  static final t = EmergencySettingsTable();

  static const db = EmergencySettingsRepository._();

  @override
  int? id;

  int familyId;

  bool panicButtonEnabled;

  bool requireConfirmation;

  int confirmationSeconds;

  String escalationMinutesJson;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [EmergencySettings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EmergencySettings copyWith({
    int? id,
    int? familyId,
    bool? panicButtonEnabled,
    bool? requireConfirmation,
    int? confirmationSeconds,
    String? escalationMinutesJson,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'familyId': familyId,
      'panicButtonEnabled': panicButtonEnabled,
      'requireConfirmation': requireConfirmation,
      'confirmationSeconds': confirmationSeconds,
      'escalationMinutesJson': escalationMinutesJson,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'familyId': familyId,
      'panicButtonEnabled': panicButtonEnabled,
      'requireConfirmation': requireConfirmation,
      'confirmationSeconds': confirmationSeconds,
      'escalationMinutesJson': escalationMinutesJson,
    };
  }

  static EmergencySettingsInclude include() {
    return EmergencySettingsInclude._();
  }

  static EmergencySettingsIncludeList includeList({
    _i1.WhereExpressionBuilder<EmergencySettingsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EmergencySettingsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EmergencySettingsTable>? orderByList,
    EmergencySettingsInclude? include,
  }) {
    return EmergencySettingsIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EmergencySettings.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(EmergencySettings.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EmergencySettingsImpl extends EmergencySettings {
  _EmergencySettingsImpl({
    int? id,
    required int familyId,
    bool? panicButtonEnabled,
    bool? requireConfirmation,
    int? confirmationSeconds,
    String? escalationMinutesJson,
  }) : super._(
          id: id,
          familyId: familyId,
          panicButtonEnabled: panicButtonEnabled,
          requireConfirmation: requireConfirmation,
          confirmationSeconds: confirmationSeconds,
          escalationMinutesJson: escalationMinutesJson,
        );

  /// Returns a shallow copy of this [EmergencySettings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EmergencySettings copyWith({
    Object? id = _Undefined,
    int? familyId,
    bool? panicButtonEnabled,
    bool? requireConfirmation,
    int? confirmationSeconds,
    String? escalationMinutesJson,
  }) {
    return EmergencySettings(
      id: id is int? ? id : this.id,
      familyId: familyId ?? this.familyId,
      panicButtonEnabled: panicButtonEnabled ?? this.panicButtonEnabled,
      requireConfirmation: requireConfirmation ?? this.requireConfirmation,
      confirmationSeconds: confirmationSeconds ?? this.confirmationSeconds,
      escalationMinutesJson:
          escalationMinutesJson ?? this.escalationMinutesJson,
    );
  }
}

class EmergencySettingsTable extends _i1.Table<int> {
  EmergencySettingsTable({super.tableRelation})
      : super(tableName: 'emergency_settings') {
    familyId = _i1.ColumnInt(
      'familyId',
      this,
    );
    panicButtonEnabled = _i1.ColumnBool(
      'panicButtonEnabled',
      this,
      hasDefault: true,
    );
    requireConfirmation = _i1.ColumnBool(
      'requireConfirmation',
      this,
      hasDefault: true,
    );
    confirmationSeconds = _i1.ColumnInt(
      'confirmationSeconds',
      this,
      hasDefault: true,
    );
    escalationMinutesJson = _i1.ColumnString(
      'escalationMinutesJson',
      this,
      hasDefault: true,
    );
  }

  late final _i1.ColumnInt familyId;

  late final _i1.ColumnBool panicButtonEnabled;

  late final _i1.ColumnBool requireConfirmation;

  late final _i1.ColumnInt confirmationSeconds;

  late final _i1.ColumnString escalationMinutesJson;

  @override
  List<_i1.Column> get columns => [
        id,
        familyId,
        panicButtonEnabled,
        requireConfirmation,
        confirmationSeconds,
        escalationMinutesJson,
      ];
}

class EmergencySettingsInclude extends _i1.IncludeObject {
  EmergencySettingsInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int> get table => EmergencySettings.t;
}

class EmergencySettingsIncludeList extends _i1.IncludeList {
  EmergencySettingsIncludeList._({
    _i1.WhereExpressionBuilder<EmergencySettingsTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(EmergencySettings.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => EmergencySettings.t;
}

class EmergencySettingsRepository {
  const EmergencySettingsRepository._();

  /// Returns a list of [EmergencySettings]s matching the given query parameters.
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
  Future<List<EmergencySettings>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<EmergencySettingsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EmergencySettingsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EmergencySettingsTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<EmergencySettings>(
      where: where?.call(EmergencySettings.t),
      orderBy: orderBy?.call(EmergencySettings.t),
      orderByList: orderByList?.call(EmergencySettings.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [EmergencySettings] matching the given query parameters.
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
  Future<EmergencySettings?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<EmergencySettingsTable>? where,
    int? offset,
    _i1.OrderByBuilder<EmergencySettingsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EmergencySettingsTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<EmergencySettings>(
      where: where?.call(EmergencySettings.t),
      orderBy: orderBy?.call(EmergencySettings.t),
      orderByList: orderByList?.call(EmergencySettings.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [EmergencySettings] by its [id] or null if no such row exists.
  Future<EmergencySettings?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<EmergencySettings>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [EmergencySettings]s in the list and returns the inserted rows.
  ///
  /// The returned [EmergencySettings]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<EmergencySettings>> insert(
    _i1.Session session,
    List<EmergencySettings> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<EmergencySettings>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [EmergencySettings] and returns the inserted row.
  ///
  /// The returned [EmergencySettings] will have its `id` field set.
  Future<EmergencySettings> insertRow(
    _i1.Session session,
    EmergencySettings row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<EmergencySettings>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [EmergencySettings]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<EmergencySettings>> update(
    _i1.Session session,
    List<EmergencySettings> rows, {
    _i1.ColumnSelections<EmergencySettingsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<EmergencySettings>(
      rows,
      columns: columns?.call(EmergencySettings.t),
      transaction: transaction,
    );
  }

  /// Updates a single [EmergencySettings]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<EmergencySettings> updateRow(
    _i1.Session session,
    EmergencySettings row, {
    _i1.ColumnSelections<EmergencySettingsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<EmergencySettings>(
      row,
      columns: columns?.call(EmergencySettings.t),
      transaction: transaction,
    );
  }

  /// Deletes all [EmergencySettings]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<EmergencySettings>> delete(
    _i1.Session session,
    List<EmergencySettings> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<EmergencySettings>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [EmergencySettings].
  Future<EmergencySettings> deleteRow(
    _i1.Session session,
    EmergencySettings row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<EmergencySettings>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<EmergencySettings>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<EmergencySettingsTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<EmergencySettings>(
      where: where(EmergencySettings.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<EmergencySettingsTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<EmergencySettings>(
      where: where?.call(EmergencySettings.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
