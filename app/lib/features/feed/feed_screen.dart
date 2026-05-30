import 'package:famylia_client/famylia_client.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../core/api/auth_repository.dart';
import '../../core/api/board_repository.dart';
import '../../core/api/deadline_repository.dart';
import '../../core/api/family_repository.dart';
import '../../core/api/shopping_repository.dart';
import '../../core/api/todo_repository.dart';
import '../../core/extensions/context_extensions.dart';
import '../../core/router/app_router.dart';
import '../../core/session/app_state.dart';
import '../../core/session/family_context.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final _todos = TodoRepository();
  final _deadlines = DeadlineRepository();
  final _shopping = ShoppingRepository();
  final _board = BoardRepository();
  final _families = FamilyRepository();

  // Feed data
  List<TodoItem> _myUrgentTodos = [];
  List<TodoItem> _myTodayTodos = [];
  List<Deadline> _urgentDeadlines = [];
  List<Deadline> _upcomingDeadlines = [];
  int _totalUnchecked = 0;
  List<ShoppingList> _shoppingLists = [];
  BoardPostWithPoll? _latestPost;

  // Carico settimanale
  List<FamilyMemberInfo> _members = [];
  Map<int, int> _memberLoad = {}; // userId → count open todos

  // Multi-famiglia
  List<FamilyWithRole> _myFamilies = [];

  bool _loading = true;
  bool _offline = false;
  int? _myUserId;

  final _dateFmt = DateFormat('d MMM', 'it');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    final familyId = context.activeFamilyId;
    if (familyId == null) return;
    final me = context.read<AppState>().signedInUser?.id;
    setState(() { _loading = true; _myUserId = me; });

    try {
      _offline = !await _shopping.isOnline;
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final tomorrow = today.add(const Duration(days: 1));
      final in7 = today.add(const Duration(days: 7));

      final results = await Future.wait([
        _todos.list(familyId),
        _deadlines.list(familyId),
        _shopping.listLists(familyId),
        _families.listMembers(familyId),
        _families.listMyFamilies(),
      ]);

      final allTodos = results[0] as List<TodoItem>;
      final allDeadlines = results[1] as List<Deadline>;
      final lists = results[2] as List<ShoppingList>;
      final members = results[3] as List<FamilyMemberInfo>;
      final myFamilies = results[4] as List<FamilyWithRole>;

      // Filtra todo: mostro quelli dove sono responsabile O non assegnati
      final myTodos = allTodos.where((t) =>
          t.status != TodoStatus.done &&
          (t.assignedTo == me || t.assignedTo == null)).toList();

      final myUrgent = myTodos.where((t) =>
          t.dueDate != null && t.dueDate!.isBefore(tomorrow)).toList();

      final myToday = myTodos.where((t) =>
          t.dueDate == null || !t.dueDate!.isBefore(tomorrow)).take(6).toList();

      // Scadenze: famiglia intera le vede tutti
      final urgentDeadlines = allDeadlines.where((d) {
        if (d.status == DeadlineStatus.paid || d.status == DeadlineStatus.cancelled) return false;
        return d.status == DeadlineStatus.overdue || d.dueDate.isBefore(tomorrow);
      }).toList();

      final upcomingDeadlines = allDeadlines.where((d) {
        if (d.status == DeadlineStatus.paid || d.status == DeadlineStatus.cancelled) return false;
        if (d.status == DeadlineStatus.overdue) return false;
        return !d.dueDate.isBefore(tomorrow) && d.dueDate.isBefore(in7);
      }).toList();

      // Carico settimanale (open todos per membro)
      final load = <int, int>{};
      for (final t in allTodos.where((t) => t.status != TodoStatus.done)) {
        if (t.assignedTo != null) {
          load[t.assignedTo!] = (load[t.assignedTo!] ?? 0) + 1;
        }
      }

      // Shopping
      var unchecked = 0;
      for (final l in lists) {
        if (l.id == null) continue;
        try {
          final detail = await _shopping.getList(l.id!);
          unchecked += detail.items.where((i) => !i.isChecked).length;
        } catch (_) {}
      }

      // Bacheca (ultimo post)
      BoardPostWithPoll? latestPost;
      try {
        latestPost = await _board.watch(familyId).first.then((p) => p.isNotEmpty ? p.first : null);
      } catch (_) {}

      if (mounted) {
        setState(() {
          _myUrgentTodos = myUrgent;
          _myTodayTodos = myToday;
          _urgentDeadlines = urgentDeadlines;
          _upcomingDeadlines = upcomingDeadlines;
          _totalUnchecked = unchecked;
          _shoppingLists = lists;
          _latestPost = latestPost;
          _members = members;
          _memberLoad = load;
          _myFamilies = myFamilies;
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final family = context.watch<FamilyContext>();
    final scheme = Theme.of(context).colorScheme;
    final hasUrgencies = _myUrgentTodos.isNotEmpty || _urgentDeadlines.isNotEmpty;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _load,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              title: GestureDetector(
                onTap: () => _showFamilySwitcher(context, family),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              family.activeFamilyName ?? 'Famylia',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            if (_myFamilies.length > 1) ...[
                              const SizedBox(width: 4),
                              Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: scheme.primary),
                            ],
                          ],
                        ),
                        Text(
                          'Ciao, ${appState.userName ?? 'famiglia'} 👋',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: scheme.onSurface.withValues(alpha: 0.6)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              centerTitle: false,
              actions: [
                if (_offline)
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Icon(Icons.cloud_off, size: 18, color: scheme.onSurface.withValues(alpha: 0.5)),
                  ),
                IconButton(
                  icon: const Icon(Icons.settings_outlined),
                  onPressed: () => _showSettings(context, family),
                ),
              ],
            ),
            if (_loading)
              const SliverFillRemaining(child: Center(child: CircularProgressIndicator()))
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 120),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // ── Urgente ──
                    if (hasUrgencies) ...[
                      _SectionHeader(Icons.warning_amber_rounded, 'Urgente', scheme.error),
                      const SizedBox(height: 8),
                      ..._urgentDeadlines.map((d) => _UrgentDeadlineCard(
                            deadline: d, dateFmt: _dateFmt,
                            onPay: () async { await _deadlines.complete(d.id!); _load(); },
                          )),
                      ..._myUrgentTodos.map((t) => _UrgentTodoCard(
                            todo: t, dateFmt: _dateFmt,
                            onDone: () async { await _todos.complete(t.id!); _load(); },
                          )),
                      const SizedBox(height: 20),
                    ],

                    // ── Le mie attività oggi ──
                    _SectionHeader(
                      Icons.task_alt_outlined, 'Le mie attività', scheme.primary,
                      action: TextButton(onPressed: () => context.go(AppRoutes.lista), child: const Text('Tutte')),
                    ),
                    const SizedBox(height: 8),
                    if (_myTodayTodos.isEmpty)
                      _EmptyCard(Icons.check_circle_outline, 'Nessun task assegnato', scheme.primary)
                    else
                      _MyTodosCard(
                        todos: _myTodayTodos,
                        onToggle: (t) async { await _todos.complete(t.id!); _load(); },
                        onTapAll: () => context.go(AppRoutes.lista),
                      ),
                    const SizedBox(height: 20),

                    // ── Carico settimanale (se ci sono membri assegnati) ──
                    if (_members.isNotEmpty && _memberLoad.isNotEmpty) ...[
                      _SectionHeader(Icons.bar_chart_outlined, 'Carico famiglia', Colors.indigo.shade400),
                      const SizedBox(height: 8),
                      _FamilyLoadCard(members: _members, load: _memberLoad, myUserId: _myUserId),
                      const SizedBox(height: 20),
                    ],

                    // ── Da comprare ──
                    _SectionHeader(
                      Icons.shopping_cart_outlined, 'Da comprare', Colors.green.shade600,
                      action: TextButton(
                        onPressed: () => context.go(AppRoutes.lista, extra: 'shopping'),
                        child: const Text('Apri'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _ShoppingPreviewCard(
                      lists: _shoppingLists,
                      totalUnchecked: _totalUnchecked,
                      onTap: () => context.go(AppRoutes.lista, extra: 'shopping'),
                    ),

                    // ── In scadenza 7 giorni ──
                    if (_upcomingDeadlines.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      _SectionHeader(
                        Icons.alarm_outlined, 'In scadenza (7 giorni)', Colors.orange.shade700,
                        action: TextButton(onPressed: () => context.go(AppRoutes.agenda), child: const Text('Tutte')),
                      ),
                      const SizedBox(height: 8),
                      Card(
                        child: Column(
                          children: _upcomingDeadlines.take(3).map((d) => ListTile(
                            leading: CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.orange.withValues(alpha: 0.12),
                              child: Icon(Icons.alarm, color: Colors.orange.shade700, size: 18),
                            ),
                            title: Text(d.title, style: const TextStyle(fontWeight: FontWeight.w500)),
                            subtitle: Text(_dateFmt.format(d.dueDate)),
                            trailing: d.amount != null
                                ? Text('€${d.amount!.toStringAsFixed(0)}',
                                    style: const TextStyle(fontWeight: FontWeight.bold))
                                : null,
                            onTap: () => context.go(AppRoutes.agenda),
                          )).toList(),
                        ),
                      ),
                    ],

                    // ── Bacheca ──
                    if (_latestPost != null) ...[
                      const SizedBox(height: 20),
                      _SectionHeader(
                        Icons.forum_outlined, 'Bacheca', Colors.teal.shade600,
                        action: TextButton(onPressed: () => context.push(AppRoutes.board), child: const Text('Apri')),
                      ),
                      const SizedBox(height: 8),
                      _BoardPreviewCard(post: _latestPost!, onTap: () => context.push(AppRoutes.board)),
                    ],

                    const SizedBox(height: 8),
                  ]),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showFamilySwitcher(BuildContext context, FamilyContext family) {
    if (_myFamilies.length <= 1) return;
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Row(
                children: [
                  Text('Le tue famiglie', style: Theme.of(ctx).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            for (final fw in _myFamilies)
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: fw.family.id == family.activeFamilyId
                      ? Theme.of(ctx).colorScheme.primary.withValues(alpha: 0.15)
                      : Theme.of(ctx).colorScheme.outline.withValues(alpha: 0.15),
                  child: Text(
                    fw.family.name[0].toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: fw.family.id == family.activeFamilyId
                          ? Theme.of(ctx).colorScheme.primary
                          : null,
                    ),
                  ),
                ),
                title: Text(fw.family.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text(_roleLabel(fw.role)),
                trailing: fw.family.id == family.activeFamilyId
                    ? Icon(Icons.check_circle, color: Theme.of(ctx).colorScheme.primary)
                    : null,
                onTap: () async {
                  Navigator.pop(ctx);
                  await family.setActiveFamily(
                    id: fw.family.id!,
                    name: fw.family.name,
                    accentColor: fw.family.accentColor,
                    role: fw.role,
                  );
                  if (mounted) _load();
                },
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  String _roleLabel(FamilyRole r) => switch (r) {
        FamilyRole.admin => 'Amministratore',
        FamilyRole.guest => 'Ospite',
        _ => 'Membro',
      };

  void _showSettings(BuildContext context, FamilyContext family) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.palette_outlined),
              title: const Text('Aspetto'),
              onTap: () { Navigator.pop(ctx); context.push(AppRoutes.appearance); },
            ),
            ListTile(
              leading: const Icon(Icons.shield_outlined),
              title: const Text('Privacy'),
              onTap: () { Navigator.pop(ctx); context.push(AppRoutes.privacy); },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Esci', style: TextStyle(color: Colors.red)),
              onTap: () async {
                Navigator.pop(ctx);
                await family.clear();
                await AuthRepository().signOut();
                if (context.mounted) context.go(AppRoutes.login);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ── Widget sections ───────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.icon, this.label, this.color, {this.action});
  final IconData icon;
  final String label;
  final Color color;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 6),
        Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: color)),
        const Spacer(),
        if (action != null) action!,
      ],
    );
  }
}

