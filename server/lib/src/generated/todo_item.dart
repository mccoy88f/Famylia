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
import 'todo_category.dart' as _i2;
import 'todo_priority.dart' as _i3;
import 'todo_status.dart' as _i4;

/// Compito familiare.
abstract class TodoItem
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  TodoItem._({
    this.id,
    required this.familyId,
    required this.createdBy,
    required this.title,
    this.description,
    _i2.TodoCategory? category,
    _i3.TodoPriority? priority,
    _i4.TodoStatus? status,
    this.assignedTo,
    this.dueDate,
    int? points,
    this.completedAt,
    this.completedBy,
  })  : category = category ?? _i2.TodoCategory.other,
        priority = priority ?? _i3.TodoPriority.medium,
        status = status ?? _i4.TodoStatus.pending,
        points = points ?? 10;

  factory TodoItem({
    int? id,
    required int familyId,
    required int createdBy,
    required String title,
    String? description,
    _i2.TodoCategory? category,
    _i3.TodoPriority? priority,
    _i4.TodoStatus? status,
    int? assignedTo,
    DateTime? dueDate,
    int? points,
    DateTime? completedAt,
    int? completedBy,
  }) = _TodoItemImpl;

  factory TodoItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return TodoItem(
      id: jsonSerialization['id'] as int?,
      familyId: jsonSerialization['familyId'] as int,
      createdBy: jsonSerialization['createdBy'] as int,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      category:
          _i2.TodoCategory.fromJson((jsonSerialization['category'] as String)),
      priority:
          _i3.TodoPriority.fromJson((jsonSerialization['priority'] as String)),
      status: _i4.TodoStatus.fromJson((jsonSerialization['status'] as String)),
      assignedTo: jsonSerialization['assignedTo'] as int?,
      dueDate: jsonSerialization['dueDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dueDate']),
      points: jsonSerialization['points'] as int,
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt']),
      completedBy: jsonSerialization['completedBy'] as int?,
    );
  }

  static final t = TodoItemTable();

  static const db = TodoItemRepository._();

  @override
  int? id;

  int familyId;

  int createdBy;

  String title;

  String? description;

  _i2.TodoCategory category;

  _i3.TodoPriority priority;

  _i4.TodoStatus status;

  int? assignedTo;

  DateTime? dueDate;

  int points;

  DateTime? completedAt;

  int? completedBy;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [TodoItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TodoItem copyWith({
    int? id,
    int? familyId,
    int? createdBy,
    String? title,
    String? description,
    _i2.TodoCategory? category,
    _i3.TodoPriority? priority,
    _i4.TodoStatus? status,
    int? assignedTo,
    DateTime? dueDate,
    int? points,
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
      'priority': priority.toJson(),
      'status': status.toJson(),
      if (assignedTo != null) 'assignedTo': assignedTo,
      if (dueDate != null) 'dueDate': dueDate?.toJson(),
      'points': points,
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
      'priority': priority.toJson(),
      'status': status.toJson(),
      if (assignedTo != null) 'assignedTo': assignedTo,
      if (dueDate != null) 'dueDate': dueDate?.toJson(),
      'points': points,
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (completedBy != null) 'completedBy': completedBy,
    };
  }

  static TodoItemInclude include() {
    return TodoItemInclude._();
  }

  static TodoItemIncludeList includeList({
    _i1.WhereExpressionBuilder<TodoItemTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TodoItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TodoItemTable>? orderByList,
    TodoItemInclude? include,
  }) {
    return TodoItemIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TodoItem.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(TodoItem.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TodoItemImpl extends TodoItem {
  _TodoItemImpl({
    int? id,
    required int familyId,
    required int createdBy,
    required String title,
    String? description,
    _i2.TodoCategory? category,
    _i3.TodoPriority? priority,
    _i4.TodoStatus? status,
    int? assignedTo,
    DateTime? dueDate,
    int? points,
    DateTime? completedAt,
    int? completedBy,
  }) : super._(
          id: id,
          familyId: familyId,
          createdBy: createdBy,
          title: title,
          description: description,
          category: category,
          priority: priority,
          status: status,
          assignedTo: assignedTo,
          dueDate: dueDate,
          points: points,
          completedAt: completedAt,
          completedBy: completedBy,
        );

  /// Returns a shallow copy of this [TodoItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TodoItem copyWith({
    Object? id = _Undefined,
    int? familyId,
    int? createdBy,
    String? title,
    Object? description = _Undefined,
    _i2.TodoCategory? category,
    _i3.TodoPriority? priority,
    _i4.TodoStatus? status,
    Object? assignedTo = _Undefined,
    Object? dueDate = _Undefined,
    int? points,
    Object? completedAt = _Undefined,
    Object? completedBy = _Undefined,
  }) {
    return TodoItem(
      id: id is int? ? id : this.id,
      familyId: familyId ?? this.familyId,
      createdBy: createdBy ?? this.createdBy,
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      assignedTo: assignedTo is int? ? assignedTo : this.assignedTo,
      dueDate: dueDate is DateTime? ? dueDate : this.dueDate,
      points: points ?? this.points,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
      completedBy: completedBy is int? ? completedBy : this.completedBy,
    );
  }
}

class TodoItemTable extends _i1.Table<int> {
  TodoItemTable({super.tableRelation}) : super(tableName: 'todo_item') {
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
    priority = _i1.ColumnEnum(
      'priority',
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
    assignedTo = _i1.ColumnInt(
      'assignedTo',
      this,
    );
    dueDate = _i1.ColumnDateTime(
      'dueDate',
      this,
    );
    points = _i1.ColumnInt(
      'points',
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

  late final _i1.ColumnEnum<_i2.TodoCategory> category;

  late final _i1.ColumnEnum<_i3.TodoPriority> priority;

  late final _i1.ColumnEnum<_i4.TodoStatus> status;

  late final _i1.ColumnInt assignedTo;

  late final _i1.ColumnDateTime dueDate;

  late final _i1.ColumnInt points;

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
        priority,
        status,
        assignedTo,
        dueDate,
        points,
        completedAt,
        completedBy,
      ];
}

class TodoItemInclude extends _i1.IncludeObject {
  TodoItemInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int> get table => TodoItem.t;
}

class TodoItemIncludeList extends _i1.IncludeList {
  TodoItemIncludeList._({
    _i1.WhereExpressionBuilder<TodoItemTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TodoItem.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => TodoItem.t;
}

class TodoItemRepository {
  const TodoItemRepository._();

  /// Returns a list of [TodoItem]s matching the given query parameters.
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
  Future<List<TodoItem>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TodoItemTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TodoItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TodoItemTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<TodoItem>(
      where: where?.call(TodoItem.t),
      orderBy: orderBy?.call(TodoItem.t),
      orderByList: orderByList?.call(TodoItem.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [TodoItem] matching the given query parameters.
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
  Future<TodoItem?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TodoItemTable>? where,
    int? offset,
    _i1.OrderByBuilder<TodoItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TodoItemTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<TodoItem>(
      where: where?.call(TodoItem.t),
      orderBy: orderBy?.call(TodoItem.t),
      orderByList: orderByList?.call(TodoItem.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [TodoItem] by its [id] or null if no such row exists.
  Future<TodoItem?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<TodoItem>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [TodoItem]s in the list and returns the inserted rows.
  ///
  /// The returned [TodoItem]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<TodoItem>> insert(
    _i1.Session session,
    List<TodoItem> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<TodoItem>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [TodoItem] and returns the inserted row.
  ///
  /// The returned [TodoItem] will have its `id` field set.
  Future<TodoItem> insertRow(
    _i1.Session session,
    TodoItem row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<TodoItem>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [TodoItem]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<TodoItem>> update(
    _i1.Session session,
    List<TodoItem> rows, {
    _i1.ColumnSelections<TodoItemTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<TodoItem>(
      rows,
      columns: columns?.call(TodoItem.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TodoItem]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TodoItem> updateRow(
    _i1.Session session,
    TodoItem row, {
    _i1.ColumnSelections<TodoItemTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<TodoItem>(
      row,
      columns: columns?.call(TodoItem.t),
      transaction: transaction,
    );
  }

  /// Deletes all [TodoItem]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<TodoItem>> delete(
    _i1.Session session,
    List<TodoItem> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<TodoItem>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [TodoItem].
  Future<TodoItem> deleteRow(
    _i1.Session session,
    TodoItem row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TodoItem>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<TodoItem>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<TodoItemTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<TodoItem>(
      where: where(TodoItem.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TodoItemTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<TodoItem>(
      where: where?.call(TodoItem.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
