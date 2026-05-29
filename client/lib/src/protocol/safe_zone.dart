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

/// Zona sicura (casa, scuola, lavoro).
abstract class SafeZone implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int familyId;

  int createdBy;

  String name;

  double latitude;

  double longitude;

  int radiusMeters;

  bool notifyOnEnter;

  bool notifyOnExit;

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