class _EmptyCard extends StatelessWidget {
  const _EmptyCard(this.icon, this.label, this.color);
  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Row(
          children: [
            Icon(icon, color: color.withValues(alpha: 0.4), size: 22),
            const SizedBox(width: 12),
            Text(label, style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.45), fontSize: 14)),
          ],
        ),
      ),
    );
  }
}

class _UrgentDeadlineCard extends StatelessWidget {
  const _UrgentDeadlineCard({required this.deadline, required this.dateFmt, required this.onPay});
  final Deadline deadline;
  final DateFormat dateFmt;
  final VoidCallback onPay;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 6),
      color: scheme.error.withValues(alpha: 0.06),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: scheme.error.withValues(alpha: 0.3)),
      ),
      child: ListTile(
        leading: CircleAvatar(radius: 18, backgroundColor: scheme.error.withValues(alpha: 0.12),
            child: Icon(Icons.alarm, color: scheme.error, size: 18)),
        title: Text(deadline.title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        subtitle: Text(
          deadline.status == DeadlineStatus.overdue
              ? 'Scaduta il ${dateFmt.format(deadline.dueDate)}'
              : 'Scade oggi',
          style: TextStyle(color: scheme.error, fontSize: 12),
        ),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
          if (deadline.amount != null)
            Text('€${deadline.amount!.toStringAsFixed(0)}',
                style: TextStyle(fontWeight: FontWeight.bold, color: scheme.error)),
          IconButton(
            icon: Icon(Icons.check_circle_outline, color: scheme.error),
            onPressed: onPay, tooltip: 'Segna pagata',
          ),
        ]),
      ),
    );
  }
}

