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
import 'family_role.dart' as _i2;

/// Membro famiglia con nome visualizzabile (da auth).
abstract class FamilyMemberInfo
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  FamilyMemberInfo._({
    required this.userId,
    required this.role,
    required this.displayName,
  });

  factory FamilyMemberInfo({
    required int userId,
    required _i2.FamilyRole role,
    required String displayName,
  }) = _FamilyMemberInfoImpl;

  factory FamilyMemberInfo.fromJson(Map<String, dynamic> jsonSerialization) {
    return FamilyMemberInfo(
      userId: jsonSerialization['userId'] as int,
      role: _i2.FamilyRole.fromJson((jsonSerialization['role'] as String)),
      displayName: jsonSerialization['displayName'] as String,
    );
  }

  int userId;

  _i2.FamilyRole role;

  String displayName;

  /// Returns a shallow copy of this [FamilyMemberInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FamilyMemberInfo copyWith({
    int? userId,
    _i2.FamilyRole? role,
    String? displayName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'role': role.toJson(),
      'displayName': displayName,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'userId': userId,
      'role': role.toJson(),
      'displayName': displayName,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _FamilyMemberInfoImpl extends FamilyMemberInfo {
  _FamilyMemberInfoImpl({
    required int userId,
    required _i2.FamilyRole role,
    required String displayName,
  }) : super._(
          userId: userId,
          role: role,
          displayName: displayName,
        );

  /// Returns a shallow copy of this [FamilyMemberInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FamilyMemberInfo copyWith({
    int? userId,
    _i2.FamilyRole? role,
    String? displayName,
  }) {
    return FamilyMemberInfo(
      userId: userId ?? this.userId,
      role: role ?? this.role,
      displayName: displayName ?? this.displayName,
    );
  }
}
