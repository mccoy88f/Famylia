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

/// Risultato analisi contenuto condiviso.
abstract class SharedContentAnalysis implements _i1.SerializableModel {
  SharedContentAnalysis._({
    required this.title,
    required this.description,
    this.suggestedDeadline,
  });

  factory SharedContentAnalysis({
    required String title,
    required String description,
    String? suggestedDeadline,
  }) = _SharedContentAnalysisImpl;

  factory SharedContentAnalysis.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return SharedContentAnalysis(
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      suggestedDeadline: jsonSerialization['suggestedDeadline'] as String?,
    );
  }

  String title;

  String description;

  String? suggestedDeadline;

  /// Returns a shallow copy of this [SharedContentAnalysis]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SharedContentAnalysis copyWith({
    String? title,
    String? description,
    String? suggestedDeadline,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      if (suggestedDeadline != null) 'suggestedDeadline': suggestedDeadline,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SharedContentAnalysisImpl extends SharedContentAnalysis {
  _SharedContentAnalysisImpl({
    required String title,
    required String description,
    String? suggestedDeadline,
  }) : super._(
          title: title,
          description: description,
          suggestedDeadline: suggestedDeadline,
        );

  @_i1.useResult
  @override
  SharedContentAnalysis copyWith({
    String? title,
    String? description,
    Object? suggestedDeadline = _Undefined,
  }) {
    return SharedContentAnalysis(
      title: title ?? this.title,
      description: description ?? this.description,
      suggestedDeadline: suggestedDeadline is String?
          ? suggestedDeadline
          : this.suggestedDeadline,
    );
  }
}
