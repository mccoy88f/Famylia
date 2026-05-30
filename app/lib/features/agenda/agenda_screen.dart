import 'package:famylia_client/famylia_client.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/api/calendar_repository.dart';
import '../../core/api/deadline_repository.dart';
import '../../core/api/expense_repository.dart';
import '../../core/extensions/context_extensions.dart';
import '../../core/router/app_router.dart';

class AgendaScreen extends StatefulWidget {
  const AgendaScreen({super.key});

  @override
  State<AgendaScreen> createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> with SingleTickerProviderStateMixin {
  late TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda'),
        bottom: TabBar(
          controller: _tab,
          tabs: const [
            Tab(icon: Icon(Icons.calendar_month_outlined), text: 'Calendario'),
            Tab(icon: Icon(Icons.alarm_outlined), text: 'Scadenze'),
            Tab(icon: Icon(Icons.payments_outlined), text: 'Spese'),
          ],
          indicatorColor: scheme.primary,
          labelColor: scheme.primary,
          unselectedLabelColor: scheme.onSurface.withValues(alpha: 0.6),
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: const [
          _CalendarioTab(),
          _ScadenzeTab(),
          _SpeseTab(),
        ],
      ),
    );
  }
}

// ── Calendario ────────────────────────────────────────────────────────────

class _CalendarioTab extends StatefulWidget {
  const _CalendarioTab();

  @override
  State<_CalendarioTab> createState() => _CalendarioTabState();
}

class _CalendarioTabState extends State<_CalendarioTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final _repo = CalendarRepository();
  List<CalendarEvent> _events = [];
  bool _loading = true;
  final _fmt = DateFormat('EEE d MMM · HH:mm', 'it');
  final _dayFmt = DateFormat('EEEE d MMMM', 'it');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    final familyId = context.activeFamilyId;
    if (familyId == null) return;
    setState(() => _loading = true);
    final now = DateTime.now();
    final from = DateTime(now.year, now.month, now.day);
    final to = from.add(const Duration(days: 60));
    try {
      final events = await _repo.list(familyId, from, to);
      if (mounted) setState(() => _events = events);
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
                controller: titleCtrl,
                autofocus: true,
                decoration: const InputDecoration(labelText: 'Titolo evento'),
              ),
              const SizedBox(height: 8),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.calendar_today_outlined),
                title: Text('${date.day}/${date.month}/${date.year}'),
                subtitle: Text('${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}'),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: ctx,
                    initialDate: date,
                    firstDate: DateTime.now().subtract(const Duration(days: 365)),
                    lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
                  );
                  if (picked != null) {
                    final time = await showTimePicker(
                      context: ctx,
                      initialTime: TimeOfDay.fromDateTime(date),
                    );
                    setDlg(() {
                      date = DateTime(
                        picked.year, picked.month, picked.day,
                        time?.hour ?? date.hour, time?.minute ?? date.minute,
                      );
                    });
                  }
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
    if (ok != true || titleCtrl.text.trim().isEmpty) return;
    try {
      await _repo.create(familyId, titleCtrl.text.trim(), date);
      await _load();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_repo.errorMessage(e))),
        );
      }
    }
  }

  Map<String, List<CalendarEvent>> _groupByDay() {
    final result = <String, List<CalendarEvent>>{};
    for (final e in _events) {
      final key = _dayFmt.format(e.startAt.toLocal());
      (result[key] ??= []).add(e);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final scheme = Theme.of(context).colorScheme;
    final groups = _groupByDay();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _add,
        child: const Icon(Icons.add),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _events.isEmpty
              ? const Center(child: Text('Nessun evento nei prossimi 60 giorni'))
              : RefreshIndicator(
                  onRefresh: _load,
                  child: ListView(
                    padding: const EdgeInsets.only(bottom: 100),
                    children: [
                      for (final entry in groups.entries) ...[
                        _DayHeader(label: entry.key),
                        for (final e in entry.value)
                          Card(
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: scheme.primary.withValues(alpha: 0.12),
                                child: Icon(Icons.event, color: scheme.primary, size: 20),
                              ),
                              title: Text(e.title, style: const TextStyle(fontWeight: FontWeight.w500)),
                              subtitle: Text(_fmt.format(e.startAt.toLocal())),
                            ),
                          ),
                      ],
                    ],
                  ),
                ),
    );
  }
}

// ── Scadenze ──────────────────────────────────────────────────────────────

class _ScadenzeTab extends StatefulWidget {
  const _ScadenzeTab();

  @override
  State<_ScadenzeTab> createState() => _ScadenzeTabState();
}

