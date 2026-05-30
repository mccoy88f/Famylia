import 'package:famylia_client/famylia_client.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../core/api/expense_repository.dart';
import '../../core/api/family_repository.dart';
import '../../core/extensions/context_extensions.dart';
import '../../core/router/app_router.dart';
import '../../core/session/app_state.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final _repo = ExpenseRepository();
  final _families = FamilyRepository();
  List<Expense> _items = [];
  bool _loading = true;
  final _dateFmt = DateFormat('d MMM');

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final familyId = context.activeFamilyId;
    if (familyId == null) return;
    setState(() => _loading = true);
    try {
      final items = await _repo.list(familyId);
      if (mounted) setState(() => _items = items);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_repo.errorMessage(e))),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _add() async {
    final familyId = context.activeFamilyId;
    if (familyId == null) return;
    final me = context.read<AppState>().signedInUser?.id;
    if (me == null) return;

    final titleCtrl = TextEditingController();
    final amountCtrl = TextEditingController();
    var paidBy = me;

    final members = await _families.listMembers(familyId);
    if (!mounted) return;

    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDlg) => AlertDialog(
          title: const Text('Nuova spesa'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleCtrl,
                decoration: const InputDecoration(labelText: 'Titolo'),
              ),
              TextField(
                controller: amountCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Importo (€)'),
              ),
              DropdownButtonFormField<int>(
                value: paidBy,
                decoration: const InputDecoration(labelText: 'Pagato da'),
                items: [
                  for (final m in members)
                    DropdownMenuItem(
                      value: m.userId,
                      child: Text(m.displayName),
                    ),
                ],
                onChanged: (v) => setDlg(() => paidBy = v ?? me),
              ),
            ],
          ),
          actions: [
            ShadButton.ghost(onPressed: () => Navigator.pop(ctx, false), child: const Text('Annulla')),
            ShadButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Salva')),
          ],
        ),
      ),
    );
    if (ok != true || titleCtrl.text.trim().isEmpty) return;
    final amount = double.tryParse(amountCtrl.text.replaceAll(',', '.'));
    if (amount == null || amount <= 0) return;
    try {
      await _repo.create(familyId, titleCtrl.text, amount, paidBy);
      await _load();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_repo.errorMessage(e))),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spese'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_balance_wallet_outlined),
            onPressed: () => context.push(AppRoutes.expenseBalance),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _add,
        child: const Icon(Icons.add),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _load,
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (_, i) {
                  final e = _items[i];
                  return ListTile(
                    leading: const Icon(Icons.payments_outlined),
                    title: Text(e.title),
                    subtitle: Text(_dateFmt.format(e.expenseDate)),
                    trailing: Text(
                      '€${e.amount.toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
