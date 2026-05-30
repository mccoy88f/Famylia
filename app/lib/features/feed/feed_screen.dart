import 'package:famylia_client/famylia_client.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

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

  List<TodoItem> _myUrgentTodos = [];
  List<TodoItem> _myTodayTodos = [];
  List<Deadline> _urgentDeadlines = [];
  List<Deadline> _upcomingDeadlines = [];
  int _totalUnchecked = 0;
  List<ShoppingList> _shoppingLists = [];
  BoardPostWithPoll? _latestPost;
  List<FamilyMemberInfo> _members = [];
  Map<int, int> _memberLoad = {};
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

      final myTodos = allTodos.where((t) =>
          t.status != TodoStatus.done &&
          (t.assignedTo == me || t.assignedTo == null)).toList();

      final myUrgent = myTodos.where((t) =>
          t.dueDate != null && t.dueDate!.isBefore(tomorrow)).toList();

      final myToday = myTodos.where((t) =>
          t.dueDate == null || !t.dueDate!.isBefore(tomorrow)).take(6).toList();

      final urgentDeadlines = allDeadlines.where((d) {
        if (d.status == DeadlineStatus.paid || d.status == DeadlineStatus.cancelled) return false;
        return d.status == DeadlineStatus.overdue || d.dueDate.isBefore(tomorrow);
      }).toList();

      final upcomingDeadlines = allDeadlines.where((d) {
        if (d.status == DeadlineStatus.paid || d.status == DeadlineStatus.cancelled) return false;
        if (d.status == DeadlineStatus.overdue) return false;
        return !d.dueDate.isBefore(tomorrow) && d.dueDate.isBefore(in7);
      }).toList();

      final load = <int, int>{};
      for (final t in allTodos.where((t) => t.status != TodoStatus.done)) {
        if (t.assignedTo != null) {
          load[t.assignedTo!] = (load[t.assignedTo!] ?? 0) + 1;
        }
      }

      var unchecked = 0;
      for (final l in lists) {
        if (l.id == null) continue;
        try {
          final detail = await _shopping.getList(l.id!);
          unchecked += detail.items.where((i) => !i.isChecked).length;
        } catch (_) {}
      }

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
    final shadTheme = ShadTheme.of(context);
    final hasUrgencies = _myUrgentTodos.isNotEmpty || _urgentDeadlines.isNotEmpty;

    return Scaffold(
      backgroundColor: shadTheme.colorScheme.background,
      body: RefreshIndicator(
        onRefresh: _load,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: shadTheme.colorScheme.background,
              surfaceTintColor: Colors.transparent,
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
                              style: shadTheme.textTheme.h4,
                            ),
                            if (_myFamilies.length > 1) ...[
                              const SizedBox(width: 4),
                              Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: shadTheme.colorScheme.primary),
                            ],
                          ],
                        ),
                        Text(
                          'Ciao, ${appState.userName ?? 'famiglia'} 👋',
                          style: shadTheme.textTheme.muted,
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
                    child: Icon(Icons.cloud_off, size: 18, color: shadTheme.colorScheme.mutedForeground),
                  ),
                ShadButton.ghost(
                  onPressed: () => _showSettings(context, family),
                  size: ShadButtonSize.icon,
                  child: const Icon(Icons.settings_outlined, size: 20),
                ),
                const SizedBox(width: 4),
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
                      _FeedSection(
                        icon: Icons.warning_amber_rounded,
                        label: 'Urgente',
                        color: shadTheme.colorScheme.destructive,
                      ),
                      const SizedBox(height: 8),
                      ..._urgentDeadlines.map((d) => _UrgentDeadlineCard(
                            deadline: d,
                            dateFmt: _dateFmt,
                            onPay: () async { await _deadlines.complete(d.id!); _load(); },
                            shadTheme: shadTheme,
                          )),
                      ..._myUrgentTodos.map((t) => _UrgentTodoCard(
                            todo: t,
                            dateFmt: _dateFmt,
                            onDone: () async { await _todos.complete(t.id!); _load(); },
                            shadTheme: shadTheme,
                          )),
                      const SizedBox(height: 20),
                    ],

                    // ── Le mie attività ──
                    _FeedSection(
                      icon: Icons.task_alt_outlined,
                      label: 'Le mie attività',
                      color: shadTheme.colorScheme.primary,
                      action: ShadButton.ghost(
                        onPressed: () => context.go(AppRoutes.lista),
                        child: const Text('Tutte'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (_myTodayTodos.isEmpty)
                      _EmptyCard(
                        Icons.check_circle_outline,
                        'Nessun task assegnato',
                        shadTheme,
                      )
                    else
                      _MyTodosCard(
                        todos: _myTodayTodos,
                        onToggle: (t) async { await _todos.complete(t.id!); _load(); },
                        onTapAll: () => context.go(AppRoutes.lista),
                        shadTheme: shadTheme,
                      ),
                    const SizedBox(height: 20),

                    // ── Carico famiglia ──
                    if (_members.isNotEmpty && _memberLoad.isNotEmpty) ...[
                      _FeedSection(
                        icon: Icons.bar_chart_outlined,
                        label: 'Carico famiglia',
                        color: const Color(0xFF6366F1),
                      ),
                      const SizedBox(height: 8),
                      _FamilyLoadCard(members: _members, load: _memberLoad, myUserId: _myUserId, shadTheme: shadTheme),
                      const SizedBox(height: 20),
                    ],

                    // ── Da comprare ──
                    _FeedSection(
                      icon: Icons.shopping_cart_outlined,
                      label: 'Da comprare',
                      color: const Color(0xFF10B981),
                      action: ShadButton.ghost(
                        onPressed: () => context.go(AppRoutes.lista, extra: 'shopping'),
                        child: const Text('Apri'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _ShoppingPreviewCard(
                      lists: _shoppingLists,
                      totalUnchecked: _totalUnchecked,
                      onTap: () => context.go(AppRoutes.lista, extra: 'shopping'),
                      shadTheme: shadTheme,
                    ),

                    // ── In scadenza 7 giorni ──
                    if (_upcomingDeadlines.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      _FeedSection(
                        icon: Icons.alarm_outlined,
                        label: 'In scadenza (7 giorni)',
                        color: const Color(0xFFF59E0B),
                        action: ShadButton.ghost(
                          onPressed: () => context.go(AppRoutes.agenda),
                          child: const Text('Tutte'),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ShadCard(
                        padding: EdgeInsets.zero,
                        child: Column(
                          children: _upcomingDeadlines.take(3).indexed.map((record) {
                            final i = record.$1;
                            final d = record.$2;
                            return Column(
                              children: [
                                if (i > 0) Divider(height: 1, color: shadTheme.colorScheme.border),
                                ListTile(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                  leading: CircleAvatar(
                                    radius: 18,
                                    backgroundColor: const Color(0xFFF59E0B).withValues(alpha: 0.12),
                                    child: const Icon(Icons.alarm, color: Color(0xFFF59E0B), size: 16),
                                  ),
                                  title: Text(d.title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                                  subtitle: Text(_dateFmt.format(d.dueDate), style: TextStyle(fontSize: 12, color: shadTheme.colorScheme.mutedForeground)),
                                  trailing: d.amount != null
                                      ? Text('€${d.amount!.toStringAsFixed(0)}',
                                          style: const TextStyle(fontWeight: FontWeight.bold))
                                      : null,
                                  onTap: () => context.go(AppRoutes.agenda),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ],

                    // ── Bacheca ──
                    if (_latestPost != null) ...[
                      const SizedBox(height: 20),
                      _FeedSection(
                        icon: Icons.forum_outlined,
                        label: 'Bacheca',
                        color: const Color(0xFF14B8A6),
                        action: ShadButton.ghost(
                          onPressed: () => context.push(AppRoutes.board),
                          child: const Text('Apri'),
                        ),
                      ),
                      const SizedBox(height: 8),
                      _BoardPreviewCard(post: _latestPost!, onTap: () => context.push(AppRoutes.board), shadTheme: shadTheme),
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
    final shadTheme = ShadTheme.of(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: shadTheme.colorScheme.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: Text('Le tue famiglie', style: shadTheme.textTheme.h4),
            ),
            Divider(height: 1, color: shadTheme.colorScheme.border),
            for (final fw in _myFamilies)
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: fw.family.id == family.activeFamilyId
                      ? shadTheme.colorScheme.primary.withValues(alpha: 0.15)
                      : shadTheme.colorScheme.muted,
                  child: Text(
                    fw.family.name[0].toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: fw.family.id == family.activeFamilyId
                          ? shadTheme.colorScheme.primary
                          : shadTheme.colorScheme.mutedForeground,
                    ),
                  ),
                ),
                title: Text(fw.family.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text(_roleLabel(fw.role), style: TextStyle(fontSize: 12, color: shadTheme.colorScheme.mutedForeground)),
                trailing: fw.family.id == family.activeFamilyId
                    ? Icon(Icons.check_circle, color: shadTheme.colorScheme.primary)
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
    final shadTheme = ShadTheme.of(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: shadTheme.colorScheme.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
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
            Divider(height: 1, color: shadTheme.colorScheme.border),
            ListTile(
              leading: Icon(Icons.logout, color: shadTheme.colorScheme.destructive),
              title: Text('Esci', style: TextStyle(color: shadTheme.colorScheme.destructive)),
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

// ── Section header ────────────────────────────────────────────────────────

class _FeedSection extends StatelessWidget {
  const _FeedSection({required this.icon, required this.label, required this.color, this.action});
  final IconData icon;
  final String label;
  final Color color;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 15, color: color),
        const SizedBox(width: 6),
        Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: color)),
        const Spacer(),
        if (action != null) action!,
      ],
    );
  }
}

// ── Cards ─────────────────────────────────────────────────────────────────

class _EmptyCard extends StatelessWidget {
  const _EmptyCard(this.icon, this.label, this.shadTheme);
  final IconData icon;
  final String label;
  final ShadThemeData shadTheme;

  @override
  Widget build(BuildContext context) {
    return ShadCard(
      child: Row(
        children: [
          Icon(icon, color: shadTheme.colorScheme.mutedForeground, size: 20),
          const SizedBox(width: 10),
          Text(label, style: shadTheme.textTheme.muted),
        ],
      ),
    );
  }
}

class _UrgentDeadlineCard extends StatelessWidget {
  const _UrgentDeadlineCard({required this.deadline, required this.dateFmt, required this.onPay, required this.shadTheme});
  final Deadline deadline;
  final DateFormat dateFmt;
  final VoidCallback onPay;
  final ShadThemeData shadTheme;

  @override
  Widget build(BuildContext context) {
    final red = shadTheme.colorScheme.destructive;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: ShadCard(
        backgroundColor: red.withValues(alpha: 0.05),
        border: Border.all(color: red.withValues(alpha: 0.25)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            CircleAvatar(radius: 16, backgroundColor: red.withValues(alpha: 0.12),
                child: Icon(Icons.alarm, color: red, size: 16)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(deadline.title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  Text(
                    deadline.status == DeadlineStatus.overdue
                        ? 'Scaduta il ${dateFmt.format(deadline.dueDate)}'
                        : 'Scade oggi',
                    style: TextStyle(color: red, fontSize: 12),
                  ),
                ],
              ),
            ),
            if (deadline.amount != null)
              Text('€${deadline.amount!.toStringAsFixed(0)}',
                  style: TextStyle(fontWeight: FontWeight.bold, color: red)),
            ShadButton.ghost(
              onPressed: onPay,
              size: ShadButtonSize.icon,
              child: Icon(Icons.check_circle_outline, color: red, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class _UrgentTodoCard extends StatelessWidget {
  const _UrgentTodoCard({required this.todo, required this.dateFmt, required this.onDone, required this.shadTheme});
  final TodoItem todo;
  final DateFormat dateFmt;
  final VoidCallback onDone;
  final ShadThemeData shadTheme;

  @override
  Widget build(BuildContext context) {
    final red = shadTheme.colorScheme.destructive;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: ShadCard(
        backgroundColor: red.withValues(alpha: 0.03),
        border: Border.all(color: red.withValues(alpha: 0.15)),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Row(
          children: [
            Checkbox(value: false, onChanged: (_) => onDone(), shape: const CircleBorder()),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(todo.title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                  if (todo.dueDate != null)
                    Text('Scaduto il ${dateFmt.format(todo.dueDate!)}',
                        style: TextStyle(color: red, fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MyTodosCard extends StatelessWidget {
  const _MyTodosCard({required this.todos, required this.onToggle, required this.onTapAll, required this.shadTheme});
  final List<TodoItem> todos;
  final void Function(TodoItem) onToggle;
  final VoidCallback onTapAll;
  final ShadThemeData shadTheme;

  Color _priorityColor(TodoPriority p) => switch (p) {
        TodoPriority.critical => const Color(0xFFEF4444),
        TodoPriority.high => const Color(0xFFF59E0B),
        TodoPriority.medium => const Color(0xFF3B82F6),
        _ => const Color(0xFF9CA3AF),
      };

  @override
  Widget build(BuildContext context) {
    return ShadCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          ...todos.take(5).indexed.map((record) {
            final i = record.$1;
            final t = record.$2;
            return Column(
              children: [
                if (i > 0) Divider(height: 1, color: shadTheme.colorScheme.border),
                CheckboxListTile(
                  value: t.status == TodoStatus.done,
                  onChanged: (_) => onToggle(t),
                  shape: const CircleBorder(),
                  controlAffinity: ListTileControlAffinity.leading,
                  dense: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  title: Row(
                    children: [
                      Expanded(child: Text(t.title, style: const TextStyle(fontSize: 14))),
                      Container(
                        width: 7, height: 7,
                        margin: const EdgeInsets.only(right: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _priorityColor(t.priority),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
          if (todos.length > 5)
            ShadButton.ghost(
              onPressed: onTapAll,
              width: double.infinity,
              child: Text('+${todos.length - 5} altri task', style: TextStyle(color: shadTheme.colorScheme.mutedForeground)),
            ),
        ],
      ),
    );
  }
}

class _FamilyLoadCard extends StatelessWidget {
  const _FamilyLoadCard({required this.members, required this.load, required this.myUserId, required this.shadTheme});
  final List<FamilyMemberInfo> members;
  final Map<int, int> load;
  final int? myUserId;
  final ShadThemeData shadTheme;

  @override
  Widget build(BuildContext context) {
    final maxLoad = load.values.fold(0, (m, v) => v > m ? v : m);
    if (maxLoad == 0) return const SizedBox.shrink();

    return ShadCard(
      child: Column(
        children: members.where((m) => load.containsKey(m.userId)).map((m) {
          final count = load[m.userId] ?? 0;
          final ratio = maxLoad > 0 ? count / maxLoad : 0.0;
          final isMe = m.userId == myUserId;
          final barColor = isMe ? shadTheme.colorScheme.primary : shadTheme.colorScheme.primary.withValues(alpha: 0.4);

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: isMe
                      ? shadTheme.colorScheme.primary.withValues(alpha: 0.15)
                      : shadTheme.colorScheme.muted,
                  child: Text(
                    m.displayName[0].toUpperCase(),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: isMe ? shadTheme.colorScheme.primary : shadTheme.colorScheme.mutedForeground,
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
                          Text('$count task', style: shadTheme.textTheme.muted.copyWith(fontSize: 12)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: ratio,
                          minHeight: 5,
                          backgroundColor: shadTheme.colorScheme.muted,
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
    );
  }
}

class _ShoppingPreviewCard extends StatelessWidget {
  const _ShoppingPreviewCard({required this.lists, required this.totalUnchecked, required this.onTap, required this.shadTheme});
  final List<ShoppingList> lists;
  final int totalUnchecked;
  final VoidCallback onTap;
  final ShadThemeData shadTheme;

  @override
  Widget build(BuildContext context) {
    if (lists.isEmpty || totalUnchecked == 0) {
      return _EmptyCard(Icons.shopping_cart_outlined, 'Lista spesa vuota', shadTheme);
    }
    return ShadCard(
      padding: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.12),
                child: const Icon(Icons.shopping_cart_outlined, color: Color(0xFF10B981)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$totalUnchecked articoli da comprare',
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                    Text(lists.map((l) => l.name).join(', '),
                        style: shadTheme.textTheme.muted,
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: shadTheme.colorScheme.mutedForeground),
            ],
          ),
        ),
      ),
    );
  }
}

class _BoardPreviewCard extends StatelessWidget {
  const _BoardPreviewCard({required this.post, required this.onTap, required this.shadTheme});
  final BoardPostWithPoll post;
  final VoidCallback onTap;
  final ShadThemeData shadTheme;

  @override
  Widget build(BuildContext context) {
    return ShadCard(
      padding: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xFF14B8A6).withValues(alpha: 0.12),
                child: const Icon(Icons.forum_outlined, color: Color(0xFF14B8A6)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(post.post.content, maxLines: 2, overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14)),
              ),
              Icon(Icons.chevron_right, color: shadTheme.colorScheme.mutedForeground),
            ],
          ),
        ),
      ),
    );
  }
}
