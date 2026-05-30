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
import 'health_entry_status.dart' as _i2;
import 'health_entry_type.dart' as _i3;
import 'sport_intensity.dart' as _i4;

/// Voce modulo salute: visita medica, dieta o attività sportiva.
abstract class HealthEntry implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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
