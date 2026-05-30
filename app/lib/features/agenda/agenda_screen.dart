import 'package:famylia_client/famylia_client.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/api/calendar_repository.dart';
import '../../core/api/deadline_repository.dart';
import '../../core/api/expense_repository.dart';
import '../../core/api/family_repository.dart';
import '../../core/extensions/context_extensions.dart';
import '../../core/router/app_router.dart';

class AgendaScreen extends StatefulWidget {
  const AgendaScreen({super.key});

  @override
  State<AgendaScreen> createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> with SingleTickerProviderStateMixin {
  late TabController _tab;

  final _calendarioKey = GlobalKey<_AppuntamentiTabState>();
  final _scadenzeKey = GlobalKey<_ScadenzeTabState>();
  final _speseKey = GlobalKey<_SpeseTabState>();

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 3, vsync: this);
    _tab.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  void _onFabTap() {
    switch (_tab.index) {
      case 0:
        _calendarioKey.currentState?._add();
      case 1:
        _scadenzeKey.currentState?._add();
      case 2:
        context.push(AppRoutes.expenses);
    }
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
            Tab(icon: Icon(Icons.event_outlined), text: 'Appuntamenti'),
            Tab(icon: Icon(Icons.alarm_outlined), text: 'Scadenze'),
            Tab(icon: Icon(Icons.payments_outlined), text: 'Spese'),
          ],
          indicatorColor: scheme.primary,
          labelColor: scheme.primary,
          unselectedLabelColor: scheme.onSurface.withValues(alpha: 0.55),
          labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'agenda_fab',
        onPressed: _onFabTap,
        tooltip: _tab.index == 2 ? 'Vai a Spese' : 'Aggiungi',
        child: const Icon(Icons.add),
      ),
      body: TabBarView(
        controller: _tab,
        children: [
          _AppuntamentiTab(key: _calendarioKey),
          _ScadenzeTab(key: _scadenzeKey),
          _SpeseTab(key: _speseKey),
        ],
      ),
    );
  }
}

// ── Appuntamenti ──────────────────────────────────────────────────────────

class _AppuntamentiTab extends StatefulWidget {
  const _AppuntamentiTab({super.key});

  @override
  State<_AppuntamentiTab> createState() => _AppuntamentiTabState();
}

