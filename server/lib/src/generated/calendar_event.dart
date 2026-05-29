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
import 'calendar_event_category.dart' as _i2;

/// Evento calendario familiare.
abstract class CalendarEvent
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  CalendarEvent._({
    this.id,
    required this.familyId,
    required this.createdBy,
    required this.title,
    this.description,
    _i2.CalendarEventCategory? category,
    required this.startAt,
    this.endAt,
    bool? isAllDay,
    this.location,
    this.assignedTo,
    bool? isPrivate,
    this.color,
    this.reminderMinutesJson,
  })  : category = category ?? _i2.CalendarEventCategory.other,
        isAllDay = isAllDay ?? false,
        isPrivate = isPrivate ?? false;

  factory CalendarEvent({
    int? id,
    required int familyId,
    required int createdBy,
    required String title,
    String? description,
    _i2.CalendarEventCategory? category,
    required DateTime startAt,
    DateTime? endAt,
    bool? isAllDay,
    String? location,
    int? assignedTo,
    bool? isPrivate,
    String? color,
    String? reminderMinutesJson,
  }) = _CalendarEventImpl;

  factory CalendarEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return CalendarEvent(
      id: jsonSerialization['id'] as int?,
      familyId: jsonSerialization['familyId'] as int,
      createdBy: jsonSerialization['createdBy'] as int,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      category: _i2.CalendarEventCategory.fromJson(
          (jsonSerialization['category'] as String)),
      startAt: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startAt']),
      endAt: jsonSerialization['endAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endAt']),
      isAllDay: jsonSerialization['isAllDay'] as bool,
      location: jsonSerialization['location'] as String?,
      assignedTo: jsonSerialization['assignedTo'] as int?,
      isPrivate: jsonSerialization['isPrivate'] as bool,
      color: jsonSerialization['color'] as String?,
      reminderMinutesJson: jsonSerialization['reminderMinutesJson'] as String?,
    );
  }

  static final t = CalendarEventTable();

  static const db = CalendarEventRepository._();

  @override
  int? id;

  int familyId;

  int createdBy;

  String title;

  String? description;

  _i2.CalendarEventCategory category;

  DateTime startAt;

  DateTime? endAt;

  bool isAllDay;

  String? location;

  int? assignedTo;

  bool isPrivate;

  String? color;

  String? reminderMinutesJson;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [CalendarEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CalendarEvent copyWith({
    int? id,
    int? familyId,
    int? createdBy,
    String? title,
    String? description,
    _i2.CalendarEventCategory? category,
    DateTime? startAt,
    DateTime? endAt,
    bool? isAllDay,
    String? location,
    int? assignedTo,
    bool? isPrivate,
    String? color,
    String? reminderMinutesJson,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'familyId': familyId,
      'createdBy': createdBy,
      'title': title,
      if (description != null) 'description': description,
      'category': category.toJson(),
      'startAt': startAt.toJson(),
      if (endAt != null) 'endAt': endAt?.toJson(),
      'isAllDay': isAllDay,
      if (location != null) 'location': location,
      if (assignedTo != null) 'assignedTo': assignedTo,
      'isPrivate': isPrivate,
      if (color != null) 'color': color,
      if (reminderMinutesJson != null)
        'reminderMinutesJson': reminderMinutesJson,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'familyId': familyId,
      'createdBy': createdBy,
      'title': title,
      if (description != null) 'description': description,
      'category': category.toJson(),
      'startAt': startAt.toJson(),
      if (endAt != null) 'endAt': endAt?.toJson(),
      'isAllDay': isAllDay,
      if (location != null) 'location': location,
      if (assignedTo != null) 'assignedTo': assignedTo,
      'isPrivate': isPrivate,
      if (color != null) 'color': color,
      if (reminderMinutesJson != null)
        'reminderMinutesJson': reminderMinutesJson,
    };
  }

  static CalendarEventInclude include() {
    return CalendarEventInclude._();
  }

  static CalendarEventIncludeList includeList({
    _i1.WhereExpressionBuilder<CalendarEventTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CalendarEventTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CalendarEventTable>? orderByList,
    CalendarEventInclude? include,
  }) {
    return CalendarEventIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CalendarEvent.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CalendarEvent.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CalendarEventImpl extends CalendarEvent {
  _CalendarEventImpl({
    int? id,
    required int familyId,
    required int createdBy,
    required String title,
    String? description,
    _i2.CalendarEventCategory? category,
    required DateTime startAt,
    DateTime? endAt,
    bool? isAllDay,
    String? location,
    int? assignedTo,
    bool? isPrivate,
    String? color,
    String? reminderMinutesJson,
  }) : super._(
          id: id,
          familyId: familyId,
          createdBy: createdBy,
          title: title,
          description: description,
          category: category,
          startAt: startAt,
          endAt: endAt,
          isAllDay: isAllDay,
          location: location,
          assignedTo: assignedTo,
          isPrivate: isPrivate,
          color: color,
          reminderMinutesJson: reminderMinutesJson,
        );

  /// Returns a shallow copy of this [CalendarEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CalendarEvent copyWith({
    Object? id = _Undefined,
    int? familyId,
    int? createdBy,
    String? title,
    Object? description = _Undefined,
    _i2.CalendarEventCategory? category,
    DateTime? startAt,
    Object? endAt = _Undefined,
    bool? isAllDay,
    Object? location = _Undefined,
    Object? assignedTo = _Undefined,
    bool? isPrivate,
    Object? color = _Undefined,
    Object? reminderMinutesJson = _Undefined,
  }) {
    return CalendarEvent(
      id: id is int? ? id : this.id,
      familyId: familyId ?? this.familyId,
      createdBy: createdBy ?? this.createdBy,
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      category: category ?? this.category,
      startAt: startAt ?? this.startAt,
      endAt: endAt is DateTime? ? endAt : this.endAt,
      isAllDay: isAllDay ?? this.isAllDay,
      location: location is String? ? location : this.location,
      assignedTo: assignedTo is int? ? assignedTo : this.assignedTo,
      isPrivate: isPrivate ?? this.isPrivate,
      color: color is String? ? color : this.color,
      reminderMinutesJson: reminderMinutesJson is String?
          ? reminderMinutesJson
          : this.reminderMinutesJson,
    );
  }
}

