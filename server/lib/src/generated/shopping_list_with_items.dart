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
import 'shopping_list.dart' as _i2;
import 'shopping_item.dart' as _i3;

/// Lista spesa con articoli (risposta API).
abstract class ShoppingListWithItems
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  ShoppingListWithItems._({
    required this.list,
    required this.items,
  });

  factory ShoppingListWithItems({
    required _i2.ShoppingList list,
    required List<_i3.ShoppingItem> items,
  }) = _ShoppingListWithItemsImpl;

  factory ShoppingListWithItems.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return ShoppingListWithItems(
      list: _i2.ShoppingList.fromJson(
          (jsonSerialization['list'] as Map<String, dynamic>)),
      items: (jsonSerialization['items'] as List)
          .map((e) => _i3.ShoppingItem.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  _i2.ShoppingList list;

  List<_i3.ShoppingItem> items;

  /// Returns a shallow copy of this [ShoppingListWithItems]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ShoppingListWithItems copyWith({
    _i2.ShoppingList? list,
    List<_i3.ShoppingItem>? items,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'list': list.toJson(),
      'items': items.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'list': list.toJsonForProtocol(),
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _ShoppingListWithItemsImpl extends ShoppingListWithItems {
  _ShoppingListWithItemsImpl({
    required _i2.ShoppingList list,
    required List<_i3.ShoppingItem> items,
  }) : super._(
          list: list,
          items: items,
        );

  /// Returns a shallow copy of this [ShoppingListWithItems]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ShoppingListWithItems copyWith({
    _i2.ShoppingList? list,
    List<_i3.ShoppingItem>? items,
  }) {
    return ShoppingListWithItems(
      list: list ?? this.list.copyWith(),
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
    );
  }
}