class _AppuntamentiTabState extends State<_AppuntamentiTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final _repo = CalendarRepository();
  List<CalendarEvent> _events = [];
  bool _loading = true;
  final _timeFmt = DateFormat('HH:mm');
  final _dayKeyFmt = DateFormat('yyyy-MM-dd');
  final _dayLabelFmt = DateFormat('EEEE d MMMM', 'it');

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
    try {
      final events = await _repo.list(familyId, from, from.add(const Duration(days: 90)));
      if (mounted) setState(() => _events = events);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_repo.errorMessage(e))));
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
          title: const Text('Nuovo appuntamento'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleCtrl,
                autofocus: true,
                decoration: const InputDecoration(labelText: 'Titolo'),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: ctx,
                    initialDate: date,
                    firstDate: DateTime.now().subtract(const Duration(days: 365)),
                    lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
                  );
                  if (picked != null && ctx.mounted) {
                    final time = await showTimePicker(
                      context: ctx,
                      initialTime: TimeOfDay.fromDateTime(date),
                    );
                    setDlg(() {
                      date = DateTime(picked.year, picked.month, picked.day,
                          time?.hour ?? date.hour, time?.minute ?? date.minute);
                    });
                  }
                },
                icon: const Icon(Icons.calendar_today_outlined, size: 18),
                label: Text('${date.day}/${date.month}/${date.year}  ${_timeFmt.format(date)}'),
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_repo.errorMessage(e))));
      }
    }
  }

  Map<String, List<CalendarEvent>> _groupByDay() {
    final map = <String, List<CalendarEvent>>{};
    for (final e in _events) {
      final key = _dayKeyFmt.format(e.startAt.toLocal());
      (map[key] ??= []).add(e);
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final scheme = Theme.of(context).colorScheme;
    final groups = _groupByDay();
    final now = DateTime.now();
    final today = _dayKeyFmt.format(now);
    final tomorrow = _dayKeyFmt.format(now.add(const Duration(days: 1)));

    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_events.isEmpty) {
      return _EmptyState(
        icon: Icons.event_outlined,
        message: 'Nessun appuntamento nei prossimi 90 giorni',
        action: 'Aggiungi',
        onAction: _add,
      );
    }
    return RefreshIndicator(
      onRefresh: _load,
      child: ListView(
        padding: const EdgeInsets.only(bottom: 120),
        children: [
          for (final entry in groups.entries) ...[
            _DayHeader(
              label: switch (entry.key) {
                String k when k == today => 'Oggi · ${_dayLabelFmt.format(DateTime.parse(k))}',
                String k when k == tomorrow => 'Domani · ${_dayLabelFmt.format(DateTime.parse(k))}',
                _ => _dayLabelFmt.format(DateTime.parse(entry.key)),
              },
              isToday: entry.key == today,
            ),
            for (final e in entry.value)
              _EventCard(event: e, timeFmt: _timeFmt, accentColor: scheme.primary),
          ],
        ],
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  const _EventCard({required this.event, required this.timeFmt, required this.accentColor});
  final CalendarEvent event;
  final DateFormat timeFmt;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 40,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(event.title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                    const SizedBox(height: 2),
                    Text(timeFmt.format(event.startAt.toLocal()),
                        style: TextStyle(color: accentColor, fontWeight: FontWeight.w500, fontSize: 13)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Scadenze ──────────────────────────────────────────────────────────────

class _ScadenzeTab extends StatefulWidget {
  const _ScadenzeTab({super.key});

  @override
  State<_ScadenzeTab> createState() => _ScadenzeTabState();
}

class _ScadenzeTabState extends State<_ScadenzeTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final _repo = DeadlineRepository();
  final _families = FamilyRepository();
  List<Deadline> _items = [];
  List<FamilyMemberInfo> _members = [];
  bool _loading = true;
  final _dateFmt = DateFormat('d MMM yyyy', 'it');
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
      final results = await Future.wait([
        _repo.list(familyId),
        _families.listMembers(familyId),
      ]);
      if (mounted) {
        setState(() {
          _items = results[0] as List<Deadline>;
          _members = results[1] as List<FamilyMemberInfo>;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_repo.errorMessage(e))));
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
    int? assignedTo;

    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDlg) => AlertDialog(
          title: const Text('Nuova scadenza'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: titleCtrl,
                  autofocus: true,
                  decoration: const InputDecoration(labelText: 'Titolo (es. Bolletta luce)'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: amountCtrl,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(labelText: 'Importo (€)', prefixText: '€ '),
                ),
                const SizedBox(height: 10),
                OutlinedButton.icon(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: ctx,
                      initialDate: due,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
                    );
                    if (picked != null) setDlg(() => due = picked);
                  },
                  icon: const Icon(Icons.alarm_outlined, size: 18),
                  label: Text('Scade ${due.day}/${due.month}/${due.year}'),
                ),
                if (_members.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  DropdownButtonFormField<int?>(
                    value: assignedTo,
                    decoration: const InputDecoration(labelText: 'Assegna a'),
                    items: [
                      const DropdownMenuItem(value: null, child: Text('Nessuno')),
                      for (final m in _members)
                        DropdownMenuItem(value: m.userId, child: Text(m.displayName)),
                    ],
                    onChanged: (v) => setDlg(() => assignedTo = v),
                  ),
                ],
              ],
            ),
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_repo.errorMessage(e))));
      }
    }
  }

  List<Deadline> get _filtered => switch (_filter) {
        'overdue' => _items.where((d) => d.status == DeadlineStatus.overdue).toList(),
        'paid' => _items.where((d) => d.status == DeadlineStatus.paid).toList(),
        _ => _items.where((d) => d.status != DeadlineStatus.paid && d.status != DeadlineStatus.cancelled).toList(),
      };

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final scheme = Theme.of(context).colorScheme;
    final filtered = _filtered;
    final overdueCnt = _items.where((d) => d.status == DeadlineStatus.overdue).length;

    if (_loading) return const Center(child: CircularProgressIndicator());

    return Column(
      children: [
        // Filtri
        Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          alignment: Alignment.centerLeft,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _FChip('Da pagare', _filter == 'pending', () => setState(() => _filter = 'pending')),
                const SizedBox(width: 8),
                _FChip(
                  overdueCnt > 0 ? 'Scadute ($overdueCnt)' : 'Scadute',
                  _filter == 'overdue',
                  () => setState(() => _filter = 'overdue'),
                  urgentColor: overdueCnt > 0 ? scheme.error : null,
                ),
                const SizedBox(width: 8),
                _FChip('Pagate', _filter == 'paid', () => setState(() => _filter = 'paid')),
              ],
            ),
          ),
        ),
        Expanded(
          child: filtered.isEmpty
              ? _EmptyState(
                  icon: Icons.alarm_outlined,
                  message: 'Nessuna scadenza in questa categoria',
                  action: 'Aggiungi',
                  onAction: _add,
                )
              : RefreshIndicator(
                  onRefresh: _load,
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 120),
                    itemCount: filtered.length,
                    itemBuilder: (_, i) => _DeadlineCard(
                      deadline: filtered[i],
                      dateFmt: _dateFmt,
                      members: _members,
                      onPay: () async {
                        await _repo.complete(filtered[i].id!);
                        await _load();
                      },
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}

class _DeadlineCard extends StatelessWidget {
  const _DeadlineCard({
    required this.deadline,
    required this.dateFmt,
    required this.members,
    required this.onPay,
  });
  final Deadline deadline;
  final DateFormat dateFmt;
  final List<FamilyMemberInfo> members;
  final VoidCallback onPay;

  Color _color(DeadlineStatus s, ColorScheme cs) => switch (s) {
        DeadlineStatus.overdue => cs.error,
        DeadlineStatus.paid => Colors.green,
        DeadlineStatus.cancelled => cs.outline,
        _ => cs.primary,
      };

  IconData _icon(DeadlineStatus s) => switch (s) {
        DeadlineStatus.paid => Icons.check_circle,
        DeadlineStatus.cancelled => Icons.cancel_outlined,
        DeadlineStatus.overdue => Icons.warning_amber_rounded,
        _ => Icons.alarm,
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final color = _color(deadline.status, scheme);
    final isOverdue = deadline.status == DeadlineStatus.overdue;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: isOverdue ? BorderSide(color: scheme.error.withValues(alpha: 0.4)) : BorderSide.none,
      ),
      color: isOverdue ? scheme.error.withValues(alpha: 0.04) : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: color.withValues(alpha: 0.12),
              child: Icon(_icon(deadline.status), color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(deadline.title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                  const SizedBox(height: 2),
                  Text(dateFmt.format(deadline.dueDate),
                      style: TextStyle(fontSize: 13, color: color, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            if (deadline.amount != null) ...[
              const SizedBox(width: 8),
              Text(
                '€${deadline.amount!.toStringAsFixed(2)}',
                style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 15),
              ),
            ],
            if (deadline.status != DeadlineStatus.paid && deadline.status != DeadlineStatus.cancelled) ...[
              const SizedBox(width: 4),
              IconButton(
                icon: Icon(Icons.check_circle_outline, color: scheme.primary),
                tooltip: 'Segna pagata',
                onPressed: onPay,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ── Spese ─────────────────────────────────────────────────────────────────

class _SpeseTab extends StatefulWidget {
  const _SpeseTab({super.key});

  @override
  State<_SpeseTab> createState() => _SpeseTabState();
}

class _SpeseTabState extends State<_SpeseTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final _repo = ExpenseRepository();
  List<Expense> _items = [];
  bool _loading = true;
  final _dateFmt = DateFormat('d MMM', 'it');

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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_repo.errorMessage(e))));
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  double get _total => _items.fold(0.0, (s, e) => s + e.amount);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    if (_loading) return const Center(child: CircularProgressIndicator());

    return RefreshIndicator(
      onRefresh: _load,
      child: CustomScrollView(
        slivers: [
          if (_items.isNotEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Card(
                  color: scheme.primary.withValues(alpha: 0.07),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: BorderSide(color: scheme.primary.withValues(alpha: 0.2)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Totale speso', style: theme.textTheme.labelMedium),
                              const SizedBox(height: 2),
                              Text(
                                '€${_total.toStringAsFixed(2)}',
                                style: theme.textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.bold, color: scheme.primary),
                              ),
                            ],
                          ),
                        ),
                        OutlinedButton.icon(
                          onPressed: () => context.push(AppRoutes.expenseBalance),
                          icon: const Icon(Icons.account_balance_wallet_outlined, size: 18),
                          label: const Text('Bilancio'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          _items.isEmpty
              ? SliverFillRemaining(
                  child: _EmptyState(
                    icon: Icons.payments_outlined,
                    message: 'Nessuna spesa registrata',
                    action: 'Aggiungi spesa',
                    onAction: () => context.push(AppRoutes.expenses),
                  ),
                )
              : SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 120),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (_, i) {
                        final e = _items[i];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.orange.withValues(alpha: 0.12),
                              child: Icon(Icons.payments_outlined, color: Colors.orange.shade600, size: 20),
                            ),
                            title: Text(e.title, style: const TextStyle(fontWeight: FontWeight.w500)),
                            subtitle: Text(_dateFmt.format(e.expenseDate),
                                style: const TextStyle(fontSize: 13)),
                            trailing: Text(
                              '€${e.amount.toStringAsFixed(2)}',
                              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      },
                      childCount: _items.length,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

// ── Shared ────────────────────────────────────────────────────────────────

class _DayHeader extends StatelessWidget {
  const _DayHeader({required this.label, this.isToday = false});
  final String label;
  final bool isToday;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 16, 6),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.8,
          color: isToday ? scheme.primary : scheme.onSurface.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}

class _FChip extends StatelessWidget {
  const _FChip(this.label, this.selected, this.onTap, {this.urgentColor});
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color? urgentColor;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = urgentColor ?? scheme.primary;
    return FilterChip(
      label: Text(label, style: TextStyle(fontSize: 13, fontWeight: selected ? FontWeight.w600 : FontWeight.normal)),
      selected: selected,
      onSelected: (_) => onTap(),
      selectedColor: color.withValues(alpha: 0.12),
      checkmarkColor: color,
      labelStyle: TextStyle(color: selected ? color : null),
      side: BorderSide(color: selected ? color.withValues(alpha: 0.6) : scheme.outline.withValues(alpha: 0.4)),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({
    required this.icon,
    required this.message,
    this.action,
    this.onAction,
  });
  final IconData icon;
  final String message;
  final String? action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 48, color: scheme.onSurface.withValues(alpha: 0.2)),
          const SizedBox(height: 12),
          Text(message,
              style: TextStyle(color: scheme.onSurface.withValues(alpha: 0.5), fontSize: 14),
              textAlign: TextAlign.center),
          if (action != null && onAction != null) ...[
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: onAction,
              icon: const Icon(Icons.add, size: 18),
              label: Text(action!),
            ),
          ],
        ],
      ),
    );
  }
}
