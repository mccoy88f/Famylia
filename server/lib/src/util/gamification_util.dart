import 'dart:convert';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';

import '../generated/protocol.dart';

Future<UserPoints> awardPoints(
  Session session,
  int familyId,
  int userId,
  int delta, {
  String? badge,
}) async {
  var row = await UserPoints.db.findFirstRow(
    session,
    where: (t) => t.userId.equals(userId) & t.familyId.equals(familyId),
  );

  if (row == null) {
    row = await UserPoints.db.insertRow(
      session,
      UserPoints(userId: userId, familyId: familyId, points: 0),
    );
  }

  var badges = _parseBadges(row.badgesJson);
  if (badge != null && !badges.contains(badge)) {
    badges.add(badge);
  }

  return UserPoints.db.updateRow(
    session,
    row.copyWith(
      points: row.points + delta,
      badgesJson: jsonEncode(badges),
    ),
  );
}

List<String> _parseBadges(String json) {
  if (json.trim().isEmpty || json == '[]') return [];
  final decoded = jsonDecode(json);
  if (decoded is! List) return [];
  return decoded.map((e) => e.toString()).toList();
}

Future<String> displayNameForUser(Session session, int userId) async {
  final info = await UserInfo.db.findById(session, userId);
  if (info == null) return 'Utente #$userId';
  final name = info.userName?.trim();
  if (name != null && name.isNotEmpty) return name;
  final email = info.email?.trim();
  if (email != null && email.isNotEmpty) return email;
  return 'Utente #$userId';
}
