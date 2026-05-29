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

/// Errore API Famylia (messaggio leggibile lato client).
abstract class FamyliaException
    implements _i1.SerializableException, _i1.SerializableModel {
  FamyliaException._({required this.message});

  factory FamyliaException({required String message}) = _FamyliaExceptionImpl;

  factory FamyliaException.fromJson(Map<String, dynamic> jsonSerialization) {
    return FamyliaException(message: jsonSerialization['message'] as String);
  }

  String message;

  /// Returns a shallow copy of this [FamyliaException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FamyliaException copyWith({String? message});
  @override
  Map<String, dynamic> toJson() {
    return {'message': message};
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _FamyliaExceptionImpl extends FamyliaException {
  _FamyliaExceptionImpl({required String message}) : super._(message: message);

  /// Returns a shallow copy of this [FamyliaException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FamyliaException copyWith({String? message}) {
    return FamyliaException(message: message ?? this.message);
  }
}
