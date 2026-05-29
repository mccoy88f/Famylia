import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../util/family_access.dart';
import '../util/gamification_util.dart';

class TodoEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<TodoItem> createTodo(
    Session session,
    int familyId,
    String title, {
    String? description,
    TodoCategory? category,
    TodoPriority? priority,
    int? assignedTo,
    DateTime? dueDate,
  }) async {
    await requireFamilyMemberNotGuest(session, familyId);
    final userId = await requireUserId(session);
    final trimmed = title.trim();
    if (trimmed.isEmpty) {
      throw FamyliaException(message: 'Il titolo è obbligatorio.');
    }

    return TodoItem.db.insertRow(
      session,
      TodoItem(
        familyId: familyId,
        createdBy: userId,
        title: trimmed,
        description: description?.trim(),
        category: category ?? TodoCategory.other,
        priority: priority ?? TodoPriority.medium,
        status: TodoStatus.pending,
        assignedTo: assignedTo,
        dueDate: dueDate,
      ),
    );
  }

  Future<List<TodoItem>> listTodos(
    Session session,
    int familyId, {
    TodoStatus? status,
  }) async {
    await requireFamilyMember(session, familyId);
    return TodoItem.db.find(
      session,
      where: (t) {
        var expr = t.familyId.equals(familyId);
        if (status != null) {
          expr = expr & t.status.equals(status);
        }
        return expr;
      },
      orderBy: (t) => t.dueDate,
      orderDescending: false,
    );
  }

  /// Task di oggi per l'utente corrente (assegnati a me o senza assegnatario).
  Future<List<TodoItem>> myDay(Session session, int familyId) async {
    await requireFamilyMember(session, familyId);
    final userId = await requireUserId(session);
    final now = DateTime.now().toUtc();
    final startOfDay = DateTime.utc(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final all = await TodoItem.db.find(
      session,
      where: (t) =>
          t.familyId.equals(familyId) &
          t.status.notEquals(TodoStatus.done) &
          t.status.notEquals(TodoStatus.cancelled),
    );

    return all.where((item) {
      final mine = item.assignedTo == null || item.assignedTo == userId;
      if (!mine) return false;
      if (item.dueDate == null) return true;
      final due = item.dueDate!.toUtc();
      return !due.isAfter(endOfDay);
    }).toList()
      ..sort((a, b) {
        final ad = a.dueDate;
        final bd = b.dueDate;
        if (ad == null && bd == null) return 0;
        if (ad == null) return 1;
        if (bd == null) return -1;
        return ad.compareTo(bd);
      });
  }

  Future<TodoItem> assignTodo(
    Session session,
    int todoId,
    int? assignedTo,
  ) async {
    final item = await TodoItem.db.findById(session, todoId);
    if (item == null) {
      throw FamyliaException(message: 'Task non trovato.');
    }
    await requireFamilyMemberNotGuest(session, item.familyId);
    return TodoItem.db.updateRow(
      session,
      item.copyWith(assignedTo: assignedTo),
    );
  }

  Future<TodoItem> updateTodo(
    Session session,
    TodoItem item,
  ) async {
    await requireFamilyMemberNotGuest(session, item.familyId);
    final existing = await TodoItem.db.findById(session, item.id!);
    if (existing == null) {
      throw FamyliaException(message: 'Task non trovato.');
    }
    return TodoItem.db.updateRow(session, item);
  }

  Future<TodoItem> completeTodo(Session session, int todoId) async {
    final item = await TodoItem.db.findById(session, todoId);
    if (item == null) {
      throw FamyliaException(message: 'Task non trovato.');
    }
    await requireFamilyMember(session, item.familyId);
    final userId = await requireUserId(session);

    final updated = await TodoItem.db.updateRow(
      session,
      item.copyWith(
        status: TodoStatus.done,
        completedAt: DateTime.now().toUtc(),
        completedBy: userId,
      ),
    );

    await awardPoints(
      session,
      item.familyId,
      userId,
      item.points,
      badge: item.points >= 20 ? 'super_helper' : null,
    );

    return updated;
  }

  Future<bool> deleteTodo(Session session, int todoId) async {
    final item = await TodoItem.db.findById(session, todoId);
    if (item == null) {
      throw FamyliaException(message: 'Task non trovato.');
    }
    await requireFamilyMemberNotGuest(session, item.familyId);
    await TodoItem.db.deleteRow(session, item);
    return true;
  }
}
