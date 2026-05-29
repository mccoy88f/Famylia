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

enum DocumentCategory implements _i1.SerializableModel {
  receipt,
  invoice,
  contract,
  medical,
  warranty,
  id,
  other;

  static DocumentCategory fromJson(String name) {
    switch (name) {
      case 'receipt':
        return DocumentCategory.receipt;
      case 'invoice':
        return DocumentCategory.invoice;
      case 'contract':
        return DocumentCategory.contract;
      case 'medical':
        return DocumentCategory.medical;
      case 'warranty':
        return DocumentCategory.warranty;
      case 'id':
        return DocumentCategory.id;
      case 'other':
        return DocumentCategory.other;
      default:
        throw ArgumentError(
            'Value "$name" cannot be converted to "DocumentCategory"');
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
