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
import 'family_goal_status.dart' as _i2;

/// Obiettivo con premio in denaro per un membro della famiglia.
abstract class FamilyGoal implements _i1.SerializableModel {
  FamilyGoal._({
    this.id,
    required this.familyId,
    required this.createdBy,
    required this.targetUserId,
    required this.title,
    this.description,
    required this.targetPoints,
    required this.rewardAmount,
    this.deadline,
    _i2.FamilyGoalStatus? status,
    this.completedAt,
    this.paidAt,
    this.paidBy,
  }) : status = status ?? _i2.FamilyGoalStatus.active;

  factory FamilyGoal({
    int? id,
    required int familyId,
    required int createdBy,
    required int targetUserId,
    required String title,
    String? description,
    required int targetPoints,
    required double rewardAmount,
    DateTime? deadline,
    _i2.FamilyGoalStatus? status,
    DateTime? completedAt,
    DateTime? paidAt,
    int? paidBy,
  }) = _FamilyGoalImpl;

  factory FamilyGoal.fromJson(Map<String, dynamic> jsonSerialization) {
    return FamilyGoal(
      id: jsonSerialization['id'] as int?,
      familyId: jsonSerialization['familyId'] as int,
      createdBy: jsonSerialization['createdBy'] as int,
      targetUserId: jsonSerialization['targetUserId'] as int,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      targetPoints: jsonSerialization['targetPoints'] as int,
      rewardAmount: (jsonSerialization['rewardAmount'] as num).toDouble(),
      deadline: jsonSerialization['deadline'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['deadline']),
      status: _i2.FamilyGoalStatus.fromJson(
          (jsonSerialization['status'] as String)),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt']),
      paidAt: jsonSerialization['paidAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['paidAt']),
      paidBy: jsonSerialization['paidBy'] as int?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int familyId;

  int createdBy;

  int targetUserId;

  String title;

  String? description;

  int targetPoints;

  double rewardAmount;

  DateTime? deadline;

  _i2.FamilyGoalStatus status;

  DateTime? completedAt;

  DateTime? paidAt;

  int? paidBy;

  /// Returns a shallow copy of this [FamilyGoal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FamilyGoal copyWith({
    int? id,
    int? familyId,
    int? createdBy,
    int? targetUserId,
    String? title,
    String? description,
    int? targetPoints,
    double? rewardAmount,
    DateTime? deadline,
    _i2.FamilyGoalStatus? status,
    DateTime? completedAt,
    DateTime? paidAt,
    int? paidBy,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'familyId': familyId,
      'createdBy': createdBy,
      'targetUserId': targetUserId,
      'title': title,
      if (description != null) 'description': description,
      'targetPoints': targetPoints,
      'rewardAmount': rewardAmount,
      if (deadline != null) 'deadline': deadline?.toJson(),
      'status': status.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (paidAt != null) 'paidAt': paidAt?.toJson(),
      if (paidBy != null) 'paidBy': paidBy,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FamilyGoalImpl extends FamilyGoal {
  _FamilyGoalImpl({
    int? id,
    required int familyId,
    required int createdBy,
    required int targetUserId,
    required String title,
    String? description,
    required int targetPoints,
    required double rewardAmount,
    DateTime? deadline,
    _i2.FamilyGoalStatus? status,
    DateTime? completedAt,
    DateTime? paidAt,
    int? paidBy,
  }) : super._(
          id: id,
          familyId: familyId,
          createdBy: createdBy,
          targetUserId: targetUserId,
          title: title,
          description: description,
          targetPoints: targetPoints,
          rewardAmount: rewardAmount,
          deadline: deadline,
          status: status,
          completedAt: completedAt,
          paidAt: paidAt,
          paidBy: paidBy,
        );

  /// Returns a shallow copy of this [FamilyGoal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FamilyGoal copyWith({
    Object? id = _Undefined,
    int? familyId,
    int? createdBy,
    int? targetUserId,
    String? title,
    Object? description = _Undefined,
    int? targetPoints,
    double? rewardAmount,
    Object? deadline = _Undefined,
    _i2.FamilyGoalStatus? status,
    Object? completedAt = _Undefined,
    Object? paidAt = _Undefined,
    Object? paidBy = _Undefined,
  }) {
    return FamilyGoal(
      id: id is int? ? id : this.id,
      familyId: familyId ?? this.familyId,
      createdBy: createdBy ?? this.createdBy,
      targetUserId: targetUserId ?? this.targetUserId,
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      targetPoints: targetPoints ?? this.targetPoints,
      rewardAmount: rewardAmount ?? this.rewardAmount,
      deadline: deadline is DateTime? ? deadline : this.deadline,
      status: status ?? this.status,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
      paidAt: paidAt is DateTime? ? paidAt : this.paidAt,
      paidBy: paidBy is int? ? paidBy : this.paidBy,
    );
  }
}
