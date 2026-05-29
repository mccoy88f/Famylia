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

enum TodoCategory implements _i1.SerializableModel {
  cleaning,
  cooking,
  shopping,
  maintenance,
  kids,
  admin,
  other;

  static TodoCategory fromJson(String name) {
    switch (name) {
      case 'cleaning':
        return TodoCategory.cleaning;
      case 'cooking':
        return TodoCategory.cooking;
      case 'shopping':
        return TodoCategory.shopping;
      case 'maintenance':
        return TodoCategory.maintenance;
      case 'kids':
        return TodoCategory.kids;
      case 'admin':
        return TodoCategory.admin;
      case 'other':
        return TodoCategory.other;
      default:
        throw ArgumentError(
            'Value "$name" cannot be converted to "TodoCategory"');
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
