/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'todo_category.dart' as _i2;
import 'todo_priority.dart' as _i3;
import 'todo_status.dart' as _i4;

/// Compito familiare.
abstract class TodoItem implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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
