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

enum ExpenseCategory implements _i1.SerializableModel {
  grocery,
  bills,
  transport,
  health,
  entertainment,
  home,
  education,
  other;

  static ExpenseCategory fromJson(String name) {
    switch (name) {
      case 'grocery':
        return ExpenseCategory.grocery;
      case 'bills':
        return ExpenseCategory.bills;
      case 'transport':
        return ExpenseCategory.transport;
      case 'health':
        return ExpenseCategory.health;
      case 'entertainment':
        return ExpenseCategory.entertainment;
      case 'home':
        return ExpenseCategory.home;
      case 'education':
        return ExpenseCategory.education;
      case 'other':
        return ExpenseCategory.other;
      default:
        throw ArgumentError(
            'Value "$name" cannot be converted to "ExpenseCategory"');
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
