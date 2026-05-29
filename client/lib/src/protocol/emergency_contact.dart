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

/// Contatto emergenza familiare.
abstract class EmergencyContact implements _i1.SerializableModel {
  EmergencyContact._({
    this.id,
    required this.familyId,
    required this.createdBy,
    required this.name,
    required this.phone,
    this.email,
    int? priority,
    this.notes,
  }) : priority = priority ?? 1;

  factory EmergencyContact({
    int? id,
    required int familyId,
    required int createdBy,
    required String name,
    required String phone,
    String? email,
    int? priority,
    String? notes,
  }) = _EmergencyContactImpl;

  factory EmergencyContact.fromJson(Map<String, dynamic> jsonSerialization) {
    return EmergencyContact(
      id: jsonSerialization['id'] as int?,
      familyId: jsonSerialization['familyId'] as int,
      createdBy: jsonSerialization['createdBy'] as int,
      name: jsonSerialization['name'] as String,
      phone: jsonSerialization['phone'] as String,
      email: jsonSerialization['email'] as String?,
      priority: jsonSerialization['priority'] as int,
      notes: jsonSerialization['notes'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int familyId;

  int createdBy;

  String name;

  String phone;

  String? email;

  int priority;

  String? notes;

  /// Returns a shallow copy of this [EmergencyContact]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EmergencyContact copyWith({
    int? id,
    int? familyId,
    int? createdBy,
    String? name,
    String? phone,
    String? email,
    int? priority,
    String? notes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'familyId': familyId,
      'createdBy': createdBy,
      'name': name,
      'phone': phone,
      if (email != null) 'email': email,
      'priority': priority,
      if (notes != null) 'notes': notes,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EmergencyContactImpl extends EmergencyContact {
  _EmergencyContactImpl({
    int? id,
    required int familyId,
    required int createdBy,
    required String name,
    required String phone,
    String? email,
    int? priority,
    String? notes,
  }) : super._(
          id: id,
          familyId: familyId,
          createdBy: createdBy,
          name: name,
          phone: phone,
          email: email,
          priority: priority,
          notes: notes,
        );

  /// Returns a shallow copy of this [EmergencyContact]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EmergencyContact copyWith({
    Object? id = _Undefined,
    int? familyId,
    int? createdBy,
    String? name,
    String? phone,
    Object? email = _Undefined,
    int? priority,
    Object? notes = _Undefined,
  }) {
    return EmergencyContact(
      id: id is int? ? id : this.id,
      familyId: familyId ?? this.familyId,
      createdBy: createdBy ?? this.createdBy,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email is String? ? email : this.email,
      priority: priority ?? this.priority,
      notes: notes is String? ? notes : this.notes,
    );
  }
}
