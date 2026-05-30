import 'package:famylia_client/famylia_client.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

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
    final shadTheme = ShadTheme.of(context);

    return Scaffold(
      backgroundColor: shadTheme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: shadTheme.colorScheme.background,
        surfaceTintColor: Colors.transparent,
        title: Text('Agenda', style: shadTheme.textTheme.h4),
        bottom: TabBar(
          controller: _tab,
          tabs: const [
            Tab(icon: Icon(Icons.event_outlined), text: 'Appuntamenti'),
            Tab(icon: Icon(Icons.alarm_outlined), text: 'Scadenze'),
            Tab(icon: Icon(Icons.payments_outlined), text: 'Spese'),
          ],
          indicatorColor: shadTheme.colorScheme.primary,
          labelColor: shadTheme.colorScheme.primary,
          unselectedLabelColor: shadTheme.colorScheme.mutedForeground,
          labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'agenda_fab',
        backgroundColor: shadTheme.colorScheme.primary,
        foregroundColor: shadTheme.colorScheme.primaryForeground,
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
    final shadTheme = ShadTheme.of(context);

    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDlg) => AlertDialog(
          backgroundColor: shadTheme.colorScheme.background,
          title: Text('Nuovo appuntamento', style: shadTheme.textTheme.h4),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ShadInput(
                controller: titleCtrl,
                autofocus: true,
                placeholder: const Text('Titolo'),
              ),
              const SizedBox(height: 12),
              ShadButton.outline(
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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.calendar_today_outlined, size: 16),
                    const SizedBox(width: 6),
                    Text('${date.day}/${date.month}/${date.year}  ${_timeFmt.format(date)}'),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            ShadButton.ghost(onPressed: () => Navigator.pop(ctx, false), child: const Text('Annulla')),
            ShadButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Crea')),
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
    final shadTheme = ShadTheme.of(context);
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
              shadTheme: shadTheme,
            ),
            for (final e in entry.value)
              _EventCard(event: e, timeFmt: _timeFmt, shadTheme: shadTheme),
          ],
        ],
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  const _EventCard({required this.event, required this.timeFmt, required this.shadTheme});
  final CalendarEvent event;
  final DateFormat timeFmt;
  final ShadThemeData shadTheme;

  @override
  Widget build(BuildContext context) {
    final primary = shadTheme.colorScheme.primary;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: ShadCard(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 3,
              height: 38,
              decoration: BoxDecoration(
                color: primary,
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
                      style: TextStyle(color: primary, fontWeight: FontWeight.w500, fontSize: 13)),
                ],
              ),
            ),
          ],
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
    final shadTheme = ShadTheme.of(context);

    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDlg) => AlertDialog(
          backgroundColor: shadTheme.colorScheme.background,
          title: Text('Nuova scadenza', style: shadTheme.textTheme.h4),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShadInput(
                  controller: titleCtrl,
                  autofocus: true,
                  placeholder: const Text('Titolo (es. Bolletta luce)'),
                ),
                const SizedBox(height: 10),
                ShadInput(
                  controller: amountCtrl,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  placeholder: const Text('Importo (€)'),
                  leading: const Padding(
                    padding: EdgeInsets.only(left: 4),
                    child: Text('€', style: TextStyle(fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(height: 10),
                ShadButton.outline(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: ctx,
                      initialDate: due,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
                    );
                    if (picked != null) setDlg(() => due = picked);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.alarm_outlined, size: 16),
                      const SizedBox(width: 6),
                      Text('Scade ${due.day}/${due.month}/${due.year}'),
                    ],
                  ),
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
            ShadButton.ghost(onPressed: () => Navigator.pop(ctx, false), child: const Text('Annulla')),
            ShadButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Salva')),
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
    final shadTheme = ShadTheme.of(context);
    final filtered = _filtered;
    final overdueCnt = _items.where((d) => d.status == DeadlineStatus.overdue).length;

    if (_loading) return const Center(child: CircularProgressIndicator());

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          alignment: Alignment.centerLeft,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _FChip('Da pagare', _filter == 'pending', () => setState(() => _filter = 'pending'), shadTheme),
                const SizedBox(width: 8),
                _FChip(
                  overdueCnt > 0 ? 'Scadute ($overdueCnt)' : 'Scadute',
                  _filter == 'overdue',
                  () => setState(() => _filter = 'overdue'),
                  shadTheme,
                  urgentColor: overdueCnt > 0 ? shadTheme.colorScheme.destructive : null,
                ),
                const SizedBox(width: 8),
                _FChip('Pagate', _filter == 'paid', () => setState(() => _filter = 'paid'), shadTheme),
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
                    itemBuilder: (_, i) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: _DeadlineCard(
                        deadline: filtered[i],
                        dateFmt: _dateFmt,
                        shadTheme: shadTheme,
                        onPay: () async {
                          await _repo.complete(filtered[i].id!);
                          await _load();
                        },
                      ),
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
    required this.shadTheme,
    required this.onPay,
  });
  final Deadline deadline;
  final DateFormat dateFmt;
  final ShadThemeData shadTheme;
  final VoidCallback onPay;

  Color _color(DeadlineStatus s) => switch (s) {
        DeadlineStatus.overdue => shadTheme.colorScheme.destructive,
        DeadlineStatus.paid => const Color(0xFF10B981),
        DeadlineStatus.cancelled => shadTheme.colorScheme.mutedForeground,
        _ => shadTheme.colorScheme.primary,
      };

  IconData _icon(DeadlineStatus s) => switch (s) {
        DeadlineStatus.paid => Icons.check_circle,
        DeadlineStatus.cancelled => Icons.cancel_outlined,
        DeadlineStatus.overdue => Icons.warning_amber_rounded,
        _ => Icons.alarm,
      };

  @override
  Widget build(BuildContext context) {
    final color = _color(deadline.status);
    final isOverdue = deadline.status == DeadlineStatus.overdue;

    return ShadCard(
      backgroundColor: isOverdue ? color.withValues(alpha: 0.04) : null,
      border: isOverdue ? Border.all(color: color.withValues(alpha: 0.3)) : null,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: color.withValues(alpha: 0.12),
            child: Icon(_icon(deadline.status), color: color, size: 18),
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
            ShadButton.ghost(
              onPressed: onPay,
              size: ShadButtonSize.icon,
              child: Icon(Icons.check_circle_outline, color: shadTheme.colorScheme.primary, size: 20),
            ),
          ],
        ],
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
    final shadTheme = ShadTheme.of(context);

    if (_loading) return const Center(child: CircularProgressIndicator());

    return RefreshIndicator(
      onRefresh: _load,
      child: CustomScrollView(
        slivers: [
          if (_items.isNotEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: ShadCard(
                  backgroundColor: shadTheme.colorScheme.primary.withValues(alpha: 0.06),
                  border: Border.all(color: shadTheme.colorScheme.primary.withValues(alpha: 0.2)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Totale speso', style: shadTheme.textTheme.muted),
                            const SizedBox(height: 2),
                            Text(
                              '€${_total.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: shadTheme.colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ShadButton.outline(
                        onPressed: () => context.push(AppRoutes.expenseBalance),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.account_balance_wallet_outlined, size: 16),
                            SizedBox(width: 6),
                            Text('Bilancio'),
                          ],
                        ),
                      ),
                    ],
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
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: ShadCard(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 18,
                                  backgroundColor: const Color(0xFFF59E0B).withValues(alpha: 0.12),
                                  child: const Icon(Icons.payments_outlined, color: Color(0xFFF59E0B), size: 18),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(e.title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                                      Text(_dateFmt.format(e.expenseDate),
                                          style: TextStyle(fontSize: 12, color: shadTheme.colorScheme.mutedForeground)),
                                    ],
                                  ),
                                ),
                                Text(
                                  '€${e.amount.toStringAsFixed(2)}',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                ),
                              ],
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
  const _DayHeader({required this.label, required this.shadTheme, this.isToday = false});
  final String label;
  final bool isToday;
  final ShadThemeData shadTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 16, 6),
      child: Text(
        label.toUpperCase(),
        style: shadTheme.textTheme.muted.copyWith(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.8,
          color: isToday ? shadTheme.colorScheme.primary : null,
        ),
      ),
    );
  }
}

class _FChip extends StatelessWidget {
  const _FChip(this.label, this.selected, this.onTap, this.shadTheme, {this.urgentColor});
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final ShadThemeData shadTheme;
  final Color? urgentColor;

  @override
  Widget build(BuildContext context) {
    final color = urgentColor ?? shadTheme.colorScheme.primary;
    return FilterChip(
      label: Text(label, style: TextStyle(fontSize: 13, fontWeight: selected ? FontWeight.w600 : FontWeight.normal)),
      selected: selected,
      onSelected: (_) => onTap(),
      selectedColor: color.withValues(alpha: 0.12),
      checkmarkColor: color,
      labelStyle: TextStyle(color: selected ? color : null),
      side: BorderSide(color: selected ? color.withValues(alpha: 0.5) : shadTheme.colorScheme.border),
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
    final shadTheme = ShadTheme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: shadTheme.colorScheme.mutedForeground),
            const SizedBox(height: 12),
            Text(message,
                style: shadTheme.textTheme.muted,
                textAlign: TextAlign.center),
            if (action != null && onAction != null) ...[
              const SizedBox(height: 16),
              ShadButton.outline(
                onPressed: onAction,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.add, size: 16),
                    const SizedBox(width: 6),
                    Text(action!),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
