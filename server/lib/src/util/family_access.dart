import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

Future<int> requireUserId(Session session) async {
  final auth = await session.authenticated;
  if (auth == null) {
    throw FamyliaException(message: 'Autenticazione richiesta.');
  }
  return auth.userId;
}

Future<FamilyMember> requireFamilyMember(Session session, int familyId) async {
  final userId = await requireUserId(session);
  final membership = await FamilyMember.db.findFirstRow(
    session,
    where: (t) => t.userId.equals(userId) & t.familyId.equals(familyId),
  );
  if (membership == null) {
    throw FamyliaException(message: 'Accesso negato a questa famiglia.');
  }
  return membership;
}

Future<void> requireFamilyMemberNotGuest(Session session, int familyId) async {
  final member = await requireFamilyMember(session, familyId);
  if (member.role == FamilyRole.guest) {
    throw FamyliaException(message: 'I guest possono solo visualizzare.');
  }
}
