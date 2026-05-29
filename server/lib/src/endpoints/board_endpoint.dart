import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../util/family_access.dart';

class BoardEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  static String _channel(int familyId) => 'famylia-board-$familyId';

  void _notify(Session session, int familyId) {
    session.messages.postMessage(
      _channel(familyId),
      BoardChanged(familyId: familyId),
    );
  }

  Stream<List<BoardPostWithPoll>> watchBoard(
    Session session,
    int familyId,
  ) async* {
    await requireFamilyMember(session, familyId);
    final updates =
        session.messages.createStream<BoardChanged>(_channel(familyId));
    yield await listPosts(session, familyId);
    await for (final _ in updates) {
      yield await listPosts(session, familyId);
    }
  }

  Future<List<BoardPostWithPoll>> listPosts(
    Session session,
    int familyId,
  ) async {
    await requireFamilyMember(session, familyId);
    final posts = await BoardPost.db.find(
      session,
      where: (t) => t.familyId.equals(familyId),
      orderBy: (t) => t.id,
      orderDescending: true,
    );
  posts.sort((a, b) {
      if (a.isPinned != b.isPinned) return a.isPinned ? -1 : 1;
      return (b.id ?? 0).compareTo(a.id ?? 0);
    });

    final result = <BoardPostWithPoll>[];
    for (final post in posts) {
      List<PollOption> options = [];
      if (post.type == BoardPostType.poll && post.id != null) {
        options = await PollOption.db.find(
          session,
          where: (t) => t.boardPostId.equals(post.id!),
        );
      }
      result.add(BoardPostWithPoll(post: post, options: options));
    }
    return result;
  }

  Future<BoardPostWithPoll> createPost(
    Session session,
    int familyId,
    String content, {
    String? title,
    BoardPostType? type,
    List<String>? pollOptions,
    bool? isPinned,
  }) async {
    await requireFamilyMemberNotGuest(session, familyId);
    final userId = await requireUserId(session);
    final trimmed = content.trim();
    if (trimmed.isEmpty) {
      throw FamyliaException(message: 'Il contenuto è obbligatorio.');
    }

    final postType = type ?? BoardPostType.note;
    final post = await BoardPost.db.insertRow(
      session,
      BoardPost(
        familyId: familyId,
        createdBy: userId,
        title: title?.trim(),
        content: trimmed,
        type: postType,
        isPinned: isPinned ?? false,
      ),
    );

    final options = <PollOption>[];
    if (postType == BoardPostType.poll && post.id != null) {
      for (final text in pollOptions ?? []) {
        final opt = await PollOption.db.insertRow(
          session,
          PollOption(boardPostId: post.id!, text: text.trim()),
        );
        options.add(opt);
      }
    }

    _notify(session, familyId);
    return BoardPostWithPoll(post: post, options: options);
  }

  Future<BoardPostWithPoll> votePoll(
    Session session,
    int optionId,
  ) async {
    final option = await PollOption.db.findById(session, optionId);
    if (option == null) {
      throw FamyliaException(message: 'Opzione non trovata.');
    }
    final post = await BoardPost.db.findById(session, option.boardPostId);
    if (post == null) {
      throw FamyliaException(message: 'Post non trovato.');
    }
    await requireFamilyMember(session, post.familyId);
    final userId = await requireUserId(session);

    final votes = _parseIntList(option.votesJson);
    if (!votes.contains(userId)) votes.add(userId);
    await PollOption.db.updateRow(
      session,
      option.copyWith(votesJson: jsonEncode(votes)),
    );

    _notify(session, post.familyId);
    final options = await PollOption.db.find(
      session,
      where: (t) => t.boardPostId.equals(post.id!),
    );
    return BoardPostWithPoll(post: post, options: options);
  }

  Future<bool> deletePost(Session session, int postId) async {
    final post = await BoardPost.db.findById(session, postId);
    if (post == null) {
      throw FamyliaException(message: 'Post non trovato.');
    }
    await requireFamilyMemberNotGuest(session, post.familyId);
    final options = await PollOption.db.find(
      session,
      where: (t) => t.boardPostId.equals(postId),
    );
    for (final o in options) {
      await PollOption.db.deleteRow(session, o);
    }
    await BoardPost.db.deleteRow(session, post);
    _notify(session, post.familyId);
    return true;
  }

  List<int> _parseIntList(String json) {
    if (json.trim().isEmpty || json == '[]') return [];
    final decoded = jsonDecode(json);
    if (decoded is! List) return [];
    return decoded.map((e) => (e as num).toInt()).toList();
  }
}
