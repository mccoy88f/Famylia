import 'dart:convert';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';

import '../generated/protocol.dart';

/// Calcola quote split per una spesa.
List<Map<String, dynamic>> buildEqualSplit(
  double amount,
  List<int> memberUserIds,
) {
  if (memberUserIds.isEmpty) return [];
  final share = amount / memberUserIds.length;
  return memberUserIds
      .map((id) => {'userId': id, 'amount': _round(share)})
      .toList();
}

double _round(double v) => (v * 100).round() / 100;

List<Map<String, dynamic>> parseSplitDetails(String json) {
  if (json.trim().isEmpty || json == '[]') return [];
  final decoded = jsonDecode(json);
  if (decoded is! List) return [];
  return decoded.cast<Map<String, dynamic>>();
}

String encodeSplitDetails(List<Map<String, dynamic>> lines) =>
    jsonEncode(lines);

/// Bilancio netto e suggerimenti transazioni minime.
Future<FamilyBalance> computeFamilyBalance(
  Session session,
  int familyId,
  List<Expense> expenses,
  List<FamilyMember> members,
) async {
  final nets = <int, double>{};
  for (final m in members) {
    nets[m.userId] = 0;
  }

  for (final expense in expenses) {
    if (expense.status == ExpenseStatus.settled) continue;
    final lines = parseSplitDetails(expense.splitDetailsJson);
    nets[expense.paidBy] = (nets[expense.paidBy] ?? 0) + expense.amount;
    for (final line in lines) {
      final uid = line['userId'] as int;
      final amt = (line['amount'] as num).toDouble();
      nets[uid] = (nets[uid] ?? 0) - amt;
    }
  }

  final memberBalances = <MemberBalance>[];
  for (final m in members) {
    final name = await _displayName(session, m.userId);
    memberBalances.add(
      MemberBalance(
        userId: m.userId,
        displayName: name,
        balance: _round(nets[m.userId] ?? 0),
      ),
    );
  }

  final suggestions = _simplifyDebts(memberBalances);
  return FamilyBalance(members: memberBalances, suggestions: suggestions);
}

List<SettlementSuggestion> _simplifyDebts(List<MemberBalance> balances) {
  final creditors = <_Node>[];
  final debtors = <_Node>[];

  for (final b in balances) {
    if (b.balance > 0.01) {
      creditors.add(_Node(b.userId, b.displayName, b.balance));
    } else if (b.balance < -0.01) {
      debtors.add(_Node(b.userId, b.displayName, -b.balance));
    }
  }

  creditors.sort((a, b) => b.amount.compareTo(a.amount));
  debtors.sort((a, b) => b.amount.compareTo(a.amount));

  final suggestions = <SettlementSuggestion>[];
  var i = 0;
  var j = 0;
  while (i < creditors.length && j < debtors.length) {
    final pay = _round(
      creditors[i].amount < debtors[j].amount
          ? creditors[i].amount
          : debtors[j].amount,
    );
    if (pay > 0.01) {
      suggestions.add(
        SettlementSuggestion(
          fromUserId: debtors[j].userId,
          fromDisplayName: debtors[j].displayName,
          toUserId: creditors[i].userId,
          toDisplayName: creditors[i].displayName,
          amount: pay,
        ),
      );
    }
    creditors[i].amount -= pay;
    debtors[j].amount -= pay;
    if (creditors[i].amount < 0.01) i++;
    if (debtors[j].amount < 0.01) j++;
  }
  return suggestions;
}

class _Node {
  _Node(this.userId, this.displayName, this.amount);
  final int userId;
  final String displayName;
  double amount;
}

Future<String> _displayName(Session session, int userId) async {
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
