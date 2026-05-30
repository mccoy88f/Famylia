import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';

import '../generated/protocol.dart';
import '../util/family_access.dart';
import '../util/invite_code.dart';

/// Gestione famiglie: creazione, join, elenco, membri.
class FamilyEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<Family> createFamily(Session session, String name) async {
    final userId = await requireUserId(session);
    final trimmed = name.trim();
    if (trimmed.isEmpty) {
      throw FamyliaException(message: 'Il nome famiglia è obbligatorio.');
    }

    var inviteCode = generateInviteCode();
    while (await Family.db.findFirstRow(
          session,
          where: (t) => t.inviteCode.equals(inviteCode),
        ) !=
        null) {
      inviteCode = generateInviteCode();
    }

    final family = await Family.db.insertRow(
      session,
      Family(
        name: trimmed,
        inviteCode: inviteCode,
        settings: '{}',
      ),
    );

    await FamilyMember.db.insertRow(
      session,
      FamilyMember(
        userId: userId,
        familyId: family.id!,
        role: FamilyRole.admin,
      ),
    );

    return family;
  }

  Future<FamilyMember> joinFamily(Session session, String inviteCode) async {
    final userId = await requireUserId(session);
    final code = inviteCode.trim().toUpperCase();

    final family = await Family.db.findFirstRow(
      session,
      where: (t) => t.inviteCode.equals(code),
    );
    if (family == null) {
      throw FamyliaException(message: 'Codice invito non valido.');
    }

    final existing = await FamilyMember.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId) & t.familyId.equals(family.id!),
    );
    if (existing != null) {
      return existing;
    }

    return FamilyMember.db.insertRow(
      session,
      FamilyMember(
        userId: userId,
        familyId: family.id!,
        role: FamilyRole.member,
      ),
    );
  }

  Future<List<FamilyWithRole>> listMyFamilies(Session session) async {
    final userId = await requireUserId(session);
    final memberships = await FamilyMember.db.find(
      session,
      where: (t) => t.userId.equals(userId),
    );

    final result = <FamilyWithRole>[];
    for (final membership in memberships) {
      final family = await Family.db.findById(session, membership.familyId);
      if (family != null) {
        result.add(
          FamilyWithRole(
            family: family,
            role: membership.role,
            memberId: membership.id!,
          ),
        );
      }
    }
    return result;
  }

  Future<Family> getFamily(Session session, int familyId) async {
    await requireFamilyMember(session, familyId);
    final family = await Family.db.findById(session, familyId);
    if (family == null) {
      throw FamyliaException(message: 'Famiglia non trovata.');
    }
    return family;
  }

  Future<List<FamilyMemberInfo>> listMembers(
    Session session,
    int familyId,
  ) async {
    await requireFamilyMember(session, familyId);
    final members = await FamilyMember.db.find(
      session,
      where: (t) => t.familyId.equals(familyId),
    );
    final result = <FamilyMemberInfo>[];
    for (final member in members) {
      result.add(
        FamilyMemberInfo(
          userId: member.userId,
          role: member.role,
          displayName: await _displayNameForUser(session, member.userId),
        ),
      );
    }
    return result;
  }

  Future<String> _displayNameForUser(Session session, int userId) async {
    final info = await UserInfo.db.findById(session, userId);
    if (info == null) return 'Utente #$userId';
    final name = info.userName?.trim();
    if (name != null && name.isNotEmpty) return name;
    final full = info.fullName?.trim();
    if (full != null && full.isNotEmpty) return full;
    final email = info.email?.trim();
    if (email != null && email.isNotEmpty) return email;
    return 'Utente #$userId';
  }

  Future<Family> updateAccentColor(
    Session session,
    int familyId,
    String accentColor,
  ) async {
    await requireFamilyAdmin(session, familyId);
    final hex = _normalizeAccentHex(accentColor);
    final family = await Family.db.findById(session, familyId);
    if (family == null) {
      throw FamyliaException(message: 'Famiglia non trovata.');
    }
    return Family.db.updateRow(
      session,
      family.copyWith(accentColor: hex),
    );
  }

  String _normalizeAccentHex(String raw) {
    var hex = raw.trim().toUpperCase();
    if (!hex.startsWith('#')) hex = '#$hex';
    if (!RegExp(r'^#[0-9A-F]{6}$').hasMatch(hex)) {
      throw FamyliaException(
        message: 'Colore non valido. Usa il formato #RRGGBB.',
      );
    }
    return hex;
  }

  Future<bool> leaveFamily(Session session, int familyId) async {
    final userId = await requireUserId(session);
    final membership = await FamilyMember.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId) & t.familyId.equals(familyId),
    );
    if (membership == null) {
      throw FamyliaException(message: 'Non sei membro di questa famiglia.');
    }
    await FamilyMember.db.deleteRow(session, membership);
    return true;
  }
}
