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

/// Zona sicura (casa, scuola, lavoro).
abstract class SafeZone
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  SafeZone._({
    this.id,
    required this.familyId,
    required this.createdBy,
    required this.name,
    required this.latitude,
    required this.longitude,
    int? radiusMeters,
    bool? notifyOnEnter,
    bool? notifyOnExit,
  })  : radiusMeters = radiusMeters ?? 100,
        notifyOnEnter = notifyOnEnter ?? true,
        notifyOnExit = notifyOnExit ?? true;

  factory SafeZone({
    int? id,
    required int familyId,
    required int createdBy,
    required String name,
    required double latitude,
    required double longitude,
    int? radiusMeters,
    bool? notifyOnEnter,
    bool? notifyOnExit,
  }) = _SafeZoneImpl;

  factory SafeZone.fromJson(Map<String, dynamic> jsonSerialization) {
    return SafeZone(
      id: jsonSerialization['id'] as int?,
      familyId: jsonSerialization['familyId'] as int,
      createdBy: jsonSerialization['createdBy'] as int,
      name: jsonSerialization['name'] as String,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      radiusMeters: jsonSerialization['radiusMeters'] as int,
      notifyOnEnter: jsonSerialization['notifyOnEnter'] as bool,
      notifyOnExit: jsonSerialization['notifyOnExit'] as bool,
    );
  }

  static final t = SafeZoneTable();

  static const db = SafeZoneRepository._();

  @override
  int? id;

  int familyId;

  int createdBy;

  String name;

  double latitude;

  double longitude;

  int radiusMeters;

  bool notifyOnEnter;

  bool notifyOnExit;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [SafeZone]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SafeZone copyWith({
    int? id,
    int? familyId,
    int? createdBy,
    String? name,
    double? latitude,
    double? longitude,
    int? radiusMeters,
    bool? notifyOnEnter,
    bool? notifyOnExit,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'familyId': familyId,
      'createdBy': createdBy,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'radiusMeters': radiusMeters,
      'notifyOnEnter': notifyOnEnter,
      'notifyOnExit': notifyOnExit,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'familyId': familyId,
      'createdBy': createdBy,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'radiusMeters': radiusMeters,
      'notifyOnEnter': notifyOnEnter,
      'notifyOnExit': notifyOnExit,
    };
  }

  static SafeZoneInclude include() {
    return SafeZoneInclude._();
  }

  static SafeZoneIncludeList includeList({
    _i1.WhereExpressionBuilder<SafeZoneTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SafeZoneTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SafeZoneTable>? orderByList,
    SafeZoneInclude? include,
  }) {
    return SafeZoneIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SafeZone.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SafeZone.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SafeZoneImpl extends SafeZone {
  _SafeZoneImpl({
    int? id,
    required int familyId,
    required int createdBy,
    required String name,
    required double latitude,
    required double longitude,
    int? radiusMeters,
    bool? notifyOnEnter,
    bool? notifyOnExit,
  }) : super._(
          id: id,
          familyId: familyId,
          createdBy: createdBy,
          name: name,
          latitude: latitude,
          longitude: longitude,
          radiusMeters: radiusMeters,
          notifyOnEnter: notifyOnEnter,
          notifyOnExit: notifyOnExit,
        );

  /// Returns a shallow copy of this [SafeZone]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SafeZone copyWith({
    Object? id = _Undefined,
    int? familyId,
    int? createdBy,
    String? name,
    double? latitude,
    double? longitude,
    int? radiusMeters,
    bool? notifyOnEnter,
    bool? notifyOnExit,
  }) {
    return SafeZone(
      id: id is int? ? id : this.id,
      familyId: familyId ?? this.familyId,
      createdBy: createdBy ?? this.createdBy,
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      radiusMeters: radiusMeters ?? this.radiusMeters,
      notifyOnEnter: notifyOnEnter ?? this.notifyOnEnter,
      notifyOnExit: notifyOnExit ?? this.notifyOnExit,
    );
  }
}