class _UrgentTodoCard extends StatelessWidget {
  const _UrgentTodoCard({required this.todo, required this.dateFmt, required this.onDone});
  final TodoItem todo;
  final DateFormat dateFmt;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 6),
      color: scheme.error.withValues(alpha: 0.04),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: scheme.error.withValues(alpha: 0.2)),
      ),
      child: ListTile(
        leading: Checkbox(value: false, onChanged: (_) => onDone(), shape: const CircleBorder()),
        title: Text(todo.title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
        subtitle: todo.dueDate != null
            ? Text('Scaduto il ${dateFmt.format(todo.dueDate!)}',
                style: TextStyle(color: scheme.error, fontSize: 12))
            : null,
      ),
    );
  }
}

class _MyTodosCard extends StatelessWidget {
  const _MyTodosCard({required this.todos, required this.onToggle, required this.onTapAll});
  final List<TodoItem> todos;
  final void Function(TodoItem) onToggle;
  final VoidCallback onTapAll;

  Color _priorityColor(TodoPriority p, ColorScheme s) => switch (p) {
        TodoPriority.critical => s.error,
        TodoPriority.high => Colors.orange.shade600,
        TodoPriority.medium => s.primary,
        _ => s.outline,
      };

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      child: Column(
        children: [
          ...todos.take(5).map((t) => CheckboxListTile(
            value: t.status == TodoStatus.done,
            onChanged: (_) => onToggle(t),
            shape: const CircleBorder(),
            controlAffinity: ListTileControlAffinity.leading,
            dense: true,
            title: Row(
              children: [
                Expanded(child: Text(t.title, style: const TextStyle(fontSize: 14))),
                Container(
                  width: 8, height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _priorityColor(t.priority, scheme),
                  ),
                ),
                const SizedBox(width: 4),
              ],
            ),
            subtitle: t.assignedTo == null
                ? const Text('Non assegnato', style: TextStyle(fontSize: 11))
                : null,
          )),
          if (todos.length > 5)
            TextButton(onPressed: onTapAll, child: Text('+${todos.length - 5} altri task')),
        ],
      ),
    );
  }
}

