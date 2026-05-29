import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../util/family_access.dart';
import '../util/gamification_util.dart';
import '../util/gdpr_util.dart';

class GdprEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<GdprExport> exportMyData(Session session) async {
    final userId = await requireUserId(session);
    return buildGdprExport(session, userId);
  }

  Future<bool> deleteMyAccount(Session session) async {
    final userId = await requireUserId(session);
    return deleteUserAccount(session, userId);
  }

  Future<PrivacyDashboard> getPrivacyDashboard(
    Session session,
    int familyId,
  ) async {
    final userId = await requireUserId(session);
    await requireFamilyMember(session, familyId);

    final sharing = await LocationSharing.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId) & t.familyId.equals(familyId),
    );

    final members = await FamilyMember.db.find(
      session,
      where: (t) => t.familyId.equals(familyId),
    );
    final viewers = <String>[];
    if (sharing != null && sharing.isEnabled) {
      final allowed = _parseIntList(sharing.shareWithUserIdsJson);
      final targets = allowed.isEmpty
          ? members.map((m) => m.userId).where((id) => id != userId)
          : allowed;
      for (final id in targets) {
        viewers.add(await displayNameForUser(session, id));
      }
    }

    return PrivacyDashboard(
      locationEnabled: sharing?.isEnabled ?? false,
      locationExpiresAt: sharing?.expiresAt,
      sharedWithCount: viewers.length,
      viewersJson: viewers.join(', '),
      canExportData: true,
    );
  }

  List<int> _parseIntList(String json) {
    if (json.trim().isEmpty || json == '[]') return [];
    try {
      final decoded = jsonDecode(json);
      if (decoded is! List) return [];
      return decoded.map((e) => (e as num).toInt()).toList();
    } catch (_) {
      return [];
    }
  }
}
