import 'package:famylia_client/famylia_client.dart';

import 'famylia_services.dart';

class BoardRepository {
  BoardRepository({FamyliaServices? services})
      : _services = services ?? FamyliaServices.instance;

  final FamyliaServices _services;

  Client get _client => _services.client;

  Future<List<BoardPostWithPoll>> list(int familyId) =>
      _client.board.listPosts(familyId);

  Stream<List<BoardPostWithPoll>> watch(int familyId) {
    _services.ensureStreaming();
    return _client.board.watchBoard(familyId);
  }

  Future<BoardPostWithPoll> createNote(int familyId, String content) =>
      _client.board.createPost(familyId, content);

  Future<BoardPostWithPoll> createPoll(
    int familyId,
    String content,
    List<String> options,
  ) =>
      _client.board.createPost(
        familyId,
        content,
        type: BoardPostType.poll,
        pollOptions: options,
      );

  Future<BoardPostWithPoll> vote(int optionId) =>
      _client.board.votePoll(optionId);

  Future<bool> delete(int postId) => _client.board.deletePost(postId);

  String errorMessage(Object e) {
    if (e is FamyliaException) return e.message;
    return 'Errore: $e';
  }
}
