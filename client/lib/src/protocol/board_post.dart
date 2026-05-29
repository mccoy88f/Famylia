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
import 'board_post_type.dart' as _i2;

/// Post bacheca familiare.
abstract class BoardPost implements _i1.SerializableModel {
  BoardPost._({
    this.id,
    required this.familyId,
    required this.createdBy,
    this.title,
    required this.content,
    _i2.BoardPostType? type,
    bool? isPinned,
    this.expiresAt,
    String? reactionsJson,
    String? commentsJson,
  })  : type = type ?? _i2.BoardPostType.note,
        isPinned = isPinned ?? false,
        reactionsJson = reactionsJson ?? '{}',
        commentsJson = commentsJson ?? '[]';

  factory BoardPost({
    int? id,
    required int familyId,
    required int createdBy,
    String? title,
    required String content,
    _i2.BoardPostType? type,
    bool? isPinned,
    DateTime? expiresAt,
    String? reactionsJson,
    String? commentsJson,
  }) = _BoardPostImpl;

  factory BoardPost.fromJson(Map<String, dynamic> jsonSerialization) {
    return BoardPost(
      id: jsonSerialization['id'] as int?,
      familyId: jsonSerialization['familyId'] as int,
      createdBy: jsonSerialization['createdBy'] as int,
      title: jsonSerialization['title'] as String?,
      content: jsonSerialization['content'] as String,
      type: _i2.BoardPostType.fromJson((jsonSerialization['type'] as String)),
      isPinned: jsonSerialization['isPinned'] as bool,
      expiresAt: jsonSerialization['expiresAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
      reactionsJson: jsonSerialization['reactionsJson'] as String,
      commentsJson: jsonSerialization['commentsJson'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int familyId;

  int createdBy;

  String? title;

  String content;

  _i2.BoardPostType type;

  bool isPinned;

  DateTime? expiresAt;

  String reactionsJson;

  String commentsJson;

  /// Returns a shallow copy of this [BoardPost]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BoardPost copyWith({
    int? id,
    int? familyId,
    int? createdBy,
    String? title,
    String? content,
    _i2.BoardPostType? type,
    bool? isPinned,
    DateTime? expiresAt,
    String? reactionsJson,
    String? commentsJson,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'familyId': familyId,
      'createdBy': createdBy,
      if (title != null) 'title': title,
      'content': content,
      'type': type.toJson(),
      'isPinned': isPinned,
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
      'reactionsJson': reactionsJson,
      'commentsJson': commentsJson,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BoardPostImpl extends BoardPost {
  _BoardPostImpl({
    int? id,
    required int familyId,
    required int createdBy,
    String? title,
    required String content,
    _i2.BoardPostType? type,
    bool? isPinned,
    DateTime? expiresAt,
    String? reactionsJson,
    String? commentsJson,
  }) : super._(
          id: id,
          familyId: familyId,
          createdBy: createdBy,
          title: title,
          content: content,
          type: type,
          isPinned: isPinned,
          expiresAt: expiresAt,
          reactionsJson: reactionsJson,
          commentsJson: commentsJson,
        );

  /// Returns a shallow copy of this [BoardPost]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BoardPost copyWith({
    Object? id = _Undefined,
    int? familyId,
    int? createdBy,
    Object? title = _Undefined,
    String? content,
    _i2.BoardPostType? type,
    bool? isPinned,
    Object? expiresAt = _Undefined,
    String? reactionsJson,
    String? commentsJson,
  }) {
    return BoardPost(
      id: id is int? ? id : this.id,
      familyId: familyId ?? this.familyId,
      createdBy: createdBy ?? this.createdBy,
      title: title is String? ? title : this.title,
      content: content ?? this.content,
      type: type ?? this.type,
      isPinned: isPinned ?? this.isPinned,
      expiresAt: expiresAt is DateTime? ? expiresAt : this.expiresAt,
      reactionsJson: reactionsJson ?? this.reactionsJson,
      commentsJson: commentsJson ?? this.commentsJson,
    );
  }
}
