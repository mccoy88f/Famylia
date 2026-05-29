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

/// Notifica aggiornamento bacheca (real-time).
abstract class BoardChanged implements _i1.SerializableModel {
  BoardChanged._({required this.familyId});

  factory BoardChanged({required int familyId}) = _BoardChangedImpl;

  factory BoardChanged.fromJson(Map<String, dynamic> jsonSerialization) {
    return BoardChanged(familyId: jsonSerialization['familyId'] as int);
  }

  int familyId;

  /// Returns a shallow copy of this [BoardChanged]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BoardChanged copyWith({int? familyId});
  @override
  Map<String, dynamic> toJson() {
    return {'familyId': familyId};
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _BoardChangedImpl extends BoardChanged {
  _BoardChangedImpl({required int familyId}) : super._(familyId: familyId);

  /// Returns a shallow copy of this [BoardChanged]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BoardChanged copyWith({int? familyId}) {
    return BoardChanged(familyId: familyId ?? this.familyId);
  }
}
