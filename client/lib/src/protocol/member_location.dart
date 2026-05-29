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

abstract class MemberLocation implements _i1.SerializableModel {
  MemberLocation._({
    required this.userId,
    required this.displayName,
    required this.latitude,
    required this.longitude,
    this.address,
    required this.recordedAt,
    required this.isSharingEnabled,
  });

  factory MemberLocation({
    required int userId,
    required String displayName,
    required double latitude,
    required double longitude,
    String? address,
    required DateTime recordedAt,
    required bool isSharingEnabled,
  }) = _MemberLocationImpl;

  factory MemberLocation.fromJson(Map<String, dynamic> jsonSerialization) {
    return MemberLocation(
      userId: jsonSerialization['userId'] as int,
      displayName: jsonSerialization['displayName'] as String,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      address: jsonSerialization['address'] as String?,
      recordedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['recordedAt']),
      isSharingEnabled: jsonSerialization['isSharingEnabled'] as bool,
    );
  }

  int userId;

  String displayName;

  double latitude;

  double longitude;

  String? address;

  DateTime recordedAt;

  bool isSharingEnabled;

  /// Returns a shallow copy of this [MemberLocation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MemberLocation copyWith({
    int? userId,
    String? displayName,
    double? latitude,
    double? longitude,
    String? address,
    DateTime? recordedAt,
    bool? isSharingEnabled,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'displayName': displayName,
      'latitude': latitude,
      'longitude': longitude,
      if (address != null) 'address': address,
      'recordedAt': recordedAt.toJson(),
      'isSharingEnabled': isSharingEnabled,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MemberLocationImpl extends MemberLocation {
  _MemberLocationImpl({
    required int userId,
    required String displayName,
    required double latitude,
    required double longitude,
    String? address,
    required DateTime recordedAt,
    required bool isSharingEnabled,
  }) : super._(
          userId: userId,
          displayName: displayName,
          latitude: latitude,
          longitude: longitude,
          address: address,
          recordedAt: recordedAt,
          isSharingEnabled: isSharingEnabled,
        );

  /// Returns a shallow copy of this [MemberLocation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MemberLocation copyWith({
    int? userId,
    String? displayName,
    double? latitude,
    double? longitude,
    Object? address = _Undefined,
    DateTime? recordedAt,
    bool? isSharingEnabled,
  }) {
    return MemberLocation(
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address is String? ? address : this.address,
      recordedAt: recordedAt ?? this.recordedAt,
      isSharingEnabled: isSharingEnabled ?? this.isSharingEnabled,
    );
  }
}
