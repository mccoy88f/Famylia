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
import 'shopping_unit.dart' as _i2;
import 'shopping_category.dart' as _i3;

/// Articolo in lista spesa.
abstract class ShoppingItem implements _i1.SerializableModel {
  ShoppingItem._({
    this.id,
    required this.shoppingListId,
    required this.name,
    double? quantity,
    _i2.ShoppingUnit? unit,
    _i3.ShoppingCategory? category,
    bool? isChecked,
    this.checkedBy,
    this.checkedAt,
    this.priceEstimate,
    this.notes,
    required this.addedBy,
    bool? isUrgent,
  })  : quantity = quantity ?? 1.0,
        unit = unit ?? _i2.ShoppingUnit.pieces,
        category = category ?? _i3.ShoppingCategory.other,
        isChecked = isChecked ?? false,
        isUrgent = isUrgent ?? false;

  factory ShoppingItem({
    int? id,
    required int shoppingListId,
    required String name,
    double? quantity,
    _i2.ShoppingUnit? unit,
    _i3.ShoppingCategory? category,
    bool? isChecked,
    int? checkedBy,
    DateTime? checkedAt,
    double? priceEstimate,
    String? notes,
    required int addedBy,
    bool? isUrgent,
  }) = _ShoppingItemImpl;

  factory ShoppingItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return ShoppingItem(
      id: jsonSerialization['id'] as int?,
      shoppingListId: jsonSerialization['shoppingListId'] as int,
      name: jsonSerialization['name'] as String,
      quantity: (jsonSerialization['quantity'] as num).toDouble(),
      unit: _i2.ShoppingUnit.fromJson((jsonSerialization['unit'] as String)),
      category: _i3.ShoppingCategory.fromJson(
          (jsonSerialization['category'] as String)),
      isChecked: jsonSerialization['isChecked'] as bool,
      checkedBy: jsonSerialization['checkedBy'] as int?,
      checkedAt: jsonSerialization['checkedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['checkedAt']),
      priceEstimate: (jsonSerialization['priceEstimate'] as num?)?.toDouble(),
      notes: jsonSerialization['notes'] as String?,
      addedBy: jsonSerialization['addedBy'] as int,
      isUrgent: jsonSerialization['isUrgent'] as bool,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int shoppingListId;

  String name;

  double quantity;

  _i2.ShoppingUnit unit;

  _i3.ShoppingCategory category;

  bool isChecked;

  int? checkedBy;

  DateTime? checkedAt;

  double? priceEstimate;

  String? notes;

  int addedBy;

  bool isUrgent;

  /// Returns a shallow copy of this [ShoppingItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ShoppingItem copyWith({
    int? id,
    int? shoppingListId,
    String? name,
    double? quantity,
    _i2.ShoppingUnit? unit,
    _i3.ShoppingCategory? category,
    bool? isChecked,
    int? checkedBy,
    DateTime? checkedAt,
    double? priceEstimate,
    String? notes,
    int? addedBy,
    bool? isUrgent,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'shoppingListId': shoppingListId,
      'name': name,
      'quantity': quantity,
      'unit': unit.toJson(),
      'category': category.toJson(),
      'isChecked': isChecked,
      if (checkedBy != null) 'checkedBy': checkedBy,
      if (checkedAt != null) 'checkedAt': checkedAt?.toJson(),
      if (priceEstimate != null) 'priceEstimate': priceEstimate,
      if (notes != null) 'notes': notes,
      'addedBy': addedBy,
      'isUrgent': isUrgent,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ShoppingItemImpl extends ShoppingItem {
  _ShoppingItemImpl({
    int? id,
    required int shoppingListId,
    required String name,
    double? quantity,
    _i2.ShoppingUnit? unit,
    _i3.ShoppingCategory? category,
    bool? isChecked,
    int? checkedBy,
    DateTime? checkedAt,
    double? priceEstimate,
    String? notes,
    required int addedBy,
    bool? isUrgent,
  }) : super._(
          id: id,
          shoppingListId: shoppingListId,
          name: name,
          quantity: quantity,
          unit: unit,
          category: category,
          isChecked: isChecked,
          checkedBy: checkedBy,
          checkedAt: checkedAt,
          priceEstimate: priceEstimate,
          notes: notes,
          addedBy: addedBy,
          isUrgent: isUrgent,
        );

  /// Returns a shallow copy of this [ShoppingItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ShoppingItem copyWith({
    Object? id = _Undefined,
    int? shoppingListId,
    String? name,
    double? quantity,
    _i2.ShoppingUnit? unit,
    _i3.ShoppingCategory? category,
    bool? isChecked,
    Object? checkedBy = _Undefined,
    Object? checkedAt = _Undefined,
    Object? priceEstimate = _Undefined,
    Object? notes = _Undefined,
    int? addedBy,
    bool? isUrgent,
  }) {
    return ShoppingItem(
      id: id is int? ? id : this.id,
      shoppingListId: shoppingListId ?? this.shoppingListId,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      category: category ?? this.category,
      isChecked: isChecked ?? this.isChecked,
      checkedBy: checkedBy is int? ? checkedBy : this.checkedBy,
      checkedAt: checkedAt is DateTime? ? checkedAt : this.checkedAt,
      priceEstimate:
          priceEstimate is double? ? priceEstimate : this.priceEstimate,
      notes: notes is String? ? notes : this.notes,
      addedBy: addedBy ?? this.addedBy,
      isUrgent: isUrgent ?? this.isUrgent,
    );
  }
}
