import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../util/family_access.dart';
import '../util/gamification_util.dart';

class GamificationEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<UserPoints> getMyPoints(Session session, int familyId) async {
    final userId = await requireUserId(session);
    await requireFamilyMember(session, familyId);

    var row = await UserPoints.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId) & t.familyId.equals(familyId),
    );
    row ??= await UserPoints.db.insertRow(
      session,
      UserPoints(userId: userId, familyId: familyId),
    );
    return row;
  }

  Future<Leaderboard> getLeaderboard(Session session, int familyId) async {
    await requireFamilyMember(session, familyId);
    final rows = await UserPoints.db.find(
      session,
      where: (t) => t.familyId.equals(familyId),
      orderBy: (t) => t.points,
      orderDescending: true,
    );

    final entries = <LeaderboardEntry>[];
    for (final row in rows) {
      entries.add(
        LeaderboardEntry(
          userId: row.userId,
          displayName: await displayNameForUser(session, row.userId),
          points: row.points,
          badgesJson: row.badgesJson,
        ),
      );
    }
    return Leaderboard(entries: entries);
  }
}
