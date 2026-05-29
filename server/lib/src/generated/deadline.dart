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
import 'deadline_category.dart' as _i2;
import 'deadline_status.dart' as _i3;
import 'deadline_priority.dart' as _i4;

/// Scadenza o bolletta familiare.
abstract class Deadline
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  Deadline._({
    this.id,
    required this.familyId,
    required this.createdBy,
    required this.title,
    this.description,
    _i2.DeadlineCategory? category,
    this.amount,
    String? currency,
    required this.dueDate,
    bool? isRecurring,
    this.recurrenceRule,
    _i3.DeadlineStatus? status,
    _i4.DeadlinePriority? priority,
    this.assignedTo,
    String? notifyBeforeHoursJson,
    bool? isPrivate,
    this.completedAt,
    this.completedBy,
  })  : category = category ?? _i2.DeadlineCategory.other,
        currency = currency ?? 'EUR',
        isRecurring = isRecurring ?? false,
        status = status ?? _i3.DeadlineStatus.pending,
        priority = priority ?? _i4.DeadlinePriority.medium,
        notifyBeforeHoursJson = notifyBeforeHoursJson ?? '[24,72]',
        isPrivate = isPrivate ?? false;

  factory Deadline({
    int? id,
    required int familyId,
    required int createdBy,
    required String title,
    String? description,
    _i2.DeadlineCategory? category,
    double? amount,
    String? currency,
    required DateTime dueDate,
    bool? isRecurring,
    String? recurrenceRule,
    _i3.DeadlineStatus? status,
    _i4.DeadlinePriority? priority,
    int? assignedTo,
    String? notifyBeforeHoursJson,
    bool? isPrivate,
    DateTime? completedAt,
    int? completedBy,
  }) = _DeadlineImpl;

  factory Deadline.fromJson(Map<String, dynamic> jsonSerialization) {
    return Deadline(
      id: jsonSerialization['id'] as int?,
      familyId: jsonSerialization['familyId'] as int,
      createdBy: jsonSerialization['createdBy'] as int,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      category: _i2.DeadlineCategory.fromJson(
          (jsonSerialization['category'] as String)),
      amount: (jsonSerialization['amount'] as num?)?.toDouble(),
      currency: jsonSerialization['currency'] as String,
      dueDate: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dueDate']),
      isRecurring: jsonSerialization['isRecurring'] as bool,
      recurrenceRule: jsonSerialization['recurrenceRule'] as String?,
      status:
          _i3.DeadlineStatus.fromJson((jsonSerialization['status'] as String)),
      priority: _i4.DeadlinePriority.fromJson(
          (jsonSerialization['priority'] as String)),
      assignedTo: jsonSerialization['assignedTo'] as int?,
      notifyBeforeHoursJson:
          jsonSerialization['notifyBeforeHoursJson'] as String?,
      isPrivate: jsonSerialization['isPrivate'] as bool,
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt']),
      completedBy: jsonSerialization['completedBy'] as int?,
    );
  }

  static final t = DeadlineTable();

  static const db = DeadlineRepository._();

  @override
  int? id;

  int familyId;

  int createdBy;

  String title;

  String? description;

  _i2.DeadlineCategory category;

  double? amount;

  String currency;

  DateTime dueDate;

  bool isRecurring;

  String? recurrenceRule;

  _i3.DeadlineStatus status;

  _i4.DeadlinePriority priority;

  int? assignedTo;

  String? notifyBeforeHoursJson;

  bool isPrivate;

  DateTime? completedAt;

  int? completedBy;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [Deadline]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Deadline copyWith({
    int? id,
    int? familyId,
    int? createdBy,
    String? title,
    String? description,
    _i2.DeadlineCategory? category,
    double? amount,
    String? currency,
    DateTime? dueDate,
    bool? isRecurring,
    String? recurrenceRule,
    _i3.DeadlineStatus? status,
    _i4.DeadlinePriority? priority,
    int? assignedTo,
    String? notifyBeforeHoursJson,
    bool? isPrivate,
    DateTime? completedAt,
    int? completedBy,
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
      if (amount != null) 'amount': amount,
      'currency': currency,
      'dueDate': dueDate.toJson(),
      'isRecurring': isRecurring,
      if (recurrenceRule != null) 'recurrenceRule': recurrenceRule,
      'status': status.toJson(),
      'priority': priority.toJson(),
      if (assignedTo != null) 'assignedTo': assignedTo,
      if (notifyBeforeHoursJson != null)
        'notifyBeforeHoursJson': notifyBeforeHoursJson,
      'isPrivate': isPrivate,
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (completedBy != null) 'completedBy': completedBy,
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
      if (amount != null) 'amount': amount,
      'currency': currency,
      'dueDate': dueDate.toJson(),
      'isRecurring': isRecurring,
      if (recurrenceRule != null) 'recurrenceRule': recurrenceRule,
      'status': status.toJson(),
      'priority': priority.toJson(),
      if (assignedTo != null) 'assignedTo': assignedTo,
      if (notifyBeforeHoursJson != null)
        'notifyBeforeHoursJson': notifyBeforeHoursJson,
      'isPrivate': isPrivate,
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (completedBy != null) 'completedBy': completedBy,
    };
  }

  static DeadlineInclude include() {
    return DeadlineInclude._();
  }

  static DeadlineIncludeList includeList({
    _i1.WhereExpressionBuilder<DeadlineTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DeadlineTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DeadlineTable>? orderByList,
    DeadlineInclude? include,
  }) {
    return DeadlineIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Deadline.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Deadline.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DeadlineImpl extends Deadline {
  _DeadlineImpl({
    int? id,
    required int familyId,
    required int createdBy,
    required String title,
    String? description,
    _i2.DeadlineCategory? category,
    double? amount,
    String? currency,
    required DateTime dueDate,
    bool? isRecurring,
    String? recurrenceRule,
    _i3.DeadlineStatus? status,
    _i4.DeadlinePriority? priority,
    int? assignedTo,
    String? notifyBeforeHoursJson,
    bool? isPrivate,
    DateTime? completedAt,
    int? completedBy,
  }) : super._(
          id: id,
          familyId: familyId,
          createdBy: createdBy,
          title: title,
          description: description,
          category: category,
          amount: amount,
          currency: currency,
          dueDate: dueDate,
          isRecurring: isRecurring,
          recurrenceRule: recurrenceRule,
          status: status,
          priority: priority,
          assignedTo: assignedTo,
          notifyBeforeHoursJson: notifyBeforeHoursJson,
          isPrivate: isPrivate,
          completedAt: completedAt,
          completedBy: completedBy,
        );

  /// Returns a shallow copy of this [Deadline]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Deadline copyWith({
    Object? id = _Undefined,
    int? familyId,
    int? createdBy,
    String? title,
    Object? description = _Undefined,
    _i2.DeadlineCategory? category,
    Object? amount = _Undefined,
    String? currency,
    DateTime? dueDate,
    bool? isRecurring,
    Object? recurrenceRule = _Undefined,
    _i3.DeadlineStatus? status,
    _i4.DeadlinePriority? priority,
    Object? assignedTo = _Undefined,
    Object? notifyBeforeHoursJson = _Undefined,
    bool? isPrivate,
    Object? completedAt = _Undefined,
    Object? completedBy = _Undefined,
  }) {
    return Deadline(
      id: id is int? ? id : this.id,
      familyId: familyId ?? this.familyId,
      createdBy: createdBy ?? this.createdBy,
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      category: category ?? this.category,
      amount: amount is double? ? amount : this.amount,
      currency: currency ?? this.currency,
      dueDate: dueDate ?? this.dueDate,
      isRecurring: isRecurring ?? this.isRecurring,
      recurrenceRule:
          recurrenceRule is String? ? recurrenceRule : this.recurrenceRule,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      assignedTo: assignedTo is int? ? assignedTo : this.assignedTo,
      notifyBeforeHoursJson: notifyBeforeHoursJson is String?
          ? notifyBeforeHoursJson
          : this.notifyBeforeHoursJson,
      isPrivate: isPrivate ?? this.isPrivate,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
      completedBy: completedBy is int? ? completedBy : this.completedBy,
    );
  }
}

