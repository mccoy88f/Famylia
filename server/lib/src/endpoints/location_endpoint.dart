import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../util/family_access.dart';
import '../util/gamification_util.dart';

class LocationEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<LocationSharing> getStatus(Session session, int familyId) async {
    final userId = await requireUserId(session);
    await requireFamilyMember(session, familyId);
    return _getOrCreateSharing(session, userId, familyId);
  }

  Future<LocationSharing> updateStatus(
    Session session,
    int familyId,
    bool isEnabled, {
    LocationAccuracyLevel? accuracyLevel,
    int? autoDisableAfterHours,
  }) async {
    final userId = await requireUserId(session);
    await requireFamilyMemberNotGuest(session, familyId);
    final row = await _getOrCreateSharing(session, userId, familyId);

    DateTime? enabledAt;
    DateTime? expiresAt;
    if (isEnabled) {
      final hours = autoDisableAfterHours ?? row.autoDisableAfterHours;
      enabledAt = DateTime.now().toUtc();
      expiresAt = enabledAt.add(Duration(hours: hours));
    }

    return LocationSharing.db.updateRow(
      session,
      row.copyWith(
        isEnabled: isEnabled,
        accuracyLevel: accuracyLevel ?? row.accuracyLevel,
        autoDisableAfterHours:
            autoDisableAfterHours ?? row.autoDisableAfterHours,
        enabledAt: isEnabled ? enabledAt : null,
        expiresAt: isEnabled ? expiresAt : null,
      ),
    );
  }

  Future<LocationHistory> checkIn(
    Session session,
    int familyId,
    double latitude,
    double longitude, {
    int? accuracyMeters,
    String? address,
    int? batteryLevel,
  }) async {
    final userId = await requireUserId(session);
    await requireFamilyMember(session, familyId);

    return LocationHistory.db.insertRow(
      session,
      LocationHistory(
        userId: userId,
        familyId: familyId,
        latitude: latitude,
        longitude: longitude,
        accuracyMeters: accuracyMeters,
        address: address,
        batteryLevel: batteryLevel,
        isManualCheckIn: true,
        recordedAt: DateTime.now().toUtc(),
      ),
    );
  }

  Future<List<MemberLocation>> getFamilyLocations(
    Session session,
    int familyId,
  ) async {
    final userId = await requireUserId(session);
    await requireFamilyMember(session, familyId);

    final members = await FamilyMember.db.find(
      session,
      where: (t) => t.familyId.equals(familyId),
    );
    final result = <MemberLocation>[];

    for (final member in members) {
      if (member.userId == userId) continue;
      final sharing = await LocationSharing.db.findFirstRow(
        session,
        where: (t) =>
            t.userId.equals(member.userId) & t.familyId.equals(familyId),
      );
      if (sharing == null || !sharing.isEnabled) continue;
      if (sharing.expiresAt != null &&
          sharing.expiresAt!.isBefore(DateTime.now().toUtc())) {
        continue;
      }

      final last = await LocationHistory.db.findFirstRow(
        session,
        where: (t) =>
            t.userId.equals(member.userId) & t.familyId.equals(familyId),
        orderBy: (t) => t.recordedAt,
        orderDescending: true,
      );
      if (last == null) continue;

      result.add(
        MemberLocation(
          userId: member.userId,
          displayName: await displayNameForUser(session, member.userId),
          latitude: last.latitude,
          longitude: last.longitude,
          address: last.address,
          recordedAt: last.recordedAt,
          isSharingEnabled: true,
        ),
      );
    }
    return result;
  }

  Future<List<SafeZone>> listSafeZones(Session session, int familyId) async {
    await requireFamilyMember(session, familyId);
    return SafeZone.db.find(
      session,
      where: (t) => t.familyId.equals(familyId),
    );
  }

  Future<SafeZone> createSafeZone(
    Session session,
    int familyId,
    String name,
    double latitude,
    double longitude, {
    int? radiusMeters,
  }) async {
    await requireFamilyMemberNotGuest(session, familyId);
    final userId = await requireUserId(session);
    return SafeZone.db.insertRow(
      session,
      SafeZone(
        familyId: familyId,
        createdBy: userId,
        name: name.trim(),
        latitude: latitude,
        longitude: longitude,
        radiusMeters: radiusMeters ?? 100,
      ),
    );
  }

  Future<LocationSharing> _getOrCreateSharing(
    Session session,
    int userId,
    int familyId,
  ) async {
    final existing = await LocationSharing.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId) & t.familyId.equals(familyId),
    );
    if (existing != null) return existing;
    return LocationSharing.db.insertRow(
      session,
      LocationSharing(userId: userId, familyId: familyId),
    );
  }
}
