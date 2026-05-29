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

/// Storico posizione / check-in.
abstract class LocationHistory
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  LocationHistory._({
    this.id,
    required this.userId,
    required this.familyId,
    required this.latitude,
    required this.longitude,
    this.accuracyMeters,
    this.address,
    this.batteryLevel,
    bool? isManualCheckIn,
    required this.recordedAt,
  }) : isManualCheckIn = isManualCheckIn ?? false;

  factory LocationHistory({
    int? id,
    required int userId,
    required int familyId,
    required double latitude,
    required double longitude,
    int? accuracyMeters,
    String? address,
    int? batteryLevel,
    bool? isManualCheckIn,
    required DateTime recordedAt,
  }) = _LocationHistoryImpl;

  factory LocationHistory.fromJson(Map<String, dynamic> jsonSerialization) {
    return LocationHistory(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      familyId: jsonSerialization['familyId'] as int,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      accuracyMeters: jsonSerialization['accuracyMeters'] as int?,
      address: jsonSerialization['address'] as String?,
      batteryLevel: jsonSerialization['batteryLevel'] as int?,
      isManualCheckIn: jsonSerialization['isManualCheckIn'] as bool,
      recordedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['recordedAt']),
    );
  }

  static final t = LocationHistoryTable();

  static const db = LocationHistoryRepository._();

  @override
  int? id;

  int userId;

  int familyId;

  double latitude;

  double longitude;

  int? accuracyMeters;

  String? address;

  int? batteryLevel;

  bool isManualCheckIn;

  DateTime recordedAt;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [LocationHistory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LocationHistory copyWith({
    int? id,
    int? userId,
    int? familyId,
    double? latitude,
    double? longitude,
    int? accuracyMeters,
    String? address,
    int? batteryLevel,
    bool? isManualCheckIn,
    DateTime? recordedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'familyId': familyId,
      'latitude': latitude,
      'longitude': longitude,
      if (accuracyMeters != null) 'accuracyMeters': accuracyMeters,
      if (address != null) 'address': address,
      if (batteryLevel != null) 'batteryLevel': batteryLevel,
      'isManualCheckIn': isManualCheckIn,
      'recordedAt': recordedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'familyId': familyId,
      'latitude': latitude,
      'longitude': longitude,
      if (accuracyMeters != null) 'accuracyMeters': accuracyMeters,
      if (address != null) 'address': address,
      if (batteryLevel != null) 'batteryLevel': batteryLevel,
      'isManualCheckIn': isManualCheckIn,
      'recordedAt': recordedAt.toJson(),
    };
  }

  static LocationHistoryInclude include() {
    return LocationHistoryInclude._();
  }

  static LocationHistoryIncludeList includeList({
    _i1.WhereExpressionBuilder<LocationHistoryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LocationHistoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LocationHistoryTable>? orderByList,
    LocationHistoryInclude? include,
  }) {
    return LocationHistoryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LocationHistory.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(LocationHistory.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LocationHistoryImpl extends LocationHistory {
  _LocationHistoryImpl({
    int? id,
    required int userId,
    required int familyId,
    required double latitude,
    required double longitude,
    int? accuracyMeters,
    String? address,
    int? batteryLevel,
    bool? isManualCheckIn,
    required DateTime recordedAt,
  }) : super._(
          id: id,
          userId: userId,
          familyId: familyId,
          latitude: latitude,
          longitude: longitude,
          accuracyMeters: accuracyMeters,
          address: address,
          batteryLevel: batteryLevel,
          isManualCheckIn: isManualCheckIn,
          recordedAt: recordedAt,
        );

  /// Returns a shallow copy of this [LocationHistory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LocationHistory copyWith({
    Object? id = _Undefined,
    int? userId,
    int? familyId,
    double? latitude,
    double? longitude,
    Object? accuracyMeters = _Undefined,
    Object? address = _Undefined,
    Object? batteryLevel = _Undefined,
    bool? isManualCheckIn,
    DateTime? recordedAt,
  }) {
    return LocationHistory(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      familyId: familyId ?? this.familyId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      accuracyMeters:
          accuracyMeters is int? ? accuracyMeters : this.accuracyMeters,
      address: address is String? ? address : this.address,
      batteryLevel: batteryLevel is int? ? batteryLevel : this.batteryLevel,
      isManualCheckIn: isManualCheckIn ?? this.isManualCheckIn,
      recordedAt: recordedAt ?? this.recordedAt,
    );
  }
}

class LocationHistoryTable extends _i1.Table<int> {
  LocationHistoryTable({super.tableRelation})
      : super(tableName: 'location_history') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    familyId = _i1.ColumnInt(
      'familyId',
      this,
    );
    latitude = _i1.ColumnDouble(
      'latitude',
      this,
    );
    longitude = _i1.ColumnDouble(
      'longitude',
      this,
    );
    accuracyMeters = _i1.ColumnInt(
      'accuracyMeters',
      this,
    );
    address = _i1.ColumnString(
      'address',
      this,
    );
    batteryLevel = _i1.ColumnInt(
      'batteryLevel',
      this,
    );
    isManualCheckIn = _i1.ColumnBool(
      'isManualCheckIn',
      this,
      hasDefault: true,
    );
    recordedAt = _i1.ColumnDateTime(
      'recordedAt',
      this,
    );
  }

  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt familyId;

  late final _i1.ColumnDouble latitude;

  late final _i1.ColumnDouble longitude;

  late final _i1.ColumnInt accuracyMeters;

  late final _i1.ColumnString address;

  late final _i1.ColumnInt batteryLevel;

  late final _i1.ColumnBool isManualCheckIn;

  late final _i1.ColumnDateTime recordedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        familyId,
        latitude,
        longitude,
        accuracyMeters,
        address,
        batteryLevel,
        isManualCheckIn,
        recordedAt,
      ];
}

