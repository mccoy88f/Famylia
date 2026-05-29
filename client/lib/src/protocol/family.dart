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

/// Gruppo familiare Famylia.
abstract class Family implements _i1.SerializableModel {
  Family._({
    this.id,
    required this.name,
    required this.inviteCode,
    this.settings,
  });

  factory Family({
    int? id,
    required String name,
    required String inviteCode,
    String? settings,
  }) = _FamilyImpl;

  factory Family.fromJson(Map<String, dynamic> jsonSerialization) {
    return Family(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      inviteCode: jsonSerialization['inviteCode'] as String,
      settings: jsonSerialization['settings'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String inviteCode;

  String? settings;

  /// Returns a shallow copy of this [Family]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Family copyWith({
    int? id,
    String? name,
    String? inviteCode,
    String? settings,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'inviteCode': inviteCode,
      if (settings != null) 'settings': settings,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FamilyImpl extends Family {
  _FamilyImpl({
    int? id,
    required String name,
    required String inviteCode,
    String? settings,
  }) : super._(
          id: id,
          name: name,
          inviteCode: inviteCode,
          settings: settings,
        );

  /// Returns a shallow copy of this [Family]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Family copyWith({
    Object? id = _Undefined,
    String? name,
    String? inviteCode,
    Object? settings = _Undefined,
  }) {
    return Family(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      inviteCode: inviteCode ?? this.inviteCode,
      settings: settings is String? ? settings : this.settings,
    );
  }
}
