import 'package:famylia_client/famylia_client.dart';
import 'package:intl/intl.dart';

import '../api/calendar_repository.dart';
import '../api/deadline_repository.dart';
import '../api/expense_repository.dart';
import '../api/shopping_repository.dart';
import '../api/todo_repository.dart';

/// Dati di un elemento già presente, simile a quello in creazione.
class ActivityDuplicateMatch {
  const ActivityDuplicateMatch({
    required this.activityLabel,
    required this.existingTitle,
    required this.details,
  });

  final String activityLabel;
  final String existingTitle;
  final List<MapEntry<String, String>> details;
}

/// Cerca duplicati tra le attività già salvate in famiglia.
class ActivityDuplicateChecker {
  const ActivityDuplicateChecker();

  static final _dateFmt = DateFormat('d MMM yyyy', 'it');
  static final _dateTimeFmt = DateFormat('d MMM yyyy HH:mm', 'it');

  Future<ActivityDuplicateMatch?> find({
    required int familyId,
    required String activityType,
    required String title,
    DateTime? quando,
    double? importo,
    int? assignedTo,
    int? paidBy,
    int? shoppingListId,
  }) async {
    final norm = _normalize(title);
    if (norm.isEmpty) return null;

    return switch (activityType) {
      'task' => _findTask(familyId, norm, title, quando, assignedTo),
      'appuntamento' => _findAppointment(familyId, norm, title, quando),
      'spesa' => _findExpense(familyId, norm, title, importo, paidBy),
      'scadenza' => _findDeadline(familyId, norm, title, quando, importo),
      'acquisto' => _findShoppingItem(norm, title, shoppingListId),
      _ => null,
    };
  }

  Future<ActivityDuplicateMatch?> _findTask(
    int familyId,
    String norm,
    String title,
    DateTime? quando,
    int? assignedTo,
  ) async {
    final todos = await TodoRepository().list(familyId, status: TodoStatus.pending);
    for (final t in todos) {
      if (_normalize(t.title) != norm) continue;
      if (t.assignedTo != assignedTo) continue;
      if (!_sameCalendarDay(t.dueDate, quando)) continue;
      return ActivityDuplicateMatch(
        activityLabel: 'Task',
        existingTitle: t.title,
        details: [
          if (t.dueDate != null) MapEntry('Scadenza', _dateFmt.format(t.dueDate!.toLocal())),
          MapEntry('Priorità', _todoPriorityLabel(t.priority)),
        ],
      );
    }
    return null;
  }

  Future<ActivityDuplicateMatch?> _findAppointment(
    int familyId,
    String norm,
    String title,
    DateTime? quando,
  ) async {
    final start = quando ?? DateTime.now().add(const Duration(hours: 2));
    final from = DateTime(start.year, start.month, start.day).subtract(const Duration(days: 1));
    final to = from.add(const Duration(days: 3));
    final events = await CalendarRepository().list(familyId, from, to);
    for (final e in events) {
      if (_normalize(e.title) != norm) continue;
      if (!_sameMinute(e.startAt.toLocal(), start.toLocal())) continue;
      return ActivityDuplicateMatch(
        activityLabel: 'Appuntamento',
        existingTitle: e.title,
        details: [
          MapEntry('Quando', _dateTimeFmt.format(e.startAt.toLocal())),
          if (e.location != null && e.location!.trim().isNotEmpty)
            MapEntry('Luogo', e.location!.trim()),
        ],
      );
    }
    return null;
  }

  Future<ActivityDuplicateMatch?> _findExpense(
    int familyId,
    String norm,
    String title,
    double? importo,
    int? paidBy,
  ) async {
    if (importo == null || importo <= 0) return null;
    final expenses = await ExpenseRepository().list(familyId);
    for (final e in expenses) {
      if (e.status != ExpenseStatus.active) continue;
      if (_normalize(e.title) != norm) continue;
      if (!_sameAmount(e.amount, importo)) continue;
      if (paidBy != null && e.paidBy != paidBy) continue;
      return ActivityDuplicateMatch(
        activityLabel: 'Spesa',
        existingTitle: e.title,
        details: [
          MapEntry('Importo', '€ ${e.amount.toStringAsFixed(2)}'),
          MapEntry('Data', _dateFmt.format(e.expenseDate.toLocal())),
        ],
      );
    }
    return null;
  }

  Future<ActivityDuplicateMatch?> _findDeadline(
    int familyId,
    String norm,
    String title,
    DateTime? quando,
    double? importo,
  ) async {
    final due = quando ?? DateTime.now().add(const Duration(days: 30));
    final deadlines = await DeadlineRepository().list(familyId, status: DeadlineStatus.pending);
    for (final d in deadlines) {
      if (_normalize(d.title) != norm) continue;
      if (!_sameCalendarDay(d.dueDate.toLocal(), due.toLocal())) continue;
      if (!_sameAmount(d.amount, importo)) continue;
      return ActivityDuplicateMatch(
        activityLabel: 'Scadenza',
        existingTitle: d.title,
        details: [
          MapEntry('Scadenza', _dateFmt.format(d.dueDate.toLocal())),
          if (d.amount != null) MapEntry('Importo', '€ ${d.amount!.toStringAsFixed(2)}'),
        ],
      );
    }
    return null;
  }

  Future<ActivityDuplicateMatch?> _findShoppingItem(
    String norm,
    String title,
    int? shoppingListId,
  ) async {
    if (shoppingListId == null) return null;
    final detail = await ShoppingRepository().getList(shoppingListId);
    for (final item in detail.items) {
      if (item.isChecked) continue;
      if (_normalize(item.name) != norm) continue;
      return ActivityDuplicateMatch(
        activityLabel: 'Articolo lista spesa',
        existingTitle: item.name,
        details: [
          MapEntry('Lista', detail.list.name),
          MapEntry('Quantità', _formatQuantity(item.quantity)),
        ],
      );
    }
    return null;
  }

  static String _formatQuantity(double q) {
    if (q == q.roundToDouble()) return q.toInt().toString();
    return q.toStringAsFixed(1);
  }

  static String _normalize(String s) =>
      s.toLowerCase().trim().replaceAll(RegExp(r'\s+'), ' ');

  static bool _sameCalendarDay(DateTime? a, DateTime? b) {
    if (a == null && b == null) return true;
    if (a == null || b == null) return false;
    final la = a.toLocal();
    final lb = b.toLocal();
    return la.year == lb.year && la.month == lb.month && la.day == lb.day;
  }

  static bool _sameMinute(DateTime a, DateTime b) =>
      a.year == b.year &&
      a.month == b.month &&
      a.day == b.day &&
      a.hour == b.hour &&
      a.minute == b.minute;

  static bool _sameAmount(double? a, double? b) {
    if (a == null && b == null) return true;
    if (a == null || b == null) return false;
    return (a - b).abs() < 0.01;
  }

  static String _todoPriorityLabel(TodoPriority p) => switch (p) {
        TodoPriority.low => 'Bassa',
        TodoPriority.medium => 'Media',
        TodoPriority.high => 'Alta',
        TodoPriority.critical => 'Critica',
      };
}
