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

abstract class PrivacyDashboard implements _i1.SerializableModel {
  PrivacyDashboard._({
    required this.locationEnabled,
    this.locationExpiresAt,
    required this.sharedWithCount,
    required this.viewersJson,
    required this.canExportData,
  });

  factory PrivacyDashboard({
    required bool locationEnabled,
    DateTime? locationExpiresAt,
    required int sharedWithCount,
    required String viewersJson,
    required bool canExportData,
  }) = _PrivacyDashboardImpl;

  factory PrivacyDashboard.fromJson(Map<String, dynamic> jsonSerialization) {
    return PrivacyDashboard(
      locationEnabled: jsonSerialization['locationEnabled'] as bool,
      locationExpiresAt: jsonSerialization['locationExpiresAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['locationExpiresAt']),
      sharedWithCount: jsonSerialization['sharedWithCount'] as int,
      viewersJson: jsonSerialization['viewersJson'] as String,
      canExportData: jsonSerialization['canExportData'] as bool,
    );
  }

  bool locationEnabled;

  DateTime? locationExpiresAt;

  int sharedWithCount;

  String viewersJson;

  bool canExportData;

  /// Returns a shallow copy of this [PrivacyDashboard]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PrivacyDashboard copyWith({
    bool? locationEnabled,
    DateTime? locationExpiresAt,
    int? sharedWithCount,
    String? viewersJson,
    bool? canExportData,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'locationEnabled': locationEnabled,
      if (locationExpiresAt != null)
        'locationExpiresAt': locationExpiresAt?.toJson(),
      'sharedWithCount': sharedWithCount,
      'viewersJson': viewersJson,
      'canExportData': canExportData,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PrivacyDashboardImpl extends PrivacyDashboard {
  _PrivacyDashboardImpl({
    required bool locationEnabled,
    DateTime? locationExpiresAt,
    required int sharedWithCount,
    required String viewersJson,
    required bool canExportData,
  }) : super._(
          locationEnabled: locationEnabled,
          locationExpiresAt: locationExpiresAt,
          sharedWithCount: sharedWithCount,
          viewersJson: viewersJson,
          canExportData: canExportData,
        );

  /// Returns a shallow copy of this [PrivacyDashboard]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PrivacyDashboard copyWith({
    bool? locationEnabled,
    Object? locationExpiresAt = _Undefined,
    int? sharedWithCount,
    String? viewersJson,
    bool? canExportData,
  }) {
    return PrivacyDashboard(
      locationEnabled: locationEnabled ?? this.locationEnabled,
      locationExpiresAt: locationExpiresAt is DateTime?
          ? locationExpiresAt
          : this.locationExpiresAt,
      sharedWithCount: sharedWithCount ?? this.sharedWithCount,
      viewersJson: viewersJson ?? this.viewersJson,
      canExportData: canExportData ?? this.canExportData,
    );
  }
}
