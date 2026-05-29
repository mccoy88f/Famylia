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

abstract class LeaderboardEntry
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  LeaderboardEntry._({
    required this.userId,
    required this.displayName,
    required this.points,
    required this.badgesJson,
  });

  factory LeaderboardEntry({
    required int userId,
    required String displayName,
    required int points,
    required String badgesJson,
  }) = _LeaderboardEntryImpl;

  factory LeaderboardEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return LeaderboardEntry(
      userId: jsonSerialization['userId'] as int,
      displayName: jsonSerialization['displayName'] as String,
      points: jsonSerialization['points'] as int,
      badgesJson: jsonSerialization['badgesJson'] as String,
    );
  }

  int userId;

  String displayName;

  int points;

  String badgesJson;

  /// Returns a shallow copy of this [LeaderboardEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LeaderboardEntry copyWith({
    int? userId,
    String? displayName,
    int? points,
    String? badgesJson,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'displayName': displayName,
      'points': points,
      'badgesJson': badgesJson,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'userId': userId,
      'displayName': displayName,
      'points': points,
      'badgesJson': badgesJson,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _LeaderboardEntryImpl extends LeaderboardEntry {
  _LeaderboardEntryImpl({
    required int userId,
    required String displayName,
    required int points,
    required String badgesJson,
  }) : super._(
          userId: userId,
          displayName: displayName,
          points: points,
          badgesJson: badgesJson,
        );

  /// Returns a shallow copy of this [LeaderboardEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LeaderboardEntry copyWith({
    int? userId,
    String? displayName,
    int? points,
    String? badgesJson,
  }) {
    return LeaderboardEntry(
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      points: points ?? this.points,
      badgesJson: badgesJson ?? this.badgesJson,
    );
  }
}
