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

/// Limiti mensili di utilizzo AI per famiglia.
abstract class FamilyQuota implements _i1.SerializableModel {
  FamilyQuota._({
    this.id,
    required this.familyId,
    this.monthlyTokenLimit,
    this.monthlyCostLimitUsd,
    this.updatedAt,
  });

  factory FamilyQuota({
    int? id,
    required int familyId,
    int? monthlyTokenLimit,
    double? monthlyCostLimitUsd,
    DateTime? updatedAt,
  }) = _FamilyQuotaImpl;

  factory FamilyQuota.fromJson(Map<String, dynamic> jsonSerialization) {
    return FamilyQuota(
      id: jsonSerialization['id'] as int?,
      familyId: jsonSerialization['familyId'] as int,
      monthlyTokenLimit: jsonSerialization['monthlyTokenLimit'] as int?,
      monthlyCostLimitUsd:
          (jsonSerialization['monthlyCostLimitUsd'] as num?)?.toDouble(),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  int? id;

  int familyId;

  int? monthlyTokenLimit;

  double? monthlyCostLimitUsd;

  DateTime? updatedAt;

  @_i1.useResult
  FamilyQuota copyWith({
    int? id,
    int? familyId,
    int? monthlyTokenLimit,
    double? monthlyCostLimitUsd,
    DateTime? updatedAt,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'familyId': familyId,
      if (monthlyTokenLimit != null) 'monthlyTokenLimit': monthlyTokenLimit,
      if (monthlyCostLimitUsd != null)
        'monthlyCostLimitUsd': monthlyCostLimitUsd,
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FamilyQuotaImpl extends FamilyQuota {
  _FamilyQuotaImpl({
    int? id,
    required int familyId,
    int? monthlyTokenLimit,
    double? monthlyCostLimitUsd,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          familyId: familyId,
          monthlyTokenLimit: monthlyTokenLimit,
          monthlyCostLimitUsd: monthlyCostLimitUsd,
          updatedAt: updatedAt,
        );

  @_i1.useResult
  @override
  FamilyQuota copyWith({
    Object? id = _Undefined,
    int? familyId,
    Object? monthlyTokenLimit = _Undefined,
    Object? monthlyCostLimitUsd = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return FamilyQuota(
      id: id is int? ? id : this.id,
      familyId: familyId ?? this.familyId,
      monthlyTokenLimit:
          monthlyTokenLimit is int? ? monthlyTokenLimit : this.monthlyTokenLimit,
      monthlyCostLimitUsd: monthlyCostLimitUsd is double?
          ? monthlyCostLimitUsd
          : this.monthlyCostLimitUsd,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
