/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

/// Notifica real-time emergenza.
abstract class EmergencyChanged
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  EmergencyChanged._({required this.familyId});

  factory EmergencyChanged({required int familyId}) = _EmergencyChangedImpl;

  factory EmergencyChanged.fromJson(Map<String, dynamic> jsonSerialization) {
    return EmergencyChanged(familyId: jsonSerialization['familyId'] as int);
  }

  int familyId;

  /// Returns a shallow copy of this [EmergencyChanged]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EmergencyChanged copyWith({int? familyId});
  @override
  Map<String, dynamic> toJson() {
    return {'familyId': familyId};
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {'familyId': familyId};
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _EmergencyChangedImpl extends EmergencyChanged {
  _EmergencyChangedImpl({required int familyId}) : super._(familyId: familyId);

  /// Returns a shallow copy of this [EmergencyChanged]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EmergencyChanged copyWith({int? familyId}) {
    return EmergencyChanged(familyId: familyId ?? this.familyId);
  }
}
