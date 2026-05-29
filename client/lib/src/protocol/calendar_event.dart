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
import 'calendar_event_category.dart' as _i2;

/// Evento calendario familiare.
abstract class CalendarEvent implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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
