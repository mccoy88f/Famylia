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

/// Piano pasti settimanale.
abstract class MealPlan implements _i1.SerializableModel {
  MealPlan._({
    this.id,
    required this.familyId,
    required this.createdBy,
    required this.weekStart,
    String? mealsJson,
  }) : mealsJson = mealsJson ?? '[]';

  factory MealPlan({
    int? id,
    required int familyId,
    required int createdBy,
    required DateTime weekStart,
    String? mealsJson,
  }) = _MealPlanImpl;

  factory MealPlan.fromJson(Map<String, dynamic> jsonSerialization) {
    return MealPlan(
      id: jsonSerialization['id'] as int?,
      familyId: jsonSerialization['familyId'] as int,
      createdBy: jsonSerialization['createdBy'] as int,
      weekStart:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['weekStart']),
      mealsJson: jsonSerialization['mealsJson'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int familyId;

  int createdBy;

  DateTime weekStart;

  String mealsJson;

  /// Returns a shallow copy of this [MealPlan]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MealPlan copyWith({
    int? id,
    int? familyId,
    int? createdBy,
    DateTime? weekStart,
    String? mealsJson,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'familyId': familyId,
      'createdBy': createdBy,
      'weekStart': weekStart.toJson(),
      'mealsJson': mealsJson,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MealPlanImpl extends MealPlan {
  _MealPlanImpl({
    int? id,
    required int familyId,
    required int createdBy,
    required DateTime weekStart,
    String? mealsJson,
  }) : super._(
          id: id,
          familyId: familyId,
          createdBy: createdBy,
          weekStart: weekStart,
          mealsJson: mealsJson,
        );

  /// Returns a shallow copy of this [MealPlan]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MealPlan copyWith({
    Object? id = _Undefined,
    int? familyId,
    int? createdBy,
    DateTime? weekStart,
    String? mealsJson,
  }) {
    return MealPlan(
      id: id is int? ? id : this.id,
      familyId: familyId ?? this.familyId,
      createdBy: createdBy ?? this.createdBy,
      weekStart: weekStart ?? this.weekStart,
      mealsJson: mealsJson ?? this.mealsJson,
    );
  }
}
