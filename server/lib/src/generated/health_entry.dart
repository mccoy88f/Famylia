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
import 'health_entry_status.dart' as _i2;
import 'health_entry_type.dart' as _i3;
import 'sport_intensity.dart' as _i4;

/// Voce modulo salute: visita medica, dieta o attività sportiva.
abstract class HealthEntry
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  HealthEntry._({
    this.id,
    required this.familyId,
    required this.createdBy,
    required this.type,
    required this.title,
    this.description,
    _i2.HealthEntryStatus? status,
    this.assignedTo,
    this.scheduledAt,
    this.endAt,
    this.providerName,
    this.location,
    this.dietGoal,
    this.caloriesTarget,
    this.sportType,
    this.durationMinutes,
    this.intensity,
    bool? isPrivate,
    this.completedAt,
  })  : status = status ?? _i2.HealthEntryStatus.planned,
        isPrivate = isPrivate ?? false;

  factory HealthEntry({
    int? id,
    required int familyId,
    required int createdBy,
    required _i3.HealthEntryType type,
    required String title,
    String? description,
    _i2.HealthEntryStatus? status,
    int? assignedTo,
    DateTime? scheduledAt,
    DateTime? endAt,
    String? providerName,
    String? location,
    String? dietGoal,
    int? caloriesTarget,
    String? sportType,
    int? durationMinutes,
    _i4.SportIntensity? intensity,
    bool? isPrivate,
    DateTime? completedAt,
  }) = _HealthEntryImpl;

  factory HealthEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return HealthEntry(
      id: jsonSerialization['id'] as int?,
      familyId: jsonSerialization['familyId'] as int,
      createdBy: jsonSerialization['createdBy'] as int,
      type: _i3.HealthEntryType.fromJson((jsonSerialization['type'] as String)),
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      status: _i2.HealthEntryStatus.fromJson(
          (jsonSerialization['status'] as String)),
      assignedTo: jsonSerialization['assignedTo'] as int?,
      scheduledAt: jsonSerialization['scheduledAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['scheduledAt']),
      endAt: jsonSerialization['endAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endAt']),
      providerName: jsonSerialization['providerName'] as String?,
      location: jsonSerialization['location'] as String?,
      dietGoal: jsonSerialization['dietGoal'] as String?,
      caloriesTarget: jsonSerialization['caloriesTarget'] as int?,
      sportType: jsonSerialization['sportType'] as String?,
      durationMinutes: jsonSerialization['durationMinutes'] as int?,
      intensity: jsonSerialization['intensity'] == null
          ? null
          : _i4.SportIntensity.fromJson(
              (jsonSerialization['intensity'] as String)),
      isPrivate: jsonSerialization['isPrivate'] as bool,
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt']),
    );
  }

  static final t = HealthEntryTable();

  static const db = HealthEntryRepository._();

  @override
  int? id;

  int familyId;

  int createdBy;

  _i3.HealthEntryType type;

  String title;

  String? description;

  _i2.HealthEntryStatus status;

  int? assignedTo;

  DateTime? scheduledAt;

  DateTime? endAt;

  String? providerName;

  String? location;

  String? dietGoal;

  int? caloriesTarget;

  String? sportType;

  int? durationMinutes;

  _i4.SportIntensity? intensity;

  bool isPrivate;

  DateTime? completedAt;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [HealthEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  HealthEntry copyWith({
    int? id,
    int? familyId,
    int? createdBy,
    _i3.HealthEntryType? type,
    String? title,
    String? description,
    _i2.HealthEntryStatus? status,
    int? assignedTo,
    DateTime? scheduledAt,
    DateTime? endAt,
    String? providerName,
    String? location,
    String? dietGoal,
    int? caloriesTarget,
    String? sportType,
    int? durationMinutes,
    _i4.SportIntensity? intensity,
    bool? isPrivate,
    DateTime? completedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'familyId': familyId,
      'createdBy': createdBy,
      'type': type.toJson(),
      'title': title,
      if (description != null) 'description': description,
      'status': status.toJson(),
      if (assignedTo != null) 'assignedTo': assignedTo,
      if (scheduledAt != null) 'scheduledAt': scheduledAt?.toJson(),
      if (endAt != null) 'endAt': endAt?.toJson(),
      if (providerName != null) 'providerName': providerName,
      if (location != null) 'location': location,
      if (dietGoal != null) 'dietGoal': dietGoal,
      if (caloriesTarget != null) 'caloriesTarget': caloriesTarget,
      if (sportType != null) 'sportType': sportType,
      if (durationMinutes != null) 'durationMinutes': durationMinutes,
      if (intensity != null) 'intensity': intensity?.toJson(),
      'isPrivate': isPrivate,
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'familyId': familyId,
      'createdBy': createdBy,
      'type': type.toJson(),
      'title': title,
      if (description != null) 'description': description,
      'status': status.toJson(),
      if (assignedTo != null) 'assignedTo': assignedTo,
      if (scheduledAt != null) 'scheduledAt': scheduledAt?.toJson(),
      if (endAt != null) 'endAt': endAt?.toJson(),
      if (providerName != null) 'providerName': providerName,
      if (location != null) 'location': location,
      if (dietGoal != null) 'dietGoal': dietGoal,
      if (caloriesTarget != null) 'caloriesTarget': caloriesTarget,
      if (sportType != null) 'sportType': sportType,
      if (durationMinutes != null) 'durationMinutes': durationMinutes,
      if (intensity != null) 'intensity': intensity?.toJson(),
      'isPrivate': isPrivate,
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
    };
  }

  static HealthEntryInclude include() {
    return HealthEntryInclude._();
  }

  static HealthEntryIncludeList includeList({
    _i1.WhereExpressionBuilder<HealthEntryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<HealthEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<HealthEntryTable>? orderByList,
    HealthEntryInclude? include,
  }) {
    return HealthEntryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(HealthEntry.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(HealthEntry.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _HealthEntryImpl extends HealthEntry {
  _HealthEntryImpl({
    int? id,
    required int familyId,
    required int createdBy,
    required _i3.HealthEntryType type,
    required String title,
    String? description,
    _i2.HealthEntryStatus? status,
    int? assignedTo,
    DateTime? scheduledAt,
    DateTime? endAt,
    String? providerName,
    String? location,
    String? dietGoal,
    int? caloriesTarget,
    String? sportType,
    int? durationMinutes,
    _i4.SportIntensity? intensity,
    bool? isPrivate,
    DateTime? completedAt,
  }) : super._(
          id: id,
          familyId: familyId,
          createdBy: createdBy,
          type: type,
          title: title,
          description: description,
          status: status,
          assignedTo: assignedTo,
          scheduledAt: scheduledAt,
          endAt: endAt,
          providerName: providerName,
          location: location,
          dietGoal: dietGoal,
          caloriesTarget: caloriesTarget,
          sportType: sportType,
          durationMinutes: durationMinutes,
          intensity: intensity,
          isPrivate: isPrivate,
          completedAt: completedAt,
        );

  /// Returns a shallow copy of this [HealthEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  HealthEntry copyWith({
    Object? id = _Undefined,
    int? familyId,
    int? createdBy,
    _i3.HealthEntryType? type,
    String? title,
    Object? description = _Undefined,
    _i2.HealthEntryStatus? status,
    Object? assignedTo = _Undefined,
    Object? scheduledAt = _Undefined,
    Object? endAt = _Undefined,
    Object? providerName = _Undefined,
    Object? location = _Undefined,
    Object? dietGoal = _Undefined,
    Object? caloriesTarget = _Undefined,
    Object? sportType = _Undefined,
    Object? durationMinutes = _Undefined,
    Object? intensity = _Undefined,
    bool? isPrivate,
    Object? completedAt = _Undefined,
  }) {
    return HealthEntry(
      id: id is int? ? id : this.id,
      familyId: familyId ?? this.familyId,
      createdBy: createdBy ?? this.createdBy,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      status: status ?? this.status,
      assignedTo: assignedTo is int? ? assignedTo : this.assignedTo,
      scheduledAt: scheduledAt is DateTime? ? scheduledAt : this.scheduledAt,
      endAt: endAt is DateTime? ? endAt : this.endAt,
      providerName: providerName is String? ? providerName : this.providerName,
      location: location is String? ? location : this.location,
      dietGoal: dietGoal is String? ? dietGoal : this.dietGoal,
      caloriesTarget:
          caloriesTarget is int? ? caloriesTarget : this.caloriesTarget,
      sportType: sportType is String? ? sportType : this.sportType,
      durationMinutes:
          durationMinutes is int? ? durationMinutes : this.durationMinutes,
      intensity: intensity is _i4.SportIntensity? ? intensity : this.intensity,
      isPrivate: isPrivate ?? this.isPrivate,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
    );
  }
}

class HealthEntryTable extends _i1.Table<int> {
  HealthEntryTable({super.tableRelation}) : super(tableName: 'health_entry') {
    familyId = _i1.ColumnInt(
      'familyId',
      this,
    );
    createdBy = _i1.ColumnInt(
      'createdBy',
      this,
    );
    type = _i1.ColumnEnum(
      'type',
      this,
      _i1.EnumSerialization.byName,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    assignedTo = _i1.ColumnInt(
      'assignedTo',
      this,
    );
    scheduledAt = _i1.ColumnDateTime(
      'scheduledAt',
      this,
    );
    endAt = _i1.ColumnDateTime(
      'endAt',
      this,
    );
    providerName = _i1.ColumnString(
      'providerName',
      this,
    );
    location = _i1.ColumnString(
      'location',
      this,
    );
    dietGoal = _i1.ColumnString(
      'dietGoal',
      this,
    );
    caloriesTarget = _i1.ColumnInt(
      'caloriesTarget',
      this,
    );
    sportType = _i1.ColumnString(
      'sportType',
      this,
    );
    durationMinutes = _i1.ColumnInt(
      'durationMinutes',
      this,
    );
    intensity = _i1.ColumnEnum(
      'intensity',
      this,
      _i1.EnumSerialization.byName,
    );
    isPrivate = _i1.ColumnBool(
      'isPrivate',
      this,
      hasDefault: true,
    );
    completedAt = _i1.ColumnDateTime(
      'completedAt',
      this,
    );
  }

  late final _i1.ColumnInt familyId;

  late final _i1.ColumnInt createdBy;

  late final _i1.ColumnEnum<_i3.HealthEntryType> type;

  late final _i1.ColumnString title;

  late final _i1.ColumnString description;

  late final _i1.ColumnEnum<_i2.HealthEntryStatus> status;

  late final _i1.ColumnInt assignedTo;

  late final _i1.ColumnDateTime scheduledAt;

  late final _i1.ColumnDateTime endAt;

  late final _i1.ColumnString providerName;

  late final _i1.ColumnString location;

  late final _i1.ColumnString dietGoal;

  late final _i1.ColumnInt caloriesTarget;

  late final _i1.ColumnString sportType;

  late final _i1.ColumnInt durationMinutes;

  late final _i1.ColumnEnum<_i4.SportIntensity> intensity;

  late final _i1.ColumnBool isPrivate;

  late final _i1.ColumnDateTime completedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        familyId,
        createdBy,
        type,
        title,
        description,
        status,
        assignedTo,
        scheduledAt,
        endAt,
        providerName,
        location,
        dietGoal,
        caloriesTarget,
        sportType,
        durationMinutes,
        intensity,
        isPrivate,
        completedAt,
      ];
}

class HealthEntryInclude extends _i1.IncludeObject {
  HealthEntryInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int> get table => HealthEntry.t;
}

class HealthEntryIncludeList extends _i1.IncludeList {
  HealthEntryIncludeList._({
    _i1.WhereExpressionBuilder<HealthEntryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(HealthEntry.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => HealthEntry.t;
}

class HealthEntryRepository {
  const HealthEntryRepository._();

  /// Returns a list of [HealthEntry]s matching the given query parameters.
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
  Future<List<HealthEntry>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<HealthEntryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<HealthEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<HealthEntryTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<HealthEntry>(
      where: where?.call(HealthEntry.t),
      orderBy: orderBy?.call(HealthEntry.t),
      orderByList: orderByList?.call(HealthEntry.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [HealthEntry] matching the given query parameters.
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
  Future<HealthEntry?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<HealthEntryTable>? where,
    int? offset,
    _i1.OrderByBuilder<HealthEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<HealthEntryTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<HealthEntry>(
      where: where?.call(HealthEntry.t),
      orderBy: orderBy?.call(HealthEntry.t),
      orderByList: orderByList?.call(HealthEntry.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [HealthEntry] by its [id] or null if no such row exists.
  Future<HealthEntry?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<HealthEntry>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [HealthEntry]s in the list and returns the inserted rows.
  ///
  /// The returned [HealthEntry]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<HealthEntry>> insert(
    _i1.Session session,
    List<HealthEntry> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<HealthEntry>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [HealthEntry] and returns the inserted row.
  ///
  /// The returned [HealthEntry] will have its `id` field set.
  Future<HealthEntry> insertRow(
    _i1.Session session,
    HealthEntry row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<HealthEntry>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [HealthEntry]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<HealthEntry>> update(
    _i1.Session session,
    List<HealthEntry> rows, {
    _i1.ColumnSelections<HealthEntryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<HealthEntry>(
      rows,
      columns: columns?.call(HealthEntry.t),
      transaction: transaction,
    );
  }

  /// Updates a single [HealthEntry]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<HealthEntry> updateRow(
    _i1.Session session,
    HealthEntry row, {
    _i1.ColumnSelections<HealthEntryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<HealthEntry>(
      row,
      columns: columns?.call(HealthEntry.t),
      transaction: transaction,
    );
  }

  /// Deletes all [HealthEntry]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<HealthEntry>> delete(
    _i1.Session session,
    List<HealthEntry> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<HealthEntry>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [HealthEntry].
  Future<HealthEntry> deleteRow(
    _i1.Session session,
    HealthEntry row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<HealthEntry>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<HealthEntry>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<HealthEntryTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<HealthEntry>(
      where: where(HealthEntry.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<HealthEntryTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<HealthEntry>(
      where: where?.call(HealthEntry.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