class LocationHistoryInclude extends _i1.IncludeObject {
  LocationHistoryInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int> get table => LocationHistory.t;
}

class LocationHistoryIncludeList extends _i1.IncludeList {
  LocationHistoryIncludeList._({
    _i1.WhereExpressionBuilder<LocationHistoryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LocationHistory.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => LocationHistory.t;
}

class LocationHistoryRepository {
  const LocationHistoryRepository._();

  /// Returns a list of [LocationHistory]s matching the given query parameters.
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
  Future<List<LocationHistory>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LocationHistoryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LocationHistoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LocationHistoryTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<LocationHistory>(
      where: where?.call(LocationHistory.t),
      orderBy: orderBy?.call(LocationHistory.t),
      orderByList: orderByList?.call(LocationHistory.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [LocationHistory] matching the given query parameters.
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
  Future<LocationHistory?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LocationHistoryTable>? where,
    int? offset,
    _i1.OrderByBuilder<LocationHistoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LocationHistoryTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<LocationHistory>(
      where: where?.call(LocationHistory.t),
      orderBy: orderBy?.call(LocationHistory.t),
      orderByList: orderByList?.call(LocationHistory.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [LocationHistory] by its [id] or null if no such row exists.
  Future<LocationHistory?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<LocationHistory>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [LocationHistory]s in the list and returns the inserted rows.
  ///
  /// The returned [LocationHistory]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<LocationHistory>> insert(
    _i1.Session session,
    List<LocationHistory> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<LocationHistory>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [LocationHistory] and returns the inserted row.
  ///
  /// The returned [LocationHistory] will have its `id` field set.
  Future<LocationHistory> insertRow(
    _i1.Session session,
    LocationHistory row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<LocationHistory>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [LocationHistory]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<LocationHistory>> update(
    _i1.Session session,
    List<LocationHistory> rows, {
    _i1.ColumnSelections<LocationHistoryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<LocationHistory>(
      rows,
      columns: columns?.call(LocationHistory.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LocationHistory]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<LocationHistory> updateRow(
    _i1.Session session,
    LocationHistory row, {
    _i1.ColumnSelections<LocationHistoryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<LocationHistory>(
      row,
      columns: columns?.call(LocationHistory.t),
      transaction: transaction,
    );
  }

  /// Deletes all [LocationHistory]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<LocationHistory>> delete(
    _i1.Session session,
    List<LocationHistory> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<LocationHistory>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [LocationHistory].
  Future<LocationHistory> deleteRow(
    _i1.Session session,
    LocationHistory row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<LocationHistory>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<LocationHistory>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<LocationHistoryTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<LocationHistory>(
      where: where(LocationHistory.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LocationHistoryTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<LocationHistory>(
      where: where?.call(LocationHistory.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
