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

/// Opzione sondaggio bacheca.
abstract class PollOption implements _i1.SerializableModel {
  PollOption._({
    this.id,
    required this.boardPostId,
    required this.text,
    String? votesJson,
  }) : votesJson = votesJson ?? '[]';

  factory PollOption({
    int? id,
    required int boardPostId,
    required String text,
    String? votesJson,
  }) = _PollOptionImpl;

  factory PollOption.fromJson(Map<String, dynamic> jsonSerialization) {
    return PollOption(
      id: jsonSerialization['id'] as int?,
      boardPostId: jsonSerialization['boardPostId'] as int,
      text: jsonSerialization['text'] as String,
      votesJson: jsonSerialization['votesJson'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int boardPostId;

  String text;

  String votesJson;

  /// Returns a shallow copy of this [PollOption]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PollOption copyWith({
    int? id,
    int? boardPostId,
    String? text,
    String? votesJson,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'boardPostId': boardPostId,
      'text': text,
      'votesJson': votesJson,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PollOptionImpl extends PollOption {
  _PollOptionImpl({
    int? id,
    required int boardPostId,
    required String text,
    String? votesJson,
  }) : super._(
          id: id,
          boardPostId: boardPostId,
          text: text,
          votesJson: votesJson,
        );

  /// Returns a shallow copy of this [PollOption]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PollOption copyWith({
    Object? id = _Undefined,
    int? boardPostId,
    String? text,
    String? votesJson,
  }) {
    return PollOption(
      id: id is int? ? id : this.id,
      boardPostId: boardPostId ?? this.boardPostId,
      text: text ?? this.text,
      votesJson: votesJson ?? this.votesJson,
    );
  }
}
