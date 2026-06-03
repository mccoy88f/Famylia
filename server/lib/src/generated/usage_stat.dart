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

/// Statistiche utilizzo token per famiglia.
abstract class UsageStat
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  UsageStat._({
    required this.familyId,
    required this.inputTokens,
    required this.outputTokens,
    required this.costUsd,
    required this.calls,
  });

  factory UsageStat({
    required int familyId,
    required int inputTokens,
    required int outputTokens,
    required double costUsd,
    required int calls,
  }) = _UsageStatImpl;

  factory UsageStat.fromJson(Map<String, dynamic> jsonSerialization) {
    return UsageStat(
      familyId: jsonSerialization['familyId'] as int,
      inputTokens: jsonSerialization['inputTokens'] as int,
      outputTokens: jsonSerialization['outputTokens'] as int,
      costUsd: (jsonSerialization['costUsd'] as num).toDouble(),
      calls: jsonSerialization['calls'] as int,
    );
  }

  int familyId;

  int inputTokens;

  int outputTokens;

  double costUsd;

  int calls;

  @_i1.useResult
  UsageStat copyWith({
    int? familyId,
    int? inputTokens,
    int? outputTokens,
    double? costUsd,
    int? calls,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'familyId': familyId,
      'inputTokens': inputTokens,
      'outputTokens': outputTokens,
      'costUsd': costUsd,
      'calls': calls,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'familyId': familyId,
      'inputTokens': inputTokens,
      'outputTokens': outputTokens,
      'costUsd': costUsd,
      'calls': calls,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UsageStatImpl extends UsageStat {
  _UsageStatImpl({
    required int familyId,
    required int inputTokens,
    required int outputTokens,
    required double costUsd,
    required int calls,
  }) : super._(
          familyId: familyId,
          inputTokens: inputTokens,
          outputTokens: outputTokens,
          costUsd: costUsd,
          calls: calls,
        );

  @_i1.useResult
  @override
  UsageStat copyWith({
    int? familyId,
    int? inputTokens,
    int? outputTokens,
    double? costUsd,
    int? calls,
  }) {
    return UsageStat(
      familyId: familyId ?? this.familyId,
      inputTokens: inputTokens ?? this.inputTokens,
      outputTokens: outputTokens ?? this.outputTokens,
      costUsd: costUsd ?? this.costUsd,
      calls: calls ?? this.calls,
    );
  }
}
