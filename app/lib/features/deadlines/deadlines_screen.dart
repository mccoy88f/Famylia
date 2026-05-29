import 'package:famylia_client/famylia_client.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/api/deadline_repository.dart';
import '../../core/extensions/context_extensions.dart';

class DeadlinesScreen extends StatefulWidget {
  const DeadlinesScreen({super.key});

  @override
  State<DeadlinesScreen> createState() => _DeadlinesScreenState();
}

class _DeadlinesScreenState extends State<DeadlinesScreen> {
  final _repo = DeadlineRepository();
  List<Deadline> _items = [];
  bool _loading = true;
  final _dateFmt = DateFormat('d MMM yyyy');

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
    final titleCtrl = TextEditingController();
    final amountCtrl = TextEditingController();
    var due = DateTime.now().add(const Duration(days: 7));

    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Nuova scadenza'),
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
            ListTile(
              title: Text('Scadenza: ${_dateFmt.format(due)}'),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final picked = await showDatePicker(
                  context: ctx,
                  initialDate: due,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
                );
                if (picked != null) due = picked;
              },
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Annulla')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Salva')),
        ],
      ),
    );
    if (ok != true || titleCtrl.text.trim().isEmpty) return;
    try {
      await _repo.create(
        familyId,
        titleCtrl.text,
        due,
        amount: double.tryParse(amountCtrl.text.replaceAll(',', '.')),
        category: DeadlineCategory.bill,
      );
      await _load();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_repo.errorMessage(e))),
        );
      }
    }
  }

  Color _statusColor(DeadlineStatus s, ThemeData theme) {
    return switch (s) {
      DeadlineStatus.overdue => theme.colorScheme.error,
      DeadlineStatus.paid => Colors.green,
      DeadlineStatus.cancelled => theme.disabledColor,
      _ => theme.colorScheme.primary,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scadenze')),
      floatingActionButton: FloatingActionButton(
        onPressed: _add,
        child: const Icon(Icons.add),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _load,
              child: _items.isEmpty
                  ? ListView(
                      children: const [
                        SizedBox(height: 120),
                        Center(child: Text('Nessuna scadenza')),
                      ],
                    )
                  : ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (_, i) {
                        final d = _items[i];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: _statusColor(d.status, Theme.of(context)),
                            child: Icon(
                              d.status == DeadlineStatus.paid
                                  ? Icons.check
                                  : Icons.event,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          title: Text(d.title),
                          subtitle: Text(
                            '${_dateFmt.format(d.dueDate)}'
                            '${d.amount != null ? ' · €${d.amount!.toStringAsFixed(2)}' : ''}',
                          ),
                          trailing: d.status == DeadlineStatus.paid
                              ? null
                              : IconButton(
                                  icon: const Icon(Icons.check_circle_outline),
                                  onPressed: () async {
                                    await _repo.complete(d.id!);
                                    await _load();
                                  },
                                ),
                        );
                      },
                    ),
            ),
    );
  }
}
