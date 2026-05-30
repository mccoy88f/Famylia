import 'package:famylia_client/famylia_client.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../core/api/expense_repository.dart';
import '../../core/extensions/context_extensions.dart';

class ExpenseBalanceScreen extends StatefulWidget {
  const ExpenseBalanceScreen({super.key});

  @override
  State<ExpenseBalanceScreen> createState() => _ExpenseBalanceScreenState();
}

class _ExpenseBalanceScreenState extends State<ExpenseBalanceScreen> {
  final _repo = ExpenseRepository();
  FamilyBalance? _balance;
  bool _loading = true;

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
      final b = await _repo.balance(familyId);
      if (mounted) setState(() => _balance = b);
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

  @override
  Widget build(BuildContext context) {
    final shadTheme = ShadTheme.of(context);
    return Scaffold(
      backgroundColor: shadTheme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: shadTheme.colorScheme.background,
        surfaceTintColor: Colors.transparent,
        title: const Text('Bilancio spese'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _load,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text(
                    'Saldi membri',
                    style: shadTheme.textTheme.h4,
                  ),
                  const SizedBox(height: 8),
                  for (final m in _balance?.members ?? [])
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: ShadCard(
                        child: ListTile(
                          title: Text(m.displayName),
                          trailing: Text(
                            '€${m.balance.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: m.balance >= 0
                                  ? Colors.green
                                  : shadTheme.colorScheme.destructive,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 24),
                  Text(
                    'Pagamenti suggeriti',
                    style: shadTheme.textTheme.h4,
                  ),
                  const SizedBox(height: 8),
                  if ((_balance?.suggestions ?? []).isEmpty)
                    Text('Tutto in pari', style: shadTheme.textTheme.muted)
                  else
                    for (final s in _balance!.suggestions)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: ShadCard(
                          child: ListTile(
                            leading: const Icon(Icons.swap_horiz),
                            title: Text(
                              '${s.fromDisplayName} → ${s.toDisplayName}',
                            ),
                            trailing: Text('€${s.amount.toStringAsFixed(2)}'),
                          ),
                        ),
                      ),
                ],
              ),
            ),
    );
  }
}