class SafeZoneTable extends _i1.Table<int> {
  SafeZoneTable({super.tableRelation}) : super(tableName: 'safe_zone') {
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
    latitude = _i1.ColumnDouble(
      'latitude',
      this,
    );
    longitude = _i1.ColumnDouble(
      'longitude',
      this,
    );
    radiusMeters = _i1.ColumnInt(
      'radiusMeters',
      this,
      hasDefault: true,
    );
    notifyOnEnter = _i1.ColumnBool(
      'notifyOnEnter',
      this,
      hasDefault: true,
    );
    notifyOnExit = _i1.ColumnBool(
      'notifyOnExit',
      this,
      hasDefault: true,
    );
  }

  late final _i1.ColumnInt familyId;

  late final _i1.ColumnInt createdBy;

  late final _i1.ColumnString name;

  late final _i1.ColumnDouble latitude;

  late final _i1.ColumnDouble longitude;

  late final _i1.ColumnInt radiusMeters;

  late final _i1.ColumnBool notifyOnEnter;

  late final _i1.ColumnBool notifyOnExit;

  @override
  List<_i1.Column> get columns => [
        id,
        familyId,
        createdBy,
        name,
        latitude,
        longitude,
        radiusMeters,
        notifyOnEnter,
        notifyOnExit,
      ];
}

class SafeZoneInclude extends _i1.IncludeObject {
  SafeZoneInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int> get table => SafeZone.t;
}

class SafeZoneIncludeList extends _i1.IncludeList {
  SafeZoneIncludeList._({
    _i1.WhereExpressionBuilder<SafeZoneTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SafeZone.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => SafeZone.t;
}

class SafeZoneRepository {
  const SafeZoneRepository._();

  /// Returns a list of [SafeZone]s matching the given query parameters.
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
  Future<List<SafeZone>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SafeZoneTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SafeZoneTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SafeZoneTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SafeZone>(
      where: where?.call(SafeZone.t),
      orderBy: orderBy?.call(SafeZone.t),
      orderByList: orderByList?.call(SafeZone.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [SafeZone] matching the given query parameters.
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
  Future<SafeZone?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SafeZoneTable>? where,
    int? offset,
    _i1.OrderByBuilder<SafeZoneTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SafeZoneTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SafeZone>(
      where: where?.call(SafeZone.t),
      orderBy: orderBy?.call(SafeZone.t),
      orderByList: orderByList?.call(SafeZone.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SafeZone] by its [id] or null if no such row exists.
  Future<SafeZone?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SafeZone>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SafeZone]s in the list and returns the inserted rows.
  ///
  /// The returned [SafeZone]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SafeZone>> insert(
    _i1.Session session,
    List<SafeZone> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SafeZone>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SafeZone] and returns the inserted row.
  ///
  /// The returned [SafeZone] will have its `id` field set.
  Future<SafeZone> insertRow(
    _i1.Session session,
    SafeZone row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SafeZone>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SafeZone]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SafeZone>> update(
    _i1.Session session,
    List<SafeZone> rows, {
    _i1.ColumnSelections<SafeZoneTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SafeZone>(
      rows,
      columns: columns?.call(SafeZone.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SafeZone]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SafeZone> updateRow(
    _i1.Session session,
    SafeZone row, {
    _i1.ColumnSelections<SafeZoneTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SafeZone>(
      row,
      columns: columns?.call(SafeZone.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SafeZone]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SafeZone>> delete(
    _i1.Session session,
    List<SafeZone> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SafeZone>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SafeZone].
  Future<SafeZone> deleteRow(
    _i1.Session session,
    SafeZone row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SafeZone>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SafeZone>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SafeZoneTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SafeZone>(
      where: where(SafeZone.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SafeZoneTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SafeZone>(
      where: where?.call(SafeZone.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