class CalendarEventTable extends _i1.Table<int> {
  CalendarEventTable({super.tableRelation})
      : super(tableName: 'calendar_event') {
    familyId = _i1.ColumnInt(
      'familyId',
      this,
    );
    createdBy = _i1.ColumnInt(
      'createdBy',
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
    category = _i1.ColumnEnum(
      'category',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    startAt = _i1.ColumnDateTime(
      'startAt',
      this,
    );
    endAt = _i1.ColumnDateTime(
      'endAt',
      this,
    );
    isAllDay = _i1.ColumnBool(
      'isAllDay',
      this,
      hasDefault: true,
    );
    location = _i1.ColumnString(
      'location',
      this,
    );
    assignedTo = _i1.ColumnInt(
      'assignedTo',
      this,
    );
    isPrivate = _i1.ColumnBool(
      'isPrivate',
      this,
      hasDefault: true,
    );
    color = _i1.ColumnString(
      'color',
      this,
    );
    reminderMinutesJson = _i1.ColumnString(
      'reminderMinutesJson',
      this,
    );
  }

  late final _i1.ColumnInt familyId;

  late final _i1.ColumnInt createdBy;

  late final _i1.ColumnString title;

  late final _i1.ColumnString description;

  late final _i1.ColumnEnum<_i2.CalendarEventCategory> category;

  late final _i1.ColumnDateTime startAt;

  late final _i1.ColumnDateTime endAt;

  late final _i1.ColumnBool isAllDay;

  late final _i1.ColumnString location;

  late final _i1.ColumnInt assignedTo;

  late final _i1.ColumnBool isPrivate;

  late final _i1.ColumnString color;

  late final _i1.ColumnString reminderMinutesJson;

  @override
  List<_i1.Column> get columns => [
        id,
        familyId,
        createdBy,
        title,
        description,
        category,
        startAt,
        endAt,
        isAllDay,
        location,
        assignedTo,
        isPrivate,
        color,
        reminderMinutesJson,
      ];
}

class CalendarEventInclude extends _i1.IncludeObject {
  CalendarEventInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int> get table => CalendarEvent.t;
}

class CalendarEventIncludeList extends _i1.IncludeList {
  CalendarEventIncludeList._({
    _i1.WhereExpressionBuilder<CalendarEventTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CalendarEvent.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => CalendarEvent.t;
}

class CalendarEventRepository {
  const CalendarEventRepository._();

  /// Returns a list of [CalendarEvent]s matching the given query parameters.
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
  Future<List<CalendarEvent>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CalendarEventTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CalendarEventTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CalendarEventTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<CalendarEvent>(
      where: where?.call(CalendarEvent.t),
      orderBy: orderBy?.call(CalendarEvent.t),
      orderByList: orderByList?.call(CalendarEvent.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [CalendarEvent] matching the given query parameters.
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
  Future<CalendarEvent?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CalendarEventTable>? where,
    int? offset,
    _i1.OrderByBuilder<CalendarEventTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CalendarEventTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<CalendarEvent>(
      where: where?.call(CalendarEvent.t),
      orderBy: orderBy?.call(CalendarEvent.t),
      orderByList: orderByList?.call(CalendarEvent.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [CalendarEvent] by its [id] or null if no such row exists.
  Future<CalendarEvent?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<CalendarEvent>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [CalendarEvent]s in the list and returns the inserted rows.
  ///
  /// The returned [CalendarEvent]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<CalendarEvent>> insert(
    _i1.Session session,
    List<CalendarEvent> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<CalendarEvent>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [CalendarEvent] and returns the inserted row.
  ///
  /// The returned [CalendarEvent] will have its `id` field set.
  Future<CalendarEvent> insertRow(
    _i1.Session session,
    CalendarEvent row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CalendarEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CalendarEvent]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CalendarEvent>> update(
    _i1.Session session,
    List<CalendarEvent> rows, {
    _i1.ColumnSelections<CalendarEventTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CalendarEvent>(
      rows,
      columns: columns?.call(CalendarEvent.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CalendarEvent]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CalendarEvent> updateRow(
    _i1.Session session,
    CalendarEvent row, {
    _i1.ColumnSelections<CalendarEventTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CalendarEvent>(
      row,
      columns: columns?.call(CalendarEvent.t),
      transaction: transaction,
    );
  }

  /// Deletes all [CalendarEvent]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CalendarEvent>> delete(
    _i1.Session session,
    List<CalendarEvent> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CalendarEvent>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CalendarEvent].
  Future<CalendarEvent> deleteRow(
    _i1.Session session,
    CalendarEvent row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CalendarEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CalendarEvent>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CalendarEventTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CalendarEvent>(
      where: where(CalendarEvent.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CalendarEventTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CalendarEvent>(
      where: where?.call(CalendarEvent.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