class _ScadenzeTabState extends State<_ScadenzeTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final _repo = DeadlineRepository();
  List<Deadline> _items = [];
  bool _loading = true;
  final _dateFmt = DateFormat('d MMM yyyy');
  String _filter = 'pending';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
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
    var due = DateTime.now().add(const Duration(days: 30));

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
                decoration: const InputDecoration(labelText: 'Titolo'),
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
                leading: const Icon(Icons.alarm_outlined),
                title: Text('Scade il ${_dateFmt.format(due)}'),
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
      await _repo.create(
        familyId,
        titleCtrl.text.trim(),
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

  List<Deadline> get _filtered {
    return switch (_filter) {
      'overdue' => _items.where((d) => d.status == DeadlineStatus.overdue).toList(),
      'paid' => _items.where((d) => d.status == DeadlineStatus.paid).toList(),
      _ => _items.where((d) => d.status != DeadlineStatus.paid && d.status != DeadlineStatus.cancelled).toList(),
    };
  }

  Color _statusColor(DeadlineStatus s, ColorScheme scheme) => switch (s) {
        DeadlineStatus.overdue => scheme.error,
        DeadlineStatus.paid => Colors.green,
        DeadlineStatus.cancelled => scheme.outline,
        _ => scheme.primary,
      };

  IconData _statusIcon(DeadlineStatus s) => switch (s) {
        DeadlineStatus.paid => Icons.check_circle,
        DeadlineStatus.cancelled => Icons.cancel_outlined,
        DeadlineStatus.overdue => Icons.warning_amber_rounded,
        _ => Icons.alarm,
      };

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final scheme = Theme.of(context).colorScheme;
    final filtered = _filtered;

    final overdueCnt = _items.where((d) => d.status == DeadlineStatus.overdue).length;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _add,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Row(
              children: [
                _FilterChip(label: 'Da pagare', selected: _filter == 'pending', onTap: () => setState(() => _filter = 'pending')),
                const SizedBox(width: 8),
                _FilterChip(
                  label: 'Scadute${overdueCnt > 0 ? ' ($overdueCnt)' : ''}',
                  selected: _filter == 'overdue',
                  onTap: () => setState(() => _filter = 'overdue'),
                  urgentColor: overdueCnt > 0 ? scheme.error : null,
                ),
                const SizedBox(width: 8),
                _FilterChip(label: 'Pagate', selected: _filter == 'paid', onTap: () => setState(() => _filter = 'paid')),
              ],
            ),
          ),
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : filtered.isEmpty
                    ? const Center(child: Text('Nessuna scadenza in questa categoria'))
                    : RefreshIndicator(
                        onRefresh: _load,
                        child: ListView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
                          itemCount: filtered.length,
                          itemBuilder: (_, i) {
                            final d = filtered[i];
                            final color = _statusColor(d.status, scheme);
                            return Card(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: color.withValues(alpha: 0.12),
                                  child: Icon(_statusIcon(d.status), color: color, size: 20),
                                ),
                                title: Text(d.title, style: const TextStyle(fontWeight: FontWeight.w500)),
                                subtitle: Text(_dateFmt.format(d.dueDate)),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (d.amount != null)
                                      Text(
                                        '€${d.amount!.toStringAsFixed(2)}',
                                        style: TextStyle(fontWeight: FontWeight.bold, color: color),
                                      ),
                                    if (d.status != DeadlineStatus.paid)
                                      IconButton(
                                        icon: Icon(Icons.check_circle_outline, color: scheme.primary),
                                        tooltip: 'Segna pagata',
                                        onPressed: () async {
                                          await _repo.complete(d.id!);
                                          await _load();
                                        },
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}

// ── Spese ─────────────────────────────────────────────────────────────────

class _SpeseTab extends StatefulWidget {
  const _SpeseTab();

  @override
  State<_SpeseTab> createState() => _SpeseTabState();
}

class _SpeseTabState extends State<_SpeseTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final _repo = ExpenseRepository();
  List<Expense> _items = [];
  bool _loading = true;
  final _dateFmt = DateFormat('d MMM');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
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

  double get _totalSpeso => _items.fold(0, (sum, e) => sum + e.amount);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'add_expense',
        onPressed: () => context.push(AppRoutes.expenses),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          if (_items.isNotEmpty)
            Container(
              margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: scheme.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: scheme.primary.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Totale speso', style: theme.textTheme.labelMedium),
                        Text(
                          '€${_totalSpeso.toStringAsFixed(2)}',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: scheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => context.push(AppRoutes.expenseBalance),
                    icon: const Icon(Icons.account_balance_wallet_outlined),
                    label: const Text('Bilancio'),
                  ),
                ],
              ),
            ),
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : _items.isEmpty
                    ? const Center(child: Text('Nessuna spesa registrata'))
                    : RefreshIndicator(
                        onRefresh: _load,
                        child: ListView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
                          itemCount: _items.length,
                          itemBuilder: (_, i) {
                            final e = _items[i];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.orange.withValues(alpha: 0.12),
                                  child: Icon(Icons.payments_outlined, color: Colors.orange.shade600, size: 20),
                                ),
                                title: Text(e.title, style: const TextStyle(fontWeight: FontWeight.w500)),
                                subtitle: Text(_dateFmt.format(e.expenseDate)),
                                trailing: Text(
                                  '€${e.amount.toStringAsFixed(2)}',
                                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}

// ── Shared components ─────────────────────────────────────────────────────

class _DayHeader extends StatelessWidget {
  const _DayHeader({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 16, 4),
      child: Text(
        label.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
              color: scheme.primary,
            ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.urgentColor,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color? urgentColor;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = urgentColor ?? scheme.primary;
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      selectedColor: color.withValues(alpha: 0.15),
      checkmarkColor: color,
      labelStyle: TextStyle(
        color: selected ? color : null,
        fontWeight: selected ? FontWeight.w600 : null,
      ),
      side: BorderSide(color: selected ? color : scheme.outline.withValues(alpha: 0.4)),
    );
  }
}
