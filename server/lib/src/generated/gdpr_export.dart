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

abstract class GdprExport
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  GdprExport._({
    required this.exportedAt,
    required this.payloadJson,
  });

  factory GdprExport({
    required DateTime exportedAt,
    required String payloadJson,
  }) = _GdprExportImpl;

  factory GdprExport.fromJson(Map<String, dynamic> jsonSerialization) {
    return GdprExport(
      exportedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['exportedAt']),
      payloadJson: jsonSerialization['payloadJson'] as String,
    );
  }

  DateTime exportedAt;

  String payloadJson;

  /// Returns a shallow copy of this [GdprExport]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  GdprExport copyWith({
    DateTime? exportedAt,
    String? payloadJson,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'exportedAt': exportedAt.toJson(),
      'payloadJson': payloadJson,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'exportedAt': exportedAt.toJson(),
      'payloadJson': payloadJson,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _GdprExportImpl extends GdprExport {
  _GdprExportImpl({
    required DateTime exportedAt,
    required String payloadJson,
  }) : super._(
          exportedAt: exportedAt,
          payloadJson: payloadJson,
        );

  /// Returns a shallow copy of this [GdprExport]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  GdprExport copyWith({
    DateTime? exportedAt,
    String? payloadJson,
  }) {
    return GdprExport(
      exportedAt: exportedAt ?? this.exportedAt,
      payloadJson: payloadJson ?? this.payloadJson,
    );
  }
}
