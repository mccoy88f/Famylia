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

/// Notifica aggiornamento lista spesa (real-time).
abstract class ShoppingListChanged implements _i1.SerializableModel {
  ShoppingListChanged._({required this.listId});

  factory ShoppingListChanged({required int listId}) = _ShoppingListChangedImpl;

  factory ShoppingListChanged.fromJson(Map<String, dynamic> jsonSerialization) {
    return ShoppingListChanged(listId: jsonSerialization['listId'] as int);
  }

  int listId;

  /// Returns a shallow copy of this [ShoppingListChanged]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ShoppingListChanged copyWith({int? listId});
  @override
  Map<String, dynamic> toJson() {
    return {'listId': listId};
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _ShoppingListChangedImpl extends ShoppingListChanged {
  _ShoppingListChangedImpl({required int listId}) : super._(listId: listId);

  /// Returns a shallow copy of this [ShoppingListChanged]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ShoppingListChanged copyWith({int? listId}) {
    return ShoppingListChanged(listId: listId ?? this.listId);
  }
}
