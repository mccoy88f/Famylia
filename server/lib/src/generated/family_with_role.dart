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
import 'family.dart' as _i2;
import 'family_role.dart' as _i3;

/// Famiglia con ruolo dell'utente corrente (risposta API).
abstract class FamilyWithRole
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  FamilyWithRole._({
    required this.family,
    required this.role,
    required this.memberId,
  });

  factory FamilyWithRole({
    required _i2.Family family,
    required _i3.FamilyRole role,
    required int memberId,
  }) = _FamilyWithRoleImpl;

  factory FamilyWithRole.fromJson(Map<String, dynamic> jsonSerialization) {
    return FamilyWithRole(
      family: _i2.Family.fromJson(
          (jsonSerialization['family'] as Map<String, dynamic>)),
      role: _i3.FamilyRole.fromJson((jsonSerialization['role'] as String)),
      memberId: jsonSerialization['memberId'] as int,
    );
  }

  _i2.Family family;

  _i3.FamilyRole role;

  int memberId;

  /// Returns a shallow copy of this [FamilyWithRole]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FamilyWithRole copyWith({
    _i2.Family? family,
    _i3.FamilyRole? role,
    int? memberId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'family': family.toJson(),
      'role': role.toJson(),
      'memberId': memberId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'family': family.toJsonForProtocol(),
      'role': role.toJson(),
      'memberId': memberId,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _FamilyWithRoleImpl extends FamilyWithRole {
  _FamilyWithRoleImpl({
    required _i2.Family family,
    required _i3.FamilyRole role,
    required int memberId,
  }) : super._(
          family: family,
          role: role,
          memberId: memberId,
        );

  /// Returns a shallow copy of this [FamilyWithRole]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FamilyWithRole copyWith({
    _i2.Family? family,
    _i3.FamilyRole? role,
    int? memberId,
  }) {
    return FamilyWithRole(
      family: family ?? this.family.copyWith(),
      role: role ?? this.role,
      memberId: memberId ?? this.memberId,
    );
  }
}
