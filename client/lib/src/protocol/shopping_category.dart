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

enum ShoppingCategory implements _i1.SerializableModel {
  dairy,
  meat,
  vegetables,
  fruit,
  bakery,
  beverages,
  frozen,
  household,
  personal,
  other;

  static ShoppingCategory fromJson(String name) {
    switch (name) {
      case 'dairy':
        return ShoppingCategory.dairy;
      case 'meat':
        return ShoppingCategory.meat;
      case 'vegetables':
        return ShoppingCategory.vegetables;
      case 'fruit':
        return ShoppingCategory.fruit;
      case 'bakery':
        return ShoppingCategory.bakery;
      case 'beverages':
        return ShoppingCategory.beverages;
      case 'frozen':
        return ShoppingCategory.frozen;
      case 'household':
        return ShoppingCategory.household;
      case 'personal':
        return ShoppingCategory.personal;
      case 'other':
        return ShoppingCategory.other;
      default:
        throw ArgumentError(
            'Value "$name" cannot be converted to "ShoppingCategory"');
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
