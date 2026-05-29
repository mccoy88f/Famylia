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
import 'deadline_category.dart' as _i2;
import 'deadline_status.dart' as _i3;
import 'deadline_priority.dart' as _i4;

/// Scadenza o bolletta familiare.
abstract class Deadline implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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
