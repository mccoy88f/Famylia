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
import 'family_role.dart' as _i2;

/// Appartenenza utente ↔ famiglia.
abstract class FamilyMember implements _i1.SerializableModel {
  FamilyMember._({
    this.id,
    required this.userId,
    required this.familyId,
    _i2.FamilyRole? role,
  }) : role = role ?? _i2.FamilyRole.member;

  factory FamilyMember({
    int? id,
    required int userId,
    required int familyId,
    _i2.FamilyRole? role,
  }) = _FamilyMemberImpl;

  factory FamilyMember.fromJson(Map<String, dynamic> jsonSerialization) {
    return FamilyMember(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      familyId: jsonSerialization['familyId'] as int,
      role: _i2.FamilyRole.fromJson((jsonSerialization['role'] as String)),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  int familyId;

  _i2.FamilyRole role;

  /// Returns a shallow copy of this [FamilyMember]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FamilyMember copyWith({
    int? id,
    int? userId,
    int? familyId,
    _i2.FamilyRole? role,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'familyId': familyId,
      'role': role.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FamilyMemberImpl extends FamilyMember {
  _FamilyMemberImpl({
    int? id,
    required int userId,
    required int familyId,
    _i2.FamilyRole? role,
  }) : super._(
          id: id,
          userId: userId,
          familyId: familyId,
          role: role,
        );

  /// Returns a shallow copy of this [FamilyMember]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FamilyMember copyWith({
    Object? id = _Undefined,
    int? userId,
    int? familyId,
    _i2.FamilyRole? role,
  }) {
    return FamilyMember(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      familyId: familyId ?? this.familyId,
      role: role ?? this.role,
    );
  }
}
