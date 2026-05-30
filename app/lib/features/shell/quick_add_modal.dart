import 'package:famylia_client/famylia_client.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/api/board_repository.dart';
import '../../core/api/calendar_repository.dart';
import '../../core/api/deadline_repository.dart';
import '../../core/api/expense_repository.dart';
import '../../core/api/family_repository.dart';
import '../../core/api/shopping_repository.dart';
import '../../core/api/todo_repository.dart';
import '../../core/extensions/context_extensions.dart';
import '../../core/session/app_state.dart';

class QuickAddModal extends StatelessWidget {
  const QuickAddModal({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const QuickAddModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: scheme.outline.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Aggiungi',
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.1,
            children: [
              _QuickTile(
                icon: Icons.check_circle_outline,
                label: 'Task',
                color: Colors.blue.shade400,
                onTap: () => _addTodo(context),
              ),
              _QuickTile(
                icon: Icons.shopping_cart_outlined,
                label: 'Articolo',
                color: Colors.green.shade400,
                onTap: () => _addShoppingItem(context),
              ),
              _QuickTile(
                icon: Icons.payments_outlined,
                label: 'Spesa',
                color: Colors.orange.shade400,
                onTap: () => _addExpense(context),
              ),
              _QuickTile(
                icon: Icons.event_outlined,
                label: 'Evento',
                color: Colors.purple.shade400,
                onTap: () => _addEvent(context),
              ),
              _QuickTile(
                icon: Icons.alarm_outlined,
                label: 'Scadenza',
                color: Colors.red.shade400,
                onTap: () => _addDeadline(context),
              ),
              _QuickTile(
                icon: Icons.forum_outlined,
                label: 'Post',
                color: Colors.teal.shade400,
                onTap: () => _addPost(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _addTodo(BuildContext context) async {
    final familyId = context.activeFamilyId;
    if (familyId == null) return;
    Navigator.pop(context);
    final ctrl = TextEditingController();
    final title = await showDialog<String>(
      context: context,
      builder: (ctx) => _SimpleDialog(
        title: 'Nuovo task',
        hintText: 'Cosa devi fare?',
        controller: ctrl,
        confirmLabel: 'Aggiungi',
      ),
    );
    if (title == null || title.trim().isEmpty) return;
    try {
      await TodoRepository().create(familyId, title.trim());
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task aggiunto'), duration: Duration(seconds: 2)),
        );
      }
    } catch (_) {}
  }

  Future<void> _addShoppingItem(BuildContext context) async {
    final familyId = context.activeFamilyId;
    if (familyId == null) return;
    Navigator.pop(context);
    final repo = ShoppingRepository();
    List<ShoppingList> lists = [];
    try {
      lists = await repo.listLists(familyId);
    } catch (_) {}
    if (!context.mounted) return;

    if (lists.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Crea prima una lista della spesa')),
      );
      return;
    }

    var selectedListId = lists.first.id!;
    final itemCtrl = TextEditingController();

    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDlg) => AlertDialog(
          title: const Text('Aggiungi articolo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<int>(
                value: selectedListId,
                decoration: const InputDecoration(labelText: 'Lista'),
                items: [
                  for (final l in lists)
                    DropdownMenuItem(value: l.id, child: Text(l.name)),
                ],
                onChanged: (v) => setDlg(() => selectedListId = v ?? selectedListId),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: itemCtrl,
                autofocus: true,
                decoration: const InputDecoration(hintText: 'Cosa comprare?'),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Annulla')),
            FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Aggiungi')),
          ],
        ),
      ),
    );
    if (ok != true || itemCtrl.text.trim().isEmpty) return;
    try {
      await repo.addItem(selectedListId, itemCtrl.text.trim());
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Articolo aggiunto'), duration: Duration(seconds: 2)),
        );
      }
    } catch (_) {}
  }

  Future<void> _addExpense(BuildContext context) async {
    final familyId = context.activeFamilyId;
    if (familyId == null) return;
    final me = context.read<AppState>().signedInUser?.id;
    if (me == null) return;
    Navigator.pop(context);

    final titleCtrl = TextEditingController();
    final amountCtrl = TextEditingController();
    var paidBy = me;
    List<FamilyMemberInfo> members = [];
    try {
      members = await FamilyRepository().listMembers(familyId);
    } catch (_) {}
    if (!context.mounted) return;

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
                autofocus: true,
                decoration: const InputDecoration(labelText: 'Titolo'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: amountCtrl,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Importo (€)', prefixText: '€ '),
              ),
              if (members.isNotEmpty) ...[
                const SizedBox(height: 8),
                DropdownButtonFormField<int>(
                  value: paidBy,
                  decoration: const InputDecoration(labelText: 'Pagato da'),
                  items: [
                    for (final m in members)
                      DropdownMenuItem(value: m.userId, child: Text(m.displayName)),
                  ],
                  onChanged: (v) => setDlg(() => paidBy = v ?? me),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Annulla')),
            FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Salva')),
          ],
        ),
      ),
    );
    if (ok != true || titleCtrl.text.trim().isEmpty) return;
    final amount = double.tryParse(amountCtrl.text.replaceAll(',', '.'));
    if (amount == null || amount <= 0) return;
    try {
      await ExpenseRepository().create(familyId, titleCtrl.text.trim(), amount, paidBy);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Spesa aggiunta'), duration: Duration(seconds: 2)),
        );
      }
    } catch (_) {}
  }

  Future<void> _addEvent(BuildContext context) async {
    final familyId = context.activeFamilyId;
    if (familyId == null) return;
    Navigator.pop(context);
    final ctrl = TextEditingController();
    var date = DateTime.now().add(const Duration(hours: 2));

    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDlg) => AlertDialog(
          title: const Text('Nuovo evento'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: ctrl,
                autofocus: true,
                decoration: const InputDecoration(labelText: 'Titolo'),
              ),
              const SizedBox(height: 8),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  '${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}',
                ),
                leading: const Icon(Icons.calendar_today_outlined),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: ctx,
                    initialDate: date,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
                  );
                  if (picked != null) setDlg(() => date = picked);
                },
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Annulla')),
            FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Crea')),
          ],
        ),
      ),
    );
    if (ok != true || ctrl.text.trim().isEmpty) return;
    try {
      await CalendarRepository().create(familyId, ctrl.text.trim(), date);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Evento aggiunto'), duration: Duration(seconds: 2)),
        );
      }
    } catch (_) {}
  }

  Future<void> _addDeadline(BuildContext context) async {
    final familyId = context.activeFamilyId;
    if (familyId == null) return;
    Navigator.pop(context);
    final titleCtrl = TextEditingController();
    final amountCtrl = TextEditingController();
    var due = DateTime.now().add(const Duration(days: 7));

    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDlg) => AlertDialog(
          title: const Text('Nuova scadenza'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleCtrl,
                autofocus: true,
                decoration: const InputDecoration(labelText: 'Titolo (es. Bolletta luce)'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: amountCtrl,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Importo (€)', prefixText: '€ '),
              ),
              const SizedBox(height: 8),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Scade il ${due.day}/${due.month}/${due.year}'),
                leading: const Icon(Icons.alarm_outlined),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: ctx,
                    initialDate: due,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
                  );
                  if (picked != null) setDlg(() => due = picked);
                },
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Annulla')),
            FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Salva')),
          ],
        ),
      ),
    );
    if (ok != true || titleCtrl.text.trim().isEmpty) return;
    try {
      await DeadlineRepository().create(
        familyId,
        titleCtrl.text.trim(),
        due,
        amount: double.tryParse(amountCtrl.text.replaceAll(',', '.')),
        category: DeadlineCategory.bill,
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Scadenza aggiunta'), duration: Duration(seconds: 2)),
        );
      }
    } catch (_) {}
  }

  Future<void> _addPost(BuildContext context) async {
    final familyId = context.activeFamilyId;
    if (familyId == null) return;
    Navigator.pop(context);
    final ctrl = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Nuovo post bacheca'),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          maxLines: 3,
          decoration: const InputDecoration(hintText: 'Scrivi un messaggio alla famiglia...'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Annulla')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Pubblica')),
        ],
      ),
    );
    if (ok != true || ctrl.text.trim().isEmpty) return;
    try {
      await BoardRepository().createNote(familyId, ctrl.text.trim());
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Post pubblicato'), duration: Duration(seconds: 2)),
        );
      }
    } catch (_) {}
  }
}

class _QuickTile extends StatelessWidget {
  const _QuickTile({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 6),
              Text(
                label,
                style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SimpleDialog extends StatelessWidget {
  const _SimpleDialog({
    required this.title,
    required this.hintText,
    required this.controller,
    required this.confirmLabel,
  });

  final String title;
  final String hintText;
  final TextEditingController controller;
  final String confirmLabel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: TextField(
        controller: controller,
        autofocus: true,
        decoration: InputDecoration(hintText: hintText),
        onSubmitted: (v) => Navigator.pop(context, v),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Annulla')),
        FilledButton(
          onPressed: () => Navigator.pop(context, controller.text),
          child: Text(confirmLabel),
        ),
      ],
    );
  }
}
