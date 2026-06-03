import 'package:famylia_client/famylia_client.dart';

import 'famylia_services.dart';

class GoalRepository {
  GoalRepository({FamyliaServices? services})
      : _client = (services ?? FamyliaServices.instance).client;

  final Client _client;

  Future<FamilyGoal> createGoal({
    required int familyId,
    required int targetUserId,
    required String title,
    required int targetPoints,
    required double rewardAmount,
    String? description,
    DateTime? deadline,
  }) =>
      _client.goal.createGoal(
        familyId,
        targetUserId,
        title,
        targetPoints,
        rewardAmount,
        description: description,
        deadline: deadline,
      );

  Future<List<FamilyGoal>> listGoals(int familyId) =>
      _client.goal.listGoals(familyId);

  Future<FamilyGoal> cancelGoal(int goalId) =>
      _client.goal.cancelGoal(goalId);

  Future<FamilyGoal> markPaid(int goalId) =>
      _client.goal.markPaid(goalId);

  String errorMessage(Object e) {
    if (e is FamyliaException) return e.message;
    return 'Errore: $e';
  }
}
