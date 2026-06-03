import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../util/family_access.dart';
import '../util/gamification_util.dart';

class GoalEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<FamilyGoal> createGoal(
    Session session,
    int familyId,
    int targetUserId,
    String title,
    int targetPoints,
    double rewardAmount, {
    String? description,
    DateTime? deadline,
  }) async {
    final createdBy = await requireUserId(session);
    await requireFamilyMember(session, familyId);

    // Verify target user is in the family.
    final members = await FamilyMember.db.find(
      session,
      where: (t) => t.familyId.equals(familyId) & t.userId.equals(targetUserId),
    );
    if (members.isEmpty) {
      throw Exception('Target user is not a member of this family');
    }

    return FamilyGoal.db.insertRow(
      session,
      FamilyGoal(
        familyId: familyId,
        createdBy: createdBy,
        targetUserId: targetUserId,
        title: title,
        description: description,
        targetPoints: targetPoints,
        rewardAmount: rewardAmount,
        deadline: deadline,
      ),
    );
  }

  Future<List<FamilyGoal>> listGoals(Session session, int familyId) async {
    await requireFamilyMember(session, familyId);
    return FamilyGoal.db.find(
      session,
      where: (t) => t.familyId.equals(familyId),
      orderBy: (t) => t.status,
      orderDescending: false,
    );
  }

  Future<FamilyGoal> cancelGoal(Session session, int goalId) async {
    final userId = await requireUserId(session);
    final goal = await FamilyGoal.db.findById(session, goalId);
    if (goal == null) throw Exception('Goal not found');
    await requireFamilyMember(session, goal.familyId);

    // Only creator or target user can cancel.
    if (goal.createdBy != userId && goal.targetUserId != userId) {
      throw Exception('Not authorized to cancel this goal');
    }
    if (goal.status != FamilyGoalStatus.active) {
      throw Exception('Only active goals can be cancelled');
    }

    return FamilyGoal.db.updateRow(
      session,
      goal.copyWith(status: FamilyGoalStatus.cancelled),
    );
  }

  Future<FamilyGoal> markPaid(Session session, int goalId) async {
    final userId = await requireUserId(session);
    final goal = await FamilyGoal.db.findById(session, goalId);
    if (goal == null) throw Exception('Goal not found');
    await requireFamilyMember(session, goal.familyId);

    if (goal.status != FamilyGoalStatus.completed) {
      throw Exception('Goal is not completed yet');
    }
    if (goal.paidAt != null) throw Exception('Goal already marked as paid');

    return FamilyGoal.db.updateRow(
      session,
      goal.copyWith(
        paidAt: DateTime.now().toUtc(),
        paidBy: userId,
      ),
    );
  }
}