class DeadlineTable extends _i1.Table<int> {
  DeadlineTable({super.tableRelation}) : super(tableName: 'deadline') {
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
    amount = _i1.ColumnDouble(
      'amount',
      this,
    );
    currency = _i1.ColumnString(
      'currency',
      this,
      hasDefault: true,
    );
    dueDate = _i1.ColumnDateTime(
      'dueDate',
      this,
    );
    isRecurring = _i1.ColumnBool(
      'isRecurring',
      this,
      hasDefault: true,
    );
    recurrenceRule = _i1.ColumnString(
      'recurrenceRule',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    priority = _i1.ColumnEnum(
      'priority',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    assignedTo = _i1.ColumnInt(
      'assignedTo',
      this,
    );
    notifyBeforeHoursJson = _i1.ColumnString(
      'notifyBeforeHoursJson',
      this,
      hasDefault: true,
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
    completedBy = _i1.ColumnInt(
      'completedBy',
      this,
    );
  }

  late final _i1.ColumnInt familyId;

  late final _i1.ColumnInt createdBy;

  late final _i1.ColumnString title;

  late final _i1.ColumnString description;

  late final _i1.ColumnEnum<_i2.DeadlineCategory> category;

  late final _i1.ColumnDouble amount;

  late final _i1.ColumnString currency;

  late final _i1.ColumnDateTime dueDate;

  late final _i1.ColumnBool isRecurring;

  late final _i1.ColumnString recurrenceRule;

  late final _i1.ColumnEnum<_i3.DeadlineStatus> status;

  late final _i1.ColumnEnum<_i4.DeadlinePriority> priority;

  late final _i1.ColumnInt assignedTo;

  late final _i1.ColumnString notifyBeforeHoursJson;

  late final _i1.ColumnBool isPrivate;

  late final _i1.ColumnDateTime completedAt;

  late final _i1.ColumnInt completedBy;

  @override
  List<_i1.Column> get columns => [
        id,
        familyId,
        createdBy,
        title,
        description,
        category,
        amount,
        currency,
        dueDate,
        isRecurring,
        recurrenceRule,
        status,
        priority,
        assignedTo,
        notifyBeforeHoursJson,
        isPrivate,
        completedAt,
        completedBy,
      ];
}

class DeadlineInclude extends _i1.IncludeObject {
  DeadlineInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int> get table => Deadline.t;
}

class DeadlineIncludeList extends _i1.IncludeList {
  DeadlineIncludeList._({
    _i1.WhereExpressionBuilder<DeadlineTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Deadline.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => Deadline.t;
}

class DeadlineRepository {
  const DeadlineRepository._();

  /// Returns a list of [Deadline]s matching the given query parameters.
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
  Future<List<Deadline>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DeadlineTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DeadlineTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DeadlineTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Deadline>(
      where: where?.call(Deadline.t),
      orderBy: orderBy?.call(Deadline.t),
      orderByList: orderByList?.call(Deadline.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Deadline] matching the given query parameters.
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
  Future<Deadline?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DeadlineTable>? where,
    int? offset,
    _i1.OrderByBuilder<DeadlineTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DeadlineTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Deadline>(
      where: where?.call(Deadline.t),
      orderBy: orderBy?.call(Deadline.t),
      orderByList: orderByList?.call(Deadline.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Deadline] by its [id] or null if no such row exists.
  Future<Deadline?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Deadline>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Deadline]s in the list and returns the inserted rows.
  ///
  /// The returned [Deadline]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Deadline>> insert(
    _i1.Session session,
    List<Deadline> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Deadline>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Deadline] and returns the inserted row.
  ///
  /// The returned [Deadline] will have its `id` field set.
  Future<Deadline> insertRow(
    _i1.Session session,
    Deadline row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Deadline>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Deadline]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Deadline>> update(
    _i1.Session session,
    List<Deadline> rows, {
    _i1.ColumnSelections<DeadlineTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Deadline>(
      rows,
      columns: columns?.call(Deadline.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Deadline]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Deadline> updateRow(
    _i1.Session session,
    Deadline row, {
    _i1.ColumnSelections<DeadlineTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Deadline>(
      row,
      columns: columns?.call(Deadline.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Deadline]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Deadline>> delete(
    _i1.Session session,
    List<Deadline> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Deadline>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Deadline].
  Future<Deadline> deleteRow(
    _i1.Session session,
    Deadline row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Deadline>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Deadline>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<DeadlineTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Deadline>(
      where: where(Deadline.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DeadlineTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Deadline>(
      where: where?.call(Deadline.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
