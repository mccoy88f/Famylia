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
import 'shopping_list_status.dart' as _i2;

/// Lista della spesa.
abstract class ShoppingList implements _i1.SerializableModel {
  ShoppingList._({
    this.id,
    required this.familyId,
    required this.createdBy,
    required this.name,
    this.store,
    _i2.ShoppingListStatus? status,
    this.assignedTo,
    this.dueDate,
  }) : status = status ?? _i2.ShoppingListStatus.active;

  factory ShoppingList({
    int? id,
    required int familyId,
    required int createdBy,
    required String name,
    String? store,
    _i2.ShoppingListStatus? status,
    int? assignedTo,
    DateTime? dueDate,
  }) = _ShoppingListImpl;

  factory ShoppingList.fromJson(Map<String, dynamic> jsonSerialization) {
    return ShoppingList(
      id: jsonSerialization['id'] as int?,
      familyId: jsonSerialization['familyId'] as int,
      createdBy: jsonSerialization['createdBy'] as int,
      name: jsonSerialization['name'] as String,
      store: jsonSerialization['store'] as String?,
      status: _i2.ShoppingListStatus.fromJson(
          (jsonSerialization['status'] as String)),
      assignedTo: jsonSerialization['assignedTo'] as int?,
      dueDate: jsonSerialization['dueDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dueDate']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int familyId;

  int createdBy;

  String name;

  String? store;

  _i2.ShoppingListStatus status;

  int? assignedTo;

  DateTime? dueDate;

  /// Returns a shallow copy of this [ShoppingList]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ShoppingList copyWith({
    int? id,
    int? familyId,
    int? createdBy,
    String? name,
    String? store,
    _i2.ShoppingListStatus? status,
    int? assignedTo,
    DateTime? dueDate,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'familyId': familyId,
      'createdBy': createdBy,
      'name': name,
      if (store != null) 'store': store,
      'status': status.toJson(),
      if (assignedTo != null) 'assignedTo': assignedTo,
      if (dueDate != null) 'dueDate': dueDate?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ShoppingListImpl extends ShoppingList {
  _ShoppingListImpl({
    int? id,
    required int familyId,
    required int createdBy,
    required String name,
    String? store,
    _i2.ShoppingListStatus? status,
    int? assignedTo,
    DateTime? dueDate,
  }) : super._(
          id: id,
          familyId: familyId,
          createdBy: createdBy,
          name: name,
          store: store,
          status: status,
          assignedTo: assignedTo,
          dueDate: dueDate,
        );

  /// Returns a shallow copy of this [ShoppingList]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ShoppingList copyWith({
    Object? id = _Undefined,
    int? familyId,
    int? createdBy,
    String? name,
    Object? store = _Undefined,
    _i2.ShoppingListStatus? status,
    Object? assignedTo = _Undefined,
    Object? dueDate = _Undefined,
  }) {
    return ShoppingList(
      id: id is int? ? id : this.id,
      familyId: familyId ?? this.familyId,
      createdBy: createdBy ?? this.createdBy,
      name: name ?? this.name,
      store: store is String? ? store : this.store,
      status: status ?? this.status,
      assignedTo: assignedTo is int? ? assignedTo : this.assignedTo,
      dueDate: dueDate is DateTime? ? dueDate : this.dueDate,
    );
  }
}
