import 'dart:convert';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';

import '../generated/protocol.dart';

Future<GdprExport> buildGdprExport(Session session, int userId) async {
  final info = await UserInfo.db.findById(session, userId);
  final memberships = await FamilyMember.db.find(
    session,
    where: (t) => t.userId.equals(userId),
  );

  final families = <Map<String, dynamic>>[];
  for (final m in memberships) {
    final family = await Family.db.findById(session, m.familyId);
    if (family == null) continue;
    families.add({
      'familyId': family.id,
      'name': family.name,
      'role': m.role.name,
    });
  }

  final payload = {
    'user': {
      'id': userId,
      'userName': info?.userName,
      'email': info?.email,
      'created': info?.created.toIso8601String(),
    },
    'families': families,
    'todosCreated': (await TodoItem.db.find(
      session,
      where: (t) => t.createdBy.equals(userId),
    )).length,
    'expensesCreated': (await Expense.db.find(
      session,
      where: (t) => t.createdBy.equals(userId),
    )).length,
    'documentsUploaded': (await DocumentRecord.db.find(
      session,
      where: (t) => t.uploadedBy.equals(userId),
    )).length,
  };

  return GdprExport(
    exportedAt: DateTime.now().toUtc(),
    payloadJson: jsonEncode(payload),
  );
}

Future<bool> deleteUserAccount(Session session, int userId) async {
  await FamilyMember.db.deleteWhere(
    session,
    where: (t) => t.userId.equals(userId),
  );
  await LocationSharing.db.deleteWhere(
    session,
    where: (t) => t.userId.equals(userId),
  );
  await LocationHistory.db.deleteWhere(
    session,
    where: (t) => t.userId.equals(userId),
  );
  await UserPoints.db.deleteWhere(
    session,
    where: (t) => t.userId.equals(userId),
  );

  final info = await UserInfo.db.findById(session, userId);
  if (info != null) {
    await UserInfo.db.updateRow(
      session,
      info.copyWith(
        blocked: true,
        userName: 'deleted_user_$userId',
        email: 'deleted_$userId@famylia.local',
        fullName: null,
        imageUrl: null,
      ),
    );
  }

  await AuthKey.db.deleteWhere(
    session,
    where: (t) => t.userId.equals(userId),
  );

  return true;
}
