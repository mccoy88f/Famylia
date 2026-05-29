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
import 'leaderboard_entry.dart' as _i2;

abstract class Leaderboard implements _i1.SerializableModel {
  Leaderboard._({required this.entries});

  factory Leaderboard({required List<_i2.LeaderboardEntry> entries}) =
      _LeaderboardImpl;

  factory Leaderboard.fromJson(Map<String, dynamic> jsonSerialization) {
    return Leaderboard(
        entries: (jsonSerialization['entries'] as List)
            .map((e) =>
                _i2.LeaderboardEntry.fromJson((e as Map<String, dynamic>)))
            .toList());
  }

  List<_i2.LeaderboardEntry> entries;

  /// Returns a shallow copy of this [Leaderboard]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Leaderboard copyWith({List<_i2.LeaderboardEntry>? entries});
  @override
  Map<String, dynamic> toJson() {
    return {'entries': entries.toJson(valueToJson: (v) => v.toJson())};
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _LeaderboardImpl extends Leaderboard {
  _LeaderboardImpl({required List<_i2.LeaderboardEntry> entries})
      : super._(entries: entries);

  /// Returns a shallow copy of this [Leaderboard]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Leaderboard copyWith({List<_i2.LeaderboardEntry>? entries}) {
    return Leaderboard(
        entries: entries ?? this.entries.map((e0) => e0.copyWith()).toList());
  }
}
