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
import 'emergency_alert_type.dart' as _i2;
import 'emergency_trigger_method.dart' as _i3;
import 'emergency_alert_status.dart' as _i4;

/// Allerta emergenza familiare.
abstract class EmergencyAlert implements _i1.SerializableModel {
  EmergencyAlert._({
    this.id,
    required this.familyId,
    required this.triggeredBy,
    _i2.EmergencyAlertType? alertType,
    this.customMessage,
    this.locationLat,
    this.locationLng,
    this.locationAddress,
    this.batteryLevel,
    _i3.EmergencyTriggerMethod? triggerMethod,
    _i4.EmergencyAlertStatus? status,
    bool? isTest,
    this.acknowledgedBy,
    this.acknowledgedAt,
    this.resolvedBy,
    this.resolvedAt,
    int? escalationLevel,
  })  : alertType = alertType ?? _i2.EmergencyAlertType.other,
        triggerMethod = triggerMethod ?? _i3.EmergencyTriggerMethod.panicButton,
        status = status ?? _i4.EmergencyAlertStatus.active,
        isTest = isTest ?? false,
        escalationLevel = escalationLevel ?? 1;

  factory EmergencyAlert({
    int? id,
    required int familyId,
    required int triggeredBy,
    _i2.EmergencyAlertType? alertType,
    String? customMessage,
    double? locationLat,
    double? locationLng,
    String? locationAddress,
    int? batteryLevel,
    _i3.EmergencyTriggerMethod? triggerMethod,
    _i4.EmergencyAlertStatus? status,
    bool? isTest,
    int? acknowledgedBy,
    DateTime? acknowledgedAt,
    int? resolvedBy,
    DateTime? resolvedAt,
    int? escalationLevel,
  }) = _EmergencyAlertImpl;

