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

/// Storico posizione / check-in.
abstract class LocationHistory implements _i1.SerializableModel {
  LocationHistory._({
    this.id,
    required this.userId,
    required this.familyId,
    required this.latitude,
    required this.longitude,
    this.accuracyMeters,
    this.address,
    this.batteryLevel,
    bool? isManualCheckIn,
    required this.recordedAt,
  }) : isManualCheckIn = isManualCheckIn ?? false;

  factory LocationHistory({
    int? id,
    required int userId,
    required int familyId,
    required double latitude,
    required double longitude,
    int? accuracyMeters,
    String? address,
    int? batteryLevel,
    bool? isManualCheckIn,
    required DateTime recordedAt,
  }) = _LocationHistoryImpl;

  factory LocationHistory.fromJson(Map<String, dynamic> jsonSerialization) {
    return LocationHistory(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      familyId: jsonSerialization['familyId'] as int,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      accuracyMeters: jsonSerialization['accuracyMeters'] as int?,
      address: jsonSerialization['address'] as String?,
      batteryLevel: jsonSerialization['batteryLevel'] as int?,
      isManualCheckIn: jsonSerialization['isManualCheckIn'] as bool,
      recordedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['recordedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  int familyId;

  double latitude;

  double longitude;

  int? accuracyMeters;

  String? address;

  int? batteryLevel;

  bool isManualCheckIn;

  DateTime recordedAt;

  /// Returns a shallow copy of this [LocationHistory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LocationHistory copyWith({
    int? id,
    int? userId,
    int? familyId,
    double? latitude,
    double? longitude,
    int? accuracyMeters,
    String? address,
    int? batteryLevel,
    bool? isManualCheckIn,
    DateTime? recordedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'familyId': familyId,
      'latitude': latitude,
      'longitude': longitude,
      if (accuracyMeters != null) 'accuracyMeters': accuracyMeters,
      if (address != null) 'address': address,
      if (batteryLevel != null) 'batteryLevel': batteryLevel,
      'isManualCheckIn': isManualCheckIn,
      'recordedAt': recordedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LocationHistoryImpl extends LocationHistory {
  _LocationHistoryImpl({
    int? id,
    required int userId,
    required int familyId,
    required double latitude,
    required double longitude,
    int? accuracyMeters,
    String? address,
    int? batteryLevel,
    bool? isManualCheckIn,
    required DateTime recordedAt,
  }) : super._(
          id: id,
          userId: userId,
          familyId: familyId,
          latitude: latitude,
          longitude: longitude,
          accuracyMeters: accuracyMeters,
          address: address,
          batteryLevel: batteryLevel,
          isManualCheckIn: isManualCheckIn,
          recordedAt: recordedAt,
        );

  /// Returns a shallow copy of this [LocationHistory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LocationHistory copyWith({
    Object? id = _Undefined,
    int? userId,
    int? familyId,
    double? latitude,
    double? longitude,
    Object? accuracyMeters = _Undefined,
    Object? address = _Undefined,
    Object? batteryLevel = _Undefined,
    bool? isManualCheckIn,
    DateTime? recordedAt,
  }) {
    return LocationHistory(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      familyId: familyId ?? this.familyId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      accuracyMeters:
          accuracyMeters is int? ? accuracyMeters : this.accuracyMeters,
      address: address is String? ? address : this.address,
      batteryLevel: batteryLevel is int? ? batteryLevel : this.batteryLevel,
      isManualCheckIn: isManualCheckIn ?? this.isManualCheckIn,
      recordedAt: recordedAt ?? this.recordedAt,
    );
  }
}
