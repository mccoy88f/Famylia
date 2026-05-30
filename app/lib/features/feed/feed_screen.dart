import 'package:famylia_client/famylia_client.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../core/api/auth_repository.dart';
import '../../core/api/board_repository.dart';
import '../../core/api/deadline_repository.dart';
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

  List<TodoItem> _urgentTodos = [];
  List<TodoItem> _todayTodos = [];
  List<Deadline> _urgentDeadlines = [];
  List<Deadline> _upcomingDeadlines = [];
  List<ShoppingList> _shoppingLists = [];
  int _totalUnchecked = 0;
  BoardPostWithPoll? _latestPost;
  bool _loading = true;
  bool _offline = false;

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
      _offline = !await _shopping.isOnline;
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final tomorrow = today.add(const Duration(days: 1));
      final in7 = today.add(const Duration(days: 7));

      final allTodos = await _todos.list(familyId);
      final openTodos = allTodos.where((t) => t.status != TodoStatus.done).toList();

      final urgentTodos = openTodos.where((t) {
        if (t.dueDate == null) return false;
        return t.dueDate!.isBefore(tomorrow);
      }).toList();

      final todayTodos = openTodos.where((t) {
        if (t.dueDate == null) return true;
        return !t.dueDate!.isBefore(tomorrow);
      }).take(5).toList();

      final allDeadlines = await _deadlines.list(familyId);
      final urgentDeadlines = allDeadlines.where((d) {
        if (d.status == DeadlineStatus.paid || d.status == DeadlineStatus.cancelled) return false;
        if (d.status == DeadlineStatus.overdue) return true;
        return d.dueDate.isBefore(tomorrow);
      }).toList();

      final upcoming = allDeadlines.where((d) {
        if (d.status == DeadlineStatus.paid || d.status == DeadlineStatus.cancelled) return false;
        if (d.status == DeadlineStatus.overdue) return false;
        return !d.dueDate.isBefore(tomorrow) && d.dueDate.isBefore(in7);
      }).toList();

      final lists = await _shopping.listLists(familyId);
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
        final posts = await _board.watch(familyId).first;
        if (posts.isNotEmpty) latestPost = posts.first;
      } catch (_) {}

      if (mounted) {
        setState(() {
          _urgentTodos = urgentTodos;
          _todayTodos = todayTodos;
          _urgentDeadlines = urgentDeadlines;
          _upcomingDeadlines = upcoming;
          _shoppingLists = lists;
          _totalUnchecked = unchecked;
          _latestPost = latestPost;
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
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final hasUrgencies = _urgentTodos.isNotEmpty || _urgentDeadlines.isNotEmpty;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _load,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    family.activeFamilyName ?? 'Famylia',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: scheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                  Text(
                    'Ciao, ${appState.userName ?? 'famiglia'} 👋',
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              centerTitle: false,
              actions: [
                if (_offline)
                  const Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: Icon(Icons.cloud_off, size: 18),
                  ),
                IconButton(
                  icon: const Icon(Icons.settings_outlined),
                  onPressed: () => _showSettings(context, family),
                ),
              ],
            ),
            if (_loading)
              const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    if (hasUrgencies) ...[
                      _SectionHeader(
                        icon: Icons.warning_amber_rounded,
                        label: 'Urgente',
                        color: scheme.error,
                      ),
                      const SizedBox(height: 8),
                      ..._urgentDeadlines.map((d) => _UrgentDeadlineCard(
                            deadline: d,
                            dateFmt: _dateFmt,
                            onPay: () async {
                              await _deadlines.complete(d.id!);
                              _load();
                            },
                          )),
                      ..._urgentTodos.map((t) => _UrgentTodoCard(
                            todo: t,
                            dateFmt: _dateFmt,
                            onDone: () async {
                              await _todos.complete(t.id!);
                              _load();
                            },
                          )),
                      const SizedBox(height: 20),
                    ],
                    _SectionHeader(
                      icon: Icons.wb_sunny_outlined,
                      label: 'Da fare oggi',
                      color: scheme.primary,
                      action: TextButton(
                        onPressed: () => context.go(AppRoutes.lista),
                        child: const Text('Vedi tutti'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (_todayTodos.isEmpty)
                      _EmptyCard(
                        icon: Icons.check_circle_outline,
                        label: 'Nessun task aperto',
                        color: scheme.primary,
                      )
                    else
                      _TodoPreviewCard(
                        todos: _todayTodos,
                        onToggle: (t) async {
                          await _todos.complete(t.id!);
                          _load();
                        },
                        onTapAll: () => context.go(AppRoutes.lista),
                      ),
                    const SizedBox(height: 20),
                    _SectionHeader(
                      icon: Icons.shopping_cart_outlined,
                      label: 'Da comprare',
                      color: Colors.green.shade500,
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
                    if (_upcomingDeadlines.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      _SectionHeader(
                        icon: Icons.alarm_outlined,
                        label: 'In scadenza (7 giorni)',
                        color: Colors.orange.shade600,
                        action: TextButton(
                          onPressed: () => context.go(AppRoutes.agenda),
                          child: const Text('Tutte'),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Card(
                        child: Column(
                          children: [
                            for (final d in _upcomingDeadlines.take(3))
                              ListTile(
                                leading: CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Colors.orange.withValues(alpha: 0.15),
                                  child: Icon(Icons.alarm, color: Colors.orange.shade700, size: 18),
                                ),
                                title: Text(d.title),
                                subtitle: Text(_dateFmt.format(d.dueDate)),
                                trailing: d.amount != null
                                    ? Text(
                                        '€${d.amount!.toStringAsFixed(2)}',
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      )
                                    : null,
                                onTap: () => context.go(AppRoutes.agenda),
                              ),
                          ],
                        ),
                      ),
                    ],
                    if (_latestPost != null) ...[
                      const SizedBox(height: 20),
                      _SectionHeader(
                        icon: Icons.forum_outlined,
                        label: 'Bacheca',
                        color: Colors.teal.shade500,
                        action: TextButton(
                          onPressed: () => context.push(AppRoutes.board),
                          child: const Text('Apri'),
                        ),
                      ),
                      const SizedBox(height: 8),
                      _BoardPreviewCard(
                        post: _latestPost!,
                        onTap: () => context.push(AppRoutes.board),
                      ),
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
              onTap: () {
                Navigator.pop(ctx);
                context.push(AppRoutes.appearance);
              },
            ),
            ListTile(
              leading: const Icon(Icons.shield_outlined),
              title: const Text('Privacy'),
              onTap: () {
                Navigator.pop(ctx);
                context.push(AppRoutes.privacy);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Esci'),
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

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.icon,
    required this.label,
    required this.color,
    this.action,
  });

  final IconData icon;
  final String label;
  final Color color;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 6),
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
        ),
        const Spacer(),
        if (action != null) action!,
      ],
    );
  }
}

class _EmptyCard extends StatelessWidget {
  const _EmptyCard({required this.icon, required this.label, required this.color});
  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Row(
          children: [
            Icon(icon, color: color.withValues(alpha: 0.5)),
            const SizedBox(width: 12),
            Text(label, style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5))),
          ],
        ),
      ),
    );
  }
}