class _FamilyLoadCard extends StatelessWidget {
  const _FamilyLoadCard({required this.members, required this.load, required this.myUserId});
  final List<FamilyMemberInfo> members;
  final Map<int, int> load;
  final int? myUserId;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final maxLoad = load.values.fold(0, (m, v) => v > m ? v : m);
    if (maxLoad == 0) return const SizedBox.shrink();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: members.where((m) => load.containsKey(m.userId)).map((m) {
            final count = load[m.userId] ?? 0;
            final ratio = maxLoad > 0 ? count / maxLoad : 0.0;
            final isMe = m.userId == myUserId;
            final barColor = isMe ? scheme.primary : scheme.primary.withValues(alpha: 0.45);

            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: 32,
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: isMe
                          ? scheme.primary.withValues(alpha: 0.15)
                          : scheme.outline.withValues(alpha: 0.12),
                      child: Text(
                        m.displayName[0].toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isMe ? scheme.primary : null,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              isMe ? '${m.displayName} (io)' : m.displayName,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: isMe ? FontWeight.w600 : FontWeight.normal,
                              ),
                            ),
                            const Spacer(),
                            Text('$count task', style: TextStyle(fontSize: 12, color: scheme.onSurface.withValues(alpha: 0.55))),
                          ],
                        ),
                        const SizedBox(height: 4),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: ratio,
                            minHeight: 6,
                            backgroundColor: scheme.outline.withValues(alpha: 0.15),
                            valueColor: AlwaysStoppedAnimation(barColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _ShoppingPreviewCard extends StatelessWidget {
  const _ShoppingPreviewCard({required this.lists, required this.totalUnchecked, required this.onTap});
  final List<ShoppingList> lists;
  final int totalUnchecked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    if (lists.isEmpty || totalUnchecked == 0) {
      return _EmptyCard(Icons.shopping_cart_outlined, 'Lista spesa vuota', Colors.green.shade500);
    }
    final theme = Theme.of(context);
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.green.withValues(alpha: 0.12),
                child: Icon(Icons.shopping_cart_outlined, color: Colors.green.shade600),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$totalUnchecked articoli da comprare',
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                    Text(lists.map((l) => l.name).join(', '),
                        style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurface.withValues(alpha: 0.55)),
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: theme.colorScheme.onSurface.withValues(alpha: 0.3)),
            ],
          ),
        ),
      ),
    );
  }
}

class _BoardPreviewCard extends StatelessWidget {
  const _BoardPreviewCard({required this.post, required this.onTap});
  final BoardPostWithPoll post;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.teal.withValues(alpha: 0.12),
                child: Icon(Icons.forum_outlined, color: Colors.teal.shade600),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(post.post.content, maxLines: 2, overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14)),
              ),
              Icon(Icons.chevron_right, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3)),
            ],
          ),
        ),
      ),
    );
  }
}
