import 'package:famylia_client/famylia_client.dart';

import 'famylia_services.dart';

class GamificationRepository {
  GamificationRepository({FamyliaServices? services})
      : _client = (services ?? FamyliaServices.instance).client;

  final Client _client;

  Future<UserPoints> myPoints(int familyId) =>
      _client.gamification.getMyPoints(familyId);

  Future<Leaderboard> leaderboard(int familyId) =>
      _client.gamification.getLeaderboard(familyId);

  String errorMessage(Object e) {
    if (e is FamyliaException) return e.message;
    return 'Errore: $e';
  }
}
