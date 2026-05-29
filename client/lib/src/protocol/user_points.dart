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

/// Punti gamification per membro.
abstract class UserPoints implements _i1.SerializableModel {
  UserPoints._({
    this.id,
    required this.userId,
    required this.familyId,
    int? points,
    int? streakDays,
    String? badgesJson,
  })  : points = points ?? 0,
        streakDays = streakDays ?? 0,
        badgesJson = badgesJson ?? '[]';

  factory UserPoints({
    int? id,
    required int userId,
    required int familyId,
    int? points,
    int? streakDays,
    String? badgesJson,
  }) = _UserPointsImpl;

  factory UserPoints.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserPoints(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      familyId: jsonSerialization['familyId'] as int,
      points: jsonSerialization['points'] as int,
      streakDays: jsonSerialization['streakDays'] as int,
      badgesJson: jsonSerialization['badgesJson'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  int familyId;

  int points;

  int streakDays;

  String badgesJson;

  /// Returns a shallow copy of this [UserPoints]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserPoints copyWith({
    int? id,
    int? userId,
    int? familyId,
    int? points,
    int? streakDays,
    String? badgesJson,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'familyId': familyId,
      'points': points,
      'streakDays': streakDays,
      'badgesJson': badgesJson,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserPointsImpl extends UserPoints {
  _UserPointsImpl({
    int? id,
    required int userId,
    required int familyId,
    int? points,
    int? streakDays,
    String? badgesJson,
  }) : super._(
          id: id,
          userId: userId,
          familyId: familyId,
          points: points,
          streakDays: streakDays,
          badgesJson: badgesJson,
        );

  /// Returns a shallow copy of this [UserPoints]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserPoints copyWith({
    Object? id = _Undefined,
    int? userId,
    int? familyId,
    int? points,
    int? streakDays,
    String? badgesJson,
  }) {
    return UserPoints(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      familyId: familyId ?? this.familyId,
      points: points ?? this.points,
      streakDays: streakDays ?? this.streakDays,
      badgesJson: badgesJson ?? this.badgesJson,
    );
  }
}
