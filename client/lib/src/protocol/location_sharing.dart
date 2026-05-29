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
import 'location_accuracy_level.dart' as _i2;

/// Impostazioni condivisione posizione per utente/famiglia.
abstract class LocationSharing implements _i1.SerializableModel {
  LocationSharing._({
    this.id,
    required this.userId,
    required this.familyId,
    bool? isEnabled,
    _i2.LocationAccuracyLevel? accuracyLevel,
    int? autoDisableAfterHours,
    String? shareWithUserIdsJson,
    this.enabledAt,
    this.expiresAt,
  })  : isEnabled = isEnabled ?? false,
        accuracyLevel = accuracyLevel ?? _i2.LocationAccuracyLevel.precise,
        autoDisableAfterHours = autoDisableAfterHours ?? 24,
        shareWithUserIdsJson = shareWithUserIdsJson ?? '[]';

  factory LocationSharing({
    int? id,
    required int userId,
    required int familyId,
    bool? isEnabled,
    _i2.LocationAccuracyLevel? accuracyLevel,
    int? autoDisableAfterHours,
    String? shareWithUserIdsJson,
    DateTime? enabledAt,
    DateTime? expiresAt,
  }) = _LocationSharingImpl;

  factory LocationSharing.fromJson(Map<String, dynamic> jsonSerialization) {
    return LocationSharing(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      familyId: jsonSerialization['familyId'] as int,
      isEnabled: jsonSerialization['isEnabled'] as bool,
      accuracyLevel: _i2.LocationAccuracyLevel.fromJson(
          (jsonSerialization['accuracyLevel'] as String)),
      autoDisableAfterHours: jsonSerialization['autoDisableAfterHours'] as int,
      shareWithUserIdsJson: jsonSerialization['shareWithUserIdsJson'] as String,
      enabledAt: jsonSerialization['enabledAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['enabledAt']),
      expiresAt: jsonSerialization['expiresAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  int familyId;

  bool isEnabled;

  _i2.LocationAccuracyLevel accuracyLevel;

  int autoDisableAfterHours;

  String shareWithUserIdsJson;

  DateTime? enabledAt;

  DateTime? expiresAt;

  /// Returns a shallow copy of this [LocationSharing]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LocationSharing copyWith({
    int? id,
    int? userId,
    int? familyId,
    bool? isEnabled,
    _i2.LocationAccuracyLevel? accuracyLevel,
    int? autoDisableAfterHours,
    String? shareWithUserIdsJson,
    DateTime? enabledAt,
    DateTime? expiresAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'familyId': familyId,
      'isEnabled': isEnabled,
      'accuracyLevel': accuracyLevel.toJson(),
      'autoDisableAfterHours': autoDisableAfterHours,
      'shareWithUserIdsJson': shareWithUserIdsJson,
      if (enabledAt != null) 'enabledAt': enabledAt?.toJson(),
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LocationSharingImpl extends LocationSharing {
  _LocationSharingImpl({
    int? id,
    required int userId,
    required int familyId,
    bool? isEnabled,
    _i2.LocationAccuracyLevel? accuracyLevel,
    int? autoDisableAfterHours,
    String? shareWithUserIdsJson,
    DateTime? enabledAt,
    DateTime? expiresAt,
  }) : super._(
          id: id,
          userId: userId,
          familyId: familyId,
          isEnabled: isEnabled,
          accuracyLevel: accuracyLevel,
          autoDisableAfterHours: autoDisableAfterHours,
          shareWithUserIdsJson: shareWithUserIdsJson,
          enabledAt: enabledAt,
          expiresAt: expiresAt,
        );

  /// Returns a shallow copy of this [LocationSharing]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LocationSharing copyWith({
    Object? id = _Undefined,
    int? userId,
    int? familyId,
    bool? isEnabled,
    _i2.LocationAccuracyLevel? accuracyLevel,
    int? autoDisableAfterHours,
    String? shareWithUserIdsJson,
    Object? enabledAt = _Undefined,
    Object? expiresAt = _Undefined,
  }) {
    return LocationSharing(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      familyId: familyId ?? this.familyId,
      isEnabled: isEnabled ?? this.isEnabled,
      accuracyLevel: accuracyLevel ?? this.accuracyLevel,
      autoDisableAfterHours:
          autoDisableAfterHours ?? this.autoDisableAfterHours,
      shareWithUserIdsJson: shareWithUserIdsJson ?? this.shareWithUserIdsJson,
      enabledAt: enabledAt is DateTime? ? enabledAt : this.enabledAt,
      expiresAt: expiresAt is DateTime? ? expiresAt : this.expiresAt,
    );
  }
}
