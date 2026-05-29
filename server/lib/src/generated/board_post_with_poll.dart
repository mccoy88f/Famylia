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
import 'board_post.dart' as _i2;
import 'poll_option.dart' as _i3;

/// Post bacheca con opzioni sondaggio.
abstract class BoardPostWithPoll
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  BoardPostWithPoll._({
    required this.post,
    required this.options,
  });

  factory BoardPostWithPoll({
    required _i2.BoardPost post,
    required List<_i3.PollOption> options,
  }) = _BoardPostWithPollImpl;

  factory BoardPostWithPoll.fromJson(Map<String, dynamic> jsonSerialization) {
    return BoardPostWithPoll(
      post: _i2.BoardPost.fromJson(
          (jsonSerialization['post'] as Map<String, dynamic>)),
      options: (jsonSerialization['options'] as List)
          .map((e) => _i3.PollOption.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  _i2.BoardPost post;

  List<_i3.PollOption> options;

  /// Returns a shallow copy of this [BoardPostWithPoll]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BoardPostWithPoll copyWith({
    _i2.BoardPost? post,
    List<_i3.PollOption>? options,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'post': post.toJson(),
      'options': options.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'post': post.toJsonForProtocol(),
      'options': options.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _BoardPostWithPollImpl extends BoardPostWithPoll {
  _BoardPostWithPollImpl({
    required _i2.BoardPost post,
    required List<_i3.PollOption> options,
  }) : super._(
          post: post,
          options: options,
        );

  /// Returns a shallow copy of this [BoardPostWithPoll]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BoardPostWithPoll copyWith({
    _i2.BoardPost? post,
    List<_i3.PollOption>? options,
  }) {
    return BoardPostWithPoll(
      post: post ?? this.post.copyWith(),
      options: options ?? this.options.map((e0) => e0.copyWith()).toList(),
    );
  }
}
