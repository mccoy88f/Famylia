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
import 'emergency_alert_type.dart' as _i2;
import 'emergency_trigger_method.dart' as _i3;
import 'emergency_alert_status.dart' as _i4;

/// Allerta emergenza familiare.
abstract class EmergencyAlert
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  EmergencyAlert._({
    this.id,
    required this.familyId,
    required this.triggeredBy,
    _i2.EmergencyAlertType? alertType,
    this.customMessage,
    this.locationLat,
    this.locationLng,
    this.locationAddress,
    this.batteryLevel,
    _i3.EmergencyTriggerMethod? triggerMethod,
    _i4.EmergencyAlertStatus? status,
    bool? isTest,
    this.acknowledgedBy,
    this.acknowledgedAt,
    this.resolvedBy,
    this.resolvedAt,
    int? escalationLevel,
  })  : alertType = alertType ?? _i2.EmergencyAlertType.other,
        triggerMethod = triggerMethod ?? _i3.EmergencyTriggerMethod.panicButton,
        status = status ?? _i4.EmergencyAlertStatus.active,
        isTest = isTest ?? false,
        escalationLevel = escalationLevel ?? 1;

  factory EmergencyAlert({
    int? id,
    required int familyId,
    required int triggeredBy,
    _i2.EmergencyAlertType? alertType,
    String? customMessage,
    double? locationLat,
    double? locationLng,
    String? locationAddress,
    int? batteryLevel,
    _i3.EmergencyTriggerMethod? triggerMethod,
    _i4.EmergencyAlertStatus? status,
    bool? isTest,
    int? acknowledgedBy,
    DateTime? acknowledgedAt,
    int? resolvedBy,
    DateTime? resolvedAt,
    int? escalationLevel,
  }) = _EmergencyAlertImpl;

  factory EmergencyAlert.fromJson(Map<String, dynamic> jsonSerialization) {
    return EmergencyAlert(
      id: jsonSerialization['id'] as int?,
      familyId: jsonSerialization['familyId'] as int,
      triggeredBy: jsonSerialization['triggeredBy'] as int,
      alertType: _i2.EmergencyAlertType.fromJson(
          (jsonSerialization['alertType'] as String)),
      customMessage: jsonSerialization['customMessage'] as String?,
      locationLat: (jsonSerialization['locationLat'] as num?)?.toDouble(),
      locationLng: (jsonSerialization['locationLng'] as num?)?.toDouble(),
      locationAddress: jsonSerialization['locationAddress'] as String?,
      batteryLevel: jsonSerialization['batteryLevel'] as int?,
      triggerMethod: _i3.EmergencyTriggerMethod.fromJson(
          (jsonSerialization['triggerMethod'] as String)),
      status: _i4.EmergencyAlertStatus.fromJson(
          (jsonSerialization['status'] as String)),
      isTest: jsonSerialization['isTest'] as bool,
      acknowledgedBy: jsonSerialization['acknowledgedBy'] as int?,
      acknowledgedAt: jsonSerialization['acknowledgedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['acknowledgedAt']),
      resolvedBy: jsonSerialization['resolvedBy'] as int?,
      resolvedAt: jsonSerialization['resolvedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['resolvedAt']),
      escalationLevel: jsonSerialization['escalationLevel'] as int,
    );
  }

  static final t = EmergencyAlertTable();

  static const db = EmergencyAlertRepository._();

  @override
  int? id;

  int familyId;

  int triggeredBy;

  _i2.EmergencyAlertType alertType;

  String? customMessage;

  double? locationLat;

  double? locationLng;

  String? locationAddress;

  int? batteryLevel;

  _i3.EmergencyTriggerMethod triggerMethod;

  _i4.EmergencyAlertStatus status;

  bool isTest;

  int? acknowledgedBy;

  DateTime? acknowledgedAt;

  int? resolvedBy;

  DateTime? resolvedAt;

  int escalationLevel;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [EmergencyAlert]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EmergencyAlert copyWith({
    int? id,
    int? familyId,
    int? triggeredBy,
    _i2.EmergencyAlertType? alertType,
    String? customMessage,
    double? locationLat,
    double? locationLng,
    String? locationAddress,
    int? batteryLevel,
    _i3.EmergencyTriggerMethod? triggerMethod,
    _i4.EmergencyAlertStatus? status,
    bool? isTest,
    int? acknowledgedBy,
    DateTime? acknowledgedAt,
    int? resolvedBy,
    DateTime? resolvedAt,
    int? escalationLevel,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'familyId': familyId,
      'triggeredBy': triggeredBy,
      'alertType': alertType.toJson(),
      if (customMessage != null) 'customMessage': customMessage,
      if (locationLat != null) 'locationLat': locationLat,
      if (locationLng != null) 'locationLng': locationLng,
      if (locationAddress != null) 'locationAddress': locationAddress,
      if (batteryLevel != null) 'batteryLevel': batteryLevel,
      'triggerMethod': triggerMethod.toJson(),
      'status': status.toJson(),
      'isTest': isTest,
      if (acknowledgedBy != null) 'acknowledgedBy': acknowledgedBy,
      if (acknowledgedAt != null) 'acknowledgedAt': acknowledgedAt?.toJson(),
      if (resolvedBy != null) 'resolvedBy': resolvedBy,
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
      'escalationLevel': escalationLevel,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'familyId': familyId,
      'triggeredBy': triggeredBy,
      'alertType': alertType.toJson(),
      if (customMessage != null) 'customMessage': customMessage,
      if (locationLat != null) 'locationLat': locationLat,
      if (locationLng != null) 'locationLng': locationLng,
      if (locationAddress != null) 'locationAddress': locationAddress,
      if (batteryLevel != null) 'batteryLevel': batteryLevel,
      'triggerMethod': triggerMethod.toJson(),
      'status': status.toJson(),
      'isTest': isTest,
      if (acknowledgedBy != null) 'acknowledgedBy': acknowledgedBy,
      if (acknowledgedAt != null) 'acknowledgedAt': acknowledgedAt?.toJson(),
      if (resolvedBy != null) 'resolvedBy': resolvedBy,
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
      'escalationLevel': escalationLevel,
    };
  }

  static EmergencyAlertInclude include() {
    return EmergencyAlertInclude._();
  }

  static EmergencyAlertIncludeList includeList({
    _i1.WhereExpressionBuilder<EmergencyAlertTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EmergencyAlertTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EmergencyAlertTable>? orderByList,
    EmergencyAlertInclude? include,
  }) {
    return EmergencyAlertIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EmergencyAlert.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(EmergencyAlert.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EmergencyAlertImpl extends EmergencyAlert {
  _EmergencyAlertImpl({
    int? id,
    required int familyId,
    required int triggeredBy,
    _i2.EmergencyAlertType? alertType,
    String? customMessage,
    double? locationLat,
    double? locationLng,
    String? locationAddress,
    int? batteryLevel,
    _i3.EmergencyTriggerMethod? triggerMethod,
    _i4.EmergencyAlertStatus? status,
    bool? isTest,
    int? acknowledgedBy,
    DateTime? acknowledgedAt,
    int? resolvedBy,
    DateTime? resolvedAt,
    int? escalationLevel,
  }) : super._(
          id: id,
          familyId: familyId,
          triggeredBy: triggeredBy,
          alertType: alertType,
          customMessage: customMessage,
          locationLat: locationLat,
          locationLng: locationLng,
          locationAddress: locationAddress,
          batteryLevel: batteryLevel,
          triggerMethod: triggerMethod,
          status: status,
          isTest: isTest,
          acknowledgedBy: acknowledgedBy,
          acknowledgedAt: acknowledgedAt,
          resolvedBy: resolvedBy,
          resolvedAt: resolvedAt,
          escalationLevel: escalationLevel,
        );

  /// Returns a shallow copy of this [EmergencyAlert]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EmergencyAlert copyWith({
    Object? id = _Undefined,
    int? familyId,
    int? triggeredBy,
    _i2.EmergencyAlertType? alertType,
    Object? customMessage = _Undefined,
    Object? locationLat = _Undefined,
    Object? locationLng = _Undefined,
    Object? locationAddress = _Undefined,
    Object? batteryLevel = _Undefined,
    _i3.EmergencyTriggerMethod? triggerMethod,
    _i4.EmergencyAlertStatus? status,
    bool? isTest,
    Object? acknowledgedBy = _Undefined,
    Object? acknowledgedAt = _Undefined,
    Object? resolvedBy = _Undefined,
    Object? resolvedAt = _Undefined,
    int? escalationLevel,
  }) {
    return EmergencyAlert(
      id: id is int? ? id : this.id,
      familyId: familyId ?? this.familyId,
      triggeredBy: triggeredBy ?? this.triggeredBy,
      alertType: alertType ?? this.alertType,
      customMessage:
          customMessage is String? ? customMessage : this.customMessage,
      locationLat: locationLat is double? ? locationLat : this.locationLat,
      locationLng: locationLng is double? ? locationLng : this.locationLng,
      locationAddress:
          locationAddress is String? ? locationAddress : this.locationAddress,
      batteryLevel: batteryLevel is int? ? batteryLevel : this.batteryLevel,
      triggerMethod: triggerMethod ?? this.triggerMethod,
      status: status ?? this.status,
      isTest: isTest ?? this.isTest,
      acknowledgedBy:
          acknowledgedBy is int? ? acknowledgedBy : this.acknowledgedBy,
      acknowledgedAt:
          acknowledgedAt is DateTime? ? acknowledgedAt : this.acknowledgedAt,
      resolvedBy: resolvedBy is int? ? resolvedBy : this.resolvedBy,
      resolvedAt: resolvedAt is DateTime? ? resolvedAt : this.resolvedAt,
      escalationLevel: escalationLevel ?? this.escalationLevel,
    );
  }
}

class EmergencyAlertTable extends _i1.Table<int> {
  EmergencyAlertTable({super.tableRelation})
      : super(tableName: 'emergency_alert') {
    familyId = _i1.ColumnInt(
      'familyId',
      this,
    );
    triggeredBy = _i1.ColumnInt(
      'triggeredBy',
      this,
    );
    alertType = _i1.ColumnEnum(
      'alertType',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    customMessage = _i1.ColumnString(
      'customMessage',
      this,
    );
    locationLat = _i1.ColumnDouble(
      'locationLat',
      this,
    );
    locationLng = _i1.ColumnDouble(
      'locationLng',
      this,
    );
    locationAddress = _i1.ColumnString(
      'locationAddress',
      this,
    );
    batteryLevel = _i1.ColumnInt(
      'batteryLevel',
      this,
    );
    triggerMethod = _i1.ColumnEnum(
      'triggerMethod',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    isTest = _i1.ColumnBool(
      'isTest',
      this,
      hasDefault: true,
    );
    acknowledgedBy = _i1.ColumnInt(
      'acknowledgedBy',
      this,
    );
    acknowledgedAt = _i1.ColumnDateTime(
      'acknowledgedAt',
      this,
    );
    resolvedBy = _i1.ColumnInt(
      'resolvedBy',
      this,
    );
    resolvedAt = _i1.ColumnDateTime(
      'resolvedAt',
      this,
    );
    escalationLevel = _i1.ColumnInt(
      'escalationLevel',
      this,
      hasDefault: true,
    );
  }

  late final _i1.ColumnInt familyId;

  late final _i1.ColumnInt triggeredBy;

  late final _i1.ColumnEnum<_i2.EmergencyAlertType> alertType;

  late final _i1.ColumnString customMessage;

  late final _i1.ColumnDouble locationLat;

  late final _i1.ColumnDouble locationLng;

  late final _i1.ColumnString locationAddress;

  late final _i1.ColumnInt batteryLevel;

  late final _i1.ColumnEnum<_i3.EmergencyTriggerMethod> triggerMethod;

  late final _i1.ColumnEnum<_i4.EmergencyAlertStatus> status;

  late final _i1.ColumnBool isTest;

  late final _i1.ColumnInt acknowledgedBy;

  late final _i1.ColumnDateTime acknowledgedAt;

  late final _i1.ColumnInt resolvedBy;

  late final _i1.ColumnDateTime resolvedAt;

  late final _i1.ColumnInt escalationLevel;

  @override
  List<_i1.Column> get columns => [
        id,
        familyId,
        triggeredBy,
        alertType,
        customMessage,
        locationLat,
        locationLng,
        locationAddress,
        batteryLevel,
        triggerMethod,
        status,
        isTest,
        acknowledgedBy,
        acknowledgedAt,
        resolvedBy,
        resolvedAt,
        escalationLevel,
      ];
}

class EmergencyAlertInclude extends _i1.IncludeObject {
  EmergencyAlertInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int> get table => EmergencyAlert.t;
}

class EmergencyAlertIncludeList extends _i1.IncludeList {
  EmergencyAlertIncludeList._({
    _i1.WhereExpressionBuilder<EmergencyAlertTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(EmergencyAlert.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => EmergencyAlert.t;
}

class EmergencyAlertRepository {
  const EmergencyAlertRepository._();

  /// Returns a list of [EmergencyAlert]s matching the given query parameters.
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
  Future<List<EmergencyAlert>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<EmergencyAlertTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EmergencyAlertTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EmergencyAlertTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<EmergencyAlert>(
      where: where?.call(EmergencyAlert.t),
      orderBy: orderBy?.call(EmergencyAlert.t),
      orderByList: orderByList?.call(EmergencyAlert.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [EmergencyAlert] matching the given query parameters.
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
  Future<EmergencyAlert?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<EmergencyAlertTable>? where,
    int? offset,
    _i1.OrderByBuilder<EmergencyAlertTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EmergencyAlertTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<EmergencyAlert>(
      where: where?.call(EmergencyAlert.t),
      orderBy: orderBy?.call(EmergencyAlert.t),
      orderByList: orderByList?.call(EmergencyAlert.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [EmergencyAlert] by its [id] or null if no such row exists.
  Future<EmergencyAlert?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<EmergencyAlert>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [EmergencyAlert]s in the list and returns the inserted rows.
  ///
  /// The returned [EmergencyAlert]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<EmergencyAlert>> insert(
    _i1.Session session,
    List<EmergencyAlert> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<EmergencyAlert>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [EmergencyAlert] and returns the inserted row.
  ///
  /// The returned [EmergencyAlert] will have its `id` field set.
  Future<EmergencyAlert> insertRow(
    _i1.Session session,
    EmergencyAlert row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<EmergencyAlert>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [EmergencyAlert]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<EmergencyAlert>> update(
    _i1.Session session,
    List<EmergencyAlert> rows, {
    _i1.ColumnSelections<EmergencyAlertTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<EmergencyAlert>(
      rows,
      columns: columns?.call(EmergencyAlert.t),
      transaction: transaction,
    );
  }

  /// Updates a single [EmergencyAlert]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<EmergencyAlert> updateRow(
    _i1.Session session,
    EmergencyAlert row, {
    _i1.ColumnSelections<EmergencyAlertTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<EmergencyAlert>(
      row,
      columns: columns?.call(EmergencyAlert.t),
      transaction: transaction,
    );
  }

  /// Deletes all [EmergencyAlert]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<EmergencyAlert>> delete(
    _i1.Session session,
    List<EmergencyAlert> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<EmergencyAlert>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [EmergencyAlert].
  Future<EmergencyAlert> deleteRow(
    _i1.Session session,
    EmergencyAlert row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<EmergencyAlert>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<EmergencyAlert>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<EmergencyAlertTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<EmergencyAlert>(
      where: where(EmergencyAlert.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<EmergencyAlertTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<EmergencyAlert>(
      where: where?.call(EmergencyAlert.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