  factory EmergencyAlert.fromJson(Map<String, dynamic> jsonSerialization) {
    return EmergencyAlert(
      id: jsonSerialization['id'] as int?,
      familyId: jsonSerialization['familyId'] as int,
      triggeredBy: jsonSerialization['triggeredBy'] as int,
      alertType: _i2.EmergencyAlertType.fromJson(
          (jsonSerialization['alertType'] as String)),
      customMessage: jsonSerialization['customMessage'] as String?,
      locationLat: (jsonSerialization['locationLat'] as num?)?.toDouble(),
      locationLng: (jsonSerialization['locationLng'] as num?)?.toDouble(),
      locationAddress: jsonSerialization['locationAddress'] as String?,
      batteryLevel: jsonSerialization['batteryLevel'] as int?,
      triggerMethod: _i3.EmergencyTriggerMethod.fromJson(
          (jsonSerialization['triggerMethod'] as String)),
      status: _i4.EmergencyAlertStatus.fromJson(
          (jsonSerialization['status'] as String)),
      isTest: jsonSerialization['isTest'] as bool,
      acknowledgedBy: jsonSerialization['acknowledgedBy'] as int?,
      acknowledgedAt: jsonSerialization['acknowledgedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['acknowledgedAt']),
      resolvedBy: jsonSerialization['resolvedBy'] as int?,
      resolvedAt: jsonSerialization['resolvedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['resolvedAt']),
      escalationLevel: jsonSerialization['escalationLevel'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int familyId;

  int triggeredBy;

  _i2.EmergencyAlertType alertType;

  String? customMessage;

  double? locationLat;

  double? locationLng;

  String? locationAddress;

  int? batteryLevel;

  _i3.EmergencyTriggerMethod triggerMethod;

  _i4.EmergencyAlertStatus status;

  bool isTest;

  int? acknowledgedBy;

  DateTime? acknowledgedAt;

  int? resolvedBy;

  DateTime? resolvedAt;

  int escalationLevel;

  /// Returns a shallow copy of this [EmergencyAlert]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EmergencyAlert copyWith({
    int? id,
    int? familyId,
    int? triggeredBy,
    _i2.EmergencyAlertType? alertType,
    String? customMessage,
    double? locationLat,
    double? locationLng,
    String? locationAddress,
    int? batteryLevel,
    _i3.EmergencyTriggerMethod? triggerMethod,
    _i4.EmergencyAlertStatus? status,
    bool? isTest,
    int? acknowledgedBy,
    DateTime? acknowledgedAt,
    int? resolvedBy,
    DateTime? resolvedAt,
    int? escalationLevel,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'familyId': familyId,
      'triggeredBy': triggeredBy,
      'alertType': alertType.toJson(),
      if (customMessage != null) 'customMessage': customMessage,
      if (locationLat != null) 'locationLat': locationLat,
      if (locationLng != null) 'locationLng': locationLng,
      if (locationAddress != null) 'locationAddress': locationAddress,
      if (batteryLevel != null) 'batteryLevel': batteryLevel,
      'triggerMethod': triggerMethod.toJson(),
      'status': status.toJson(),
      'isTest': isTest,
      if (acknowledgedBy != null) 'acknowledgedBy': acknowledgedBy,
      if (acknowledgedAt != null) 'acknowledgedAt': acknowledgedAt?.toJson(),
      if (resolvedBy != null) 'resolvedBy': resolvedBy,
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
      'escalationLevel': escalationLevel,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EmergencyAlertImpl extends EmergencyAlert {
  _EmergencyAlertImpl({
    int? id,
    required int familyId,
    required int triggeredBy,
    _i2.EmergencyAlertType? alertType,
    String? customMessage,
    double? locationLat,
    double? locationLng,
    String? locationAddress,
    int? batteryLevel,
    _i3.EmergencyTriggerMethod? triggerMethod,
    _i4.EmergencyAlertStatus? status,
    bool? isTest,
    int? acknowledgedBy,
    DateTime? acknowledgedAt,
    int? resolvedBy,
    DateTime? resolvedAt,
    int? escalationLevel,
  }) : super._(
          id: id,
          familyId: familyId,
          triggeredBy: triggeredBy,
          alertType: alertType,
          customMessage: customMessage,
          locationLat: locationLat,
          locationLng: locationLng,
          locationAddress: locationAddress,
          batteryLevel: batteryLevel,
          triggerMethod: triggerMethod,
          status: status,
          isTest: isTest,
          acknowledgedBy: acknowledgedBy,
          acknowledgedAt: acknowledgedAt,
          resolvedBy: resolvedBy,
          resolvedAt: resolvedAt,
          escalationLevel: escalationLevel,
        );

  /// Returns a shallow copy of this [EmergencyAlert]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EmergencyAlert copyWith({
    Object? id = _Undefined,
    int? familyId,
    int? triggeredBy,
    _i2.EmergencyAlertType? alertType,
    Object? customMessage = _Undefined,
    Object? locationLat = _Undefined,
    Object? locationLng = _Undefined,
    Object? locationAddress = _Undefined,
    Object? batteryLevel = _Undefined,
    _i3.EmergencyTriggerMethod? triggerMethod,
    _i4.EmergencyAlertStatus? status,
    bool? isTest,
    Object? acknowledgedBy = _Undefined,
    Object? acknowledgedAt = _Undefined,
    Object? resolvedBy = _Undefined,
    Object? resolvedAt = _Undefined,
    int? escalationLevel,
  }) {
    return EmergencyAlert(
      id: id is int? ? id : this.id,
      familyId: familyId ?? this.familyId,
      triggeredBy: triggeredBy ?? this.triggeredBy,
      alertType: alertType ?? this.alertType,
      customMessage:
          customMessage is String? ? customMessage : this.customMessage,
      locationLat: locationLat is double? ? locationLat : this.locationLat,
      locationLng: locationLng is double? ? locationLng : this.locationLng,
      locationAddress:
          locationAddress is String? ? locationAddress : this.locationAddress,
      batteryLevel: batteryLevel is int? ? batteryLevel : this.batteryLevel,
      triggerMethod: triggerMethod ?? this.triggerMethod,
      status: status ?? this.status,
      isTest: isTest ?? this.isTest,
      acknowledgedBy:
          acknowledgedBy is int? ? acknowledgedBy : this.acknowledgedBy,
      acknowledgedAt:
          acknowledgedAt is DateTime? ? acknowledgedAt : this.acknowledgedAt,
      resolvedBy: resolvedBy is int? ? resolvedBy : this.resolvedBy,
      resolvedAt: resolvedAt is DateTime? ? resolvedAt : this.resolvedAt,
      escalationLevel: escalationLevel ?? this.escalationLevel,
    );
  }
}
