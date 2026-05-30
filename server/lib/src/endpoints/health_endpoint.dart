import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../util/family_access.dart';

/// Modulo salute: visite mediche, diete e attività sportive.
class HealthEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<HealthEntry> createEntry(
    Session session,
    int familyId,
    HealthEntryType type,
    String title, {
    String? description,
    HealthEntryStatus? status,
    int? assignedTo,
    DateTime? scheduledAt,
    DateTime? endAt,
    String? providerName,
    String? location,
    String? dietGoal,
    int? caloriesTarget,
    String? sportType,
    int? durationMinutes,
    SportIntensity? intensity,
    bool? isPrivate,
  }) async {
    await requireFamilyMemberNotGuest(session, familyId);
    final userId = await requireUserId(session);
    final trimmed = title.trim();
    if (trimmed.isEmpty) {
      throw FamyliaException(message: 'Il titolo è obbligatorio.');
    }

    final defaultStatus = type == HealthEntryType.diet
        ? HealthEntryStatus.active
        : HealthEntryStatus.planned;

    return HealthEntry.db.insertRow(
      session,
      HealthEntry(
        familyId: familyId,
        createdBy: userId,
        type: type,
        title: trimmed,
        description: description?.trim(),
        status: status ?? defaultStatus,
        assignedTo: assignedTo,
        scheduledAt: scheduledAt,
        endAt: endAt,
        providerName: providerName?.trim(),
        location: location?.trim(),
        dietGoal: dietGoal?.trim(),
        caloriesTarget: caloriesTarget,
        sportType: sportType?.trim(),
        durationMinutes: durationMinutes,
        intensity: intensity,
        isPrivate: isPrivate ?? false,
      ),
    );
  }

  Future<List<HealthEntry>> listEntries(
    Session session,
    int familyId, {
    HealthEntryType? type,
    HealthEntryStatus? status,
  }) async {
    final userId = await requireUserId(session);
    await requireFamilyMember(session, familyId);
    final rows = await HealthEntry.db.find(
      session,
      where: (t) {
        var expr = t.familyId.equals(familyId);
        if (type != null) {
          expr = expr & t.type.equals(type);
        }
        if (status != null) {
          expr = expr & t.status.equals(status);
        }
        return expr;
      },
      orderBy: (t) => t.scheduledAt,
      orderDescending: true,
    );
    return rows.where((e) => !e.isPrivate || e.createdBy == userId).toList();
  }

  Future<List<HealthEntry>> upcoming(
    Session session,
    int familyId, {
    int days = 30,
    HealthEntryType? type,
  }) async {
    final userId = await requireUserId(session);
    await requireFamilyMember(session, familyId);
    final now = DateTime.now().toUtc();
    final until = now.add(Duration(days: days));
    final rows = await HealthEntry.db.find(
      session,
      where: (t) => t.familyId.equals(familyId),
      orderBy: (t) => t.scheduledAt,
    );

    return rows.where((e) {
      if (e.isPrivate && e.createdBy != userId) return false;
      if (type != null && e.type != type) return false;
      if (e.status == HealthEntryStatus.completed ||
          e.status == HealthEntryStatus.cancelled) {
        return false;
      }
      if (e.type == HealthEntryType.diet) return false;
      final at = e.scheduledAt;
      if (at == null) return false;
      return !at.isBefore(now) && !at.isAfter(until);
    }).toList();
  }

  Future<HealthEntry> updateEntry(Session session, HealthEntry entry) async {
    await requireFamilyMemberNotGuest(session, entry.familyId);
    final existing = await HealthEntry.db.findById(session, entry.id!);
    if (existing == null) {
      throw FamyliaException(message: 'Voce salute non trovata.');
    }
    return HealthEntry.db.updateRow(session, entry);
  }

  Future<HealthEntry> completeEntry(Session session, int entryId) async {
    final row = await HealthEntry.db.findById(session, entryId);
    if (row == null) {
      throw FamyliaException(message: 'Voce salute non trovata.');
    }
    await requireFamilyMemberNotGuest(session, row.familyId);
    return HealthEntry.db.updateRow(
      session,
      row.copyWith(
        status: HealthEntryStatus.completed,
        completedAt: DateTime.now().toUtc(),
      ),
    );
  }

  Future<bool> deleteEntry(Session session, int entryId) async {
    final row = await HealthEntry.db.findById(session, entryId);
    if (row == null) {
      throw FamyliaException(message: 'Voce salute non trovata.');
    }
    await requireFamilyMemberNotGuest(session, row.familyId);
    await HealthEntry.db.deleteRow(session, row);
    return true;
  }
}
