import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../util/family_access.dart';

class DeadlineEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<Deadline> createDeadline(
    Session session,
    int familyId,
    String title,
    DateTime dueDate, {
    String? description,
    DeadlineCategory? category,
    double? amount,
    DeadlinePriority? priority,
    int? assignedTo,
    bool? isPrivate,
    bool? isRecurring,
    String? recurrenceRule,
  }) async {
    await requireFamilyMemberNotGuest(session, familyId);
    final userId = await requireUserId(session);
    final trimmed = title.trim();
    if (trimmed.isEmpty) {
      throw FamyliaException(message: 'Il titolo è obbligatorio.');
    }

    final status = _statusForDueDate(dueDate, DeadlineStatus.pending);
    return Deadline.db.insertRow(
      session,
      Deadline(
        familyId: familyId,
        createdBy: userId,
        title: trimmed,
        description: description?.trim(),
        category: category ?? DeadlineCategory.other,
        amount: amount,
        dueDate: dueDate,
        isRecurring: isRecurring ?? false,
        recurrenceRule: recurrenceRule,
        status: status,
        priority: priority ?? DeadlinePriority.medium,
        assignedTo: assignedTo,
        isPrivate: isPrivate ?? false,
      ),
    );
  }

  Future<List<Deadline>> listDeadlines(
    Session session,
    int familyId, {
    DeadlineStatus? status,
    DeadlineCategory? category,
  }) async {
    final userId = await requireUserId(session);
    await requireFamilyMember(session, familyId);
    final rows = await Deadline.db.find(
      session,
      where: (t) {
        var expr = t.familyId.equals(familyId);
        if (status != null) {
          expr = expr & t.status.equals(status);
        }
        if (category != null) {
          expr = expr & t.category.equals(category);
        }
        return expr;
      },
      orderBy: (t) => t.dueDate,
    );
    await _refreshOverdue(session, rows);
    return rows.where((d) => !d.isPrivate || d.createdBy == userId).toList();
  }

  Future<List<Deadline>> upcoming(
    Session session,
    int familyId, {
    int days = 30,
  }) async {
    final userId = await requireUserId(session);
    await requireFamilyMember(session, familyId);
    final now = DateTime.now().toUtc();
    final end = now.add(Duration(days: days));
    final rows = await Deadline.db.find(
      session,
      where: (t) =>
          t.familyId.equals(familyId) &
          t.status.equals(DeadlineStatus.pending),
      orderBy: (t) => t.dueDate,
    );
    return rows
        .where((d) {
          if (d.isPrivate && d.createdBy != userId) return false;
          return !d.dueDate.isAfter(end);
        })
        .toList();
  }

  Future<Deadline> completeDeadline(Session session, int deadlineId) async {
    final row = await _requireDeadline(session, deadlineId);
    await requireFamilyMember(session, row.familyId);
    final userId = await requireUserId(session);
    return Deadline.db.updateRow(
      session,
      row.copyWith(
        status: DeadlineStatus.paid,
        completedAt: DateTime.now().toUtc(),
        completedBy: userId,
      ),
    );
  }

  Future<Deadline> updateDeadline(Session session, Deadline deadline) async {
    await requireFamilyMemberNotGuest(session, deadline.familyId);
    final existing = await Deadline.db.findById(session, deadline.id!);
    if (existing == null) {
      throw FamyliaException(message: 'Scadenza non trovata.');
    }
    var updated = deadline;
    if (deadline.status == DeadlineStatus.pending) {
      updated = deadline.copyWith(
        status: _statusForDueDate(deadline.dueDate, deadline.status),
      );
    }
    return Deadline.db.updateRow(session, updated);
  }

  Future<bool> deleteDeadline(Session session, int deadlineId) async {
    final row = await _requireDeadline(session, deadlineId);
    await requireFamilyMemberNotGuest(session, row.familyId);
    await Deadline.db.deleteRow(session, row);
    return true;
  }

  Future<Deadline> _requireDeadline(Session session, int id) async {
    final row = await Deadline.db.findById(session, id);
    if (row == null) {
      throw FamyliaException(message: 'Scadenza non trovata.');
    }
    return row;
  }

  DeadlineStatus _statusForDueDate(DateTime due, DeadlineStatus current) {
    if (current != DeadlineStatus.pending) return current;
    final today = DateTime.now().toUtc();
    final dueUtc = DateTime.utc(due.year, due.month, due.day);
    final todayUtc = DateTime.utc(today.year, today.month, today.day);
    if (dueUtc.isBefore(todayUtc)) return DeadlineStatus.overdue;
    return DeadlineStatus.pending;
  }

  Future<void> _refreshOverdue(Session session, List<Deadline> rows) async {
    final today = DateTime.now().toUtc();
    final todayUtc =
        DateTime.utc(today.year, today.month, today.day);
    for (final row in rows) {
      if (row.status != DeadlineStatus.pending || row.id == null) continue;
      final dueUtc = DateTime.utc(
        row.dueDate.year,
        row.dueDate.month,
        row.dueDate.day,
      );
      if (dueUtc.isBefore(todayUtc)) {
        await Deadline.db.updateRow(
          session,
          row.copyWith(status: DeadlineStatus.overdue),
        );
        row.status = DeadlineStatus.overdue;
      }
    }
  }
}