class _UrgentDeadlineCard extends StatelessWidget {
  const _UrgentDeadlineCard({
    required this.deadline,
    required this.dateFmt,
    required this.onPay,
  });

  final Deadline deadline;
  final DateFormat dateFmt;
  final VoidCallback onPay;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isOverdue = deadline.status == DeadlineStatus.overdue;
    return Card(
      color: scheme.error.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: scheme.error.withValues(alpha: 0.3)),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: scheme.error.withValues(alpha: 0.15),
          child: Icon(Icons.alarm, color: scheme.error, size: 20),
        ),
        title: Text(deadline.title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(
          isOverdue ? 'Scaduta il ${dateFmt.format(deadline.dueDate)}' : 'Scade oggi',
          style: TextStyle(color: scheme.error),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (deadline.amount != null)
              Text(
                '€${deadline.amount!.toStringAsFixed(0)}',
                style: TextStyle(fontWeight: FontWeight.bold, color: scheme.error),
              ),
            const SizedBox(width: 8),
            IconButton(
              icon: Icon(Icons.check_circle_outline, color: scheme.error),
              tooltip: 'Segna pagata',
              onPressed: onPay,
            ),
          ],
        ),
      ),
    );
  }
}

class _UrgentTodoCard extends StatelessWidget {
  const _UrgentTodoCard({
    required this.todo,
    required this.dateFmt,
    required this.onDone,
  });

  final TodoItem todo;
  final DateFormat dateFmt;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      color: scheme.error.withValues(alpha: 0.06),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: scheme.error.withValues(alpha: 0.2)),
      ),
      child: ListTile(
        leading: Checkbox(
          value: false,
          onChanged: (_) => onDone(),
          activeColor: scheme.error,
        ),
        title: Text(todo.title, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: todo.dueDate != null
            ? Text('Scaduto il ${dateFmt.format(todo.dueDate!)}',
                style: TextStyle(color: scheme.error))
            : null,
      ),
    );
  }
}

class _TodoPreviewCard extends StatelessWidget {
  const _TodoPreviewCard({
    required this.todos,
    required this.onToggle,
    required this.onTapAll,
  });

  final List<TodoItem> todos;
  final void Function(TodoItem) onToggle;
  final VoidCallback onTapAll;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          for (final t in todos.take(4))
            CheckboxListTile(
              value: t.status == TodoStatus.done,
              onChanged: (_) => onToggle(t),
              title: Text(t.title),
              dense: true,
              controlAffinity: ListTileControlAffinity.leading,
            ),
          if (todos.length > 4)
            TextButton(
              onPressed: onTapAll,
              child: Text('+${todos.length - 4} altri task'),
            ),
        ],
      ),
    );
  }
}

class _ShoppingPreviewCard extends StatelessWidget {
  const _ShoppingPreviewCard({
    required this.lists,
    required this.totalUnchecked,
    required this.onTap,
  });

  final List<ShoppingList> lists;
  final int totalUnchecked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (lists.isEmpty || totalUnchecked == 0) {
      return _EmptyCard(
        icon: Icons.shopping_cart_outlined,
        label: 'Lista spesa vuota',
        color: Colors.green.shade500,
      );
    }
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.green.withValues(alpha: 0.15),
                child: Icon(Icons.shopping_cart_outlined, color: Colors.green.shade600),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$totalUnchecked articoli da comprare',
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      lists.map((l) => l.name).join(', '),
                      style: theme.textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
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
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.teal.withValues(alpha: 0.15),
                child: Icon(Icons.forum_outlined, color: Colors.teal.shade600),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  post.post.content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
