import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../util/expense_balance.dart';
import '../util/family_access.dart';

class ExpenseEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<Expense> createExpense(
    Session session,
    int familyId,
    String title,
    double amount,
    int paidBy, {
    String? description,
    ExpenseCategory? category,
    ExpenseSplitType? splitType,
    String? splitDetailsJson,
    DateTime? expenseDate,
  }) async {
    await requireFamilyMemberNotGuest(session, familyId);
    final userId = await requireUserId(session);
    final trimmed = title.trim();
    if (trimmed.isEmpty) {
      throw FamyliaException(message: 'Il titolo è obbligatorio.');
    }
    if (amount <= 0) {
      throw FamyliaException(message: 'Importo non valido.');
    }

    final members = await FamilyMember.db.find(
      session,
      where: (t) => t.familyId.equals(familyId),
    );
    final memberIds = members.map((m) => m.userId).toList();
    final type = splitType ?? ExpenseSplitType.equal;
    var splitJson = splitDetailsJson ?? '[]';
    if (type == ExpenseSplitType.equal) {
      splitJson = encodeSplitDetails(buildEqualSplit(amount, memberIds));
    }

    return Expense.db.insertRow(
      session,
      Expense(
        familyId: familyId,
        createdBy: userId,
        title: trimmed,
        description: description?.trim(),
        amount: amount,
        category: category ?? ExpenseCategory.other,
        paidBy: paidBy,
        splitType: type,
        splitDetailsJson: splitJson,
        expenseDate: expenseDate ?? DateTime.now().toUtc(),
        status: ExpenseStatus.active,
      ),
    );
  }

  Future<List<Expense>> listExpenses(
    Session session,
    int familyId, {
    DateTime? from,
    DateTime? to,
  }) async {
    await requireFamilyMember(session, familyId);
    final rows = await Expense.db.find(
      session,
      where: (t) => t.familyId.equals(familyId),
      orderBy: (t) => t.expenseDate,
      orderDescending: true,
    );
    if (from == null && to == null) return rows;
    return rows.where((e) {
      final d = e.expenseDate;
      if (from != null && d.isBefore(from)) return false;
      if (to != null && d.isAfter(to)) return false;
      return true;
    }).toList();
  }

  Future<FamilyBalance> getBalance(Session session, int familyId) async {
    await requireFamilyMember(session, familyId);
    final members = await FamilyMember.db.find(
      session,
      where: (t) => t.familyId.equals(familyId),
    );
    final expenses = await Expense.db.find(
      session,
      where: (t) =>
          t.familyId.equals(familyId) &
          t.status.equals(ExpenseStatus.active),
    );
    return computeFamilyBalance(session, familyId, expenses, members);
  }

  Future<Settlement> recordSettlement(
    Session session,
    int familyId,
    int fromUserId,
    int toUserId,
    double amount,
  ) async {
    await requireFamilyMemberNotGuest(session, familyId);
    if (amount <= 0) {
      throw FamyliaException(message: 'Importo non valido.');
    }
    return Settlement.db.insertRow(
      session,
      Settlement(
        familyId: familyId,
        fromUserId: fromUserId,
        toUserId: toUserId,
        amount: amount,
        status: SettlementStatus.paid,
        settledAt: DateTime.now().toUtc(),
      ),
    );
  }

  Future<List<Settlement>> listSettlements(Session session, int familyId) async {
    await requireFamilyMember(session, familyId);
    return Settlement.db.find(
      session,
      where: (t) => t.familyId.equals(familyId),
      orderBy: (t) => t.id,
      orderDescending: true,
    );
  }

  Future<bool> deleteExpense(Session session, int expenseId) async {
    final row = await Expense.db.findById(session, expenseId);
    if (row == null) {
      throw FamyliaException(message: 'Spesa non trovata.');
    }
    await requireFamilyMemberNotGuest(session, row.familyId);
    await Expense.db.deleteRow(session, row);
    return true;
  }
}
