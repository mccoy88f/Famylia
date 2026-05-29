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

/// Impostazioni emergenza per famiglia.
abstract class EmergencySettings implements _i1.SerializableModel {
  EmergencySettings._({
    this.id,
    required this.familyId,
    bool? panicButtonEnabled,
    bool? requireConfirmation,
    int? confirmationSeconds,
    String? escalationMinutesJson,
  })  : panicButtonEnabled = panicButtonEnabled ?? true,
        requireConfirmation = requireConfirmation ?? true,
        confirmationSeconds = confirmationSeconds ?? 3,
        escalationMinutesJson = escalationMinutesJson ?? '[5,15,30]';

  factory EmergencySettings({
    int? id,
    required int familyId,
    bool? panicButtonEnabled,
    bool? requireConfirmation,
    int? confirmationSeconds,
    String? escalationMinutesJson,
  }) = _EmergencySettingsImpl;

  factory EmergencySettings.fromJson(Map<String, dynamic> jsonSerialization) {
    return EmergencySettings(
      id: jsonSerialization['id'] as int?,
      familyId: jsonSerialization['familyId'] as int,
      panicButtonEnabled: jsonSerialization['panicButtonEnabled'] as bool,
      requireConfirmation: jsonSerialization['requireConfirmation'] as bool,
      confirmationSeconds: jsonSerialization['confirmationSeconds'] as int,
      escalationMinutesJson:
          jsonSerialization['escalationMinutesJson'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int familyId;

  bool panicButtonEnabled;

  bool requireConfirmation;

  int confirmationSeconds;

  String escalationMinutesJson;

  /// Returns a shallow copy of this [EmergencySettings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EmergencySettings copyWith({
    int? id,
    int? familyId,
    bool? panicButtonEnabled,
    bool? requireConfirmation,
    int? confirmationSeconds,
    String? escalationMinutesJson,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'familyId': familyId,
      'panicButtonEnabled': panicButtonEnabled,
      'requireConfirmation': requireConfirmation,
      'confirmationSeconds': confirmationSeconds,
      'escalationMinutesJson': escalationMinutesJson,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EmergencySettingsImpl extends EmergencySettings {
  _EmergencySettingsImpl({
    int? id,
    required int familyId,
    bool? panicButtonEnabled,
    bool? requireConfirmation,
    int? confirmationSeconds,
    String? escalationMinutesJson,
  }) : super._(
          id: id,
          familyId: familyId,
          panicButtonEnabled: panicButtonEnabled,
          requireConfirmation: requireConfirmation,
          confirmationSeconds: confirmationSeconds,
          escalationMinutesJson: escalationMinutesJson,
        );

  /// Returns a shallow copy of this [EmergencySettings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EmergencySettings copyWith({
    Object? id = _Undefined,
    int? familyId,
    bool? panicButtonEnabled,
    bool? requireConfirmation,
    int? confirmationSeconds,
    String? escalationMinutesJson,
  }) {
    return EmergencySettings(
      id: id is int? ? id : this.id,
      familyId: familyId ?? this.familyId,
      panicButtonEnabled: panicButtonEnabled ?? this.panicButtonEnabled,
      requireConfirmation: requireConfirmation ?? this.requireConfirmation,
      confirmationSeconds: confirmationSeconds ?? this.confirmationSeconds,
      escalationMinutesJson:
          escalationMinutesJson ?? this.escalationMinutesJson,
    );
  }
}
