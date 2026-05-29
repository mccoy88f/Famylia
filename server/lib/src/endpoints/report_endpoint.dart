import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../util/family_access.dart';

class ReportEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<FamilyReport> getReport(Session session, int familyId) async {
    await requireFamilyMember(session, familyId);

    final todos = await TodoItem.db.find(
      session,
      where: (t) => t.familyId.equals(familyId),
    );
    final openTodos =
        todos.where((t) => t.status != TodoStatus.done).length;
    final completedTodos =
        todos.where((t) => t.status == TodoStatus.done).length;

    final expenses = await Expense.db.find(
      session,
      where: (t) => t.familyId.equals(familyId),
    );
    final totalExpenses =
        expenses.fold<double>(0, (sum, e) => sum + e.amount);

    final now = DateTime.now().toUtc();
    final end = now.add(const Duration(days: 30));
    final deadlines = await Deadline.db.find(
      session,
      where: (t) =>
          t.familyId.equals(familyId) &
          t.status.equals(DeadlineStatus.pending),
    );
    final upcoming = deadlines.where((d) => !d.dueDate.isAfter(end)).length;

    final shoppingLists = await ShoppingList.db.find(
      session,
      where: (t) =>
          t.familyId.equals(familyId) &
          t.status.equals(ShoppingListStatus.active),
    );

    final csv = _buildCsv(
      openTodos: openTodos,
      completedTodos: completedTodos,
      totalExpenses: totalExpenses,
      upcomingDeadlines: upcoming,
      activeShoppingLists: shoppingLists.length,
      expenses: expenses,
    );

    return FamilyReport(
      openTodos: openTodos,
      completedTodos: completedTodos,
      totalExpenses: totalExpenses,
      upcomingDeadlines: upcoming,
      activeShoppingLists: shoppingLists.length,
      csvExport: csv,
    );
  }

  String _buildCsv({
    required int openTodos,
    required int completedTodos,
    required double totalExpenses,
    required int upcomingDeadlines,
    required int activeShoppingLists,
    required List<Expense> expenses,
  }) {
    final buffer = StringBuffer()
      ..writeln('metric,value')
      ..writeln('open_todos,$openTodos')
      ..writeln('completed_todos,$completedTodos')
      ..writeln('total_expenses,${totalExpenses.toStringAsFixed(2)}')
      ..writeln('upcoming_deadlines,$upcomingDeadlines')
      ..writeln('active_shopping_lists,$activeShoppingLists')
      ..writeln('')
      ..writeln('expense_title,amount,date');
    for (final e in expenses) {
      buffer.writeln(
        '"${e.title.replaceAll('"', '""')}",${e.amount.toStringAsFixed(2)},${e.expenseDate.toIso8601String()}',
      );
    }
    return buffer.toString();
  }
}
