import 'package:famylia_client/famylia_client.dart';

import 'famylia_services.dart';

class ExpenseRepository {
  ExpenseRepository({FamyliaServices? services})
      : _client = (services ?? FamyliaServices.instance).client;

  final Client _client;

  Future<Expense> create(
    int familyId,
    String title,
    double amount,
    int paidBy, {
    ExpenseCategory? category,
  }) =>
      _client.expense.createExpense(
        familyId,
        title,
        amount,
        paidBy,
        category: category,
      );

  Future<List<Expense>> list(int familyId) =>
      _client.expense.listExpenses(familyId);

  Future<FamilyBalance> balance(int familyId) =>
      _client.expense.getBalance(familyId);

  Future<bool> delete(int id) => _client.expense.deleteExpense(id);

  String errorMessage(Object e) {
    if (e is FamyliaException) return e.message;
    return 'Errore: $e';
  }
}
