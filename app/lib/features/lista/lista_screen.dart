import 'package:famylia_client/famylia_client.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/api/family_repository.dart';
import '../../core/api/shopping_repository.dart';
import '../../core/api/todo_repository.dart';
import '../../core/extensions/context_extensions.dart';
import '../../core/router/app_router.dart';
import '../../core/session/app_state.dart';

class ListaScreen extends StatefulWidget {
  const ListaScreen({this.initialTab = 0, super.key});

  final int initialTab;

  @override
  State<ListaScreen> createState() => _ListaScreenState();
}

class _ListaScreenState extends State<ListaScreen> with SingleTickerProviderStateMixin {
  late TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this, initialIndex: widget.initialTab);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista'),
        bottom: TabBar(
          controller: _tab,
          tabs: const [
            Tab(icon: Icon(Icons.check_circle_outline), text: 'Todo'),
            Tab(icon: Icon(Icons.shopping_cart_outlined), text: 'Spesa'),
          ],
          indicatorColor: scheme.primary,
          labelColor: scheme.primary,
          unselectedLabelColor: scheme.onSurface.withValues(alpha: 0.6),
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: const [
          _TodoTab(),
          _SpesaTab(),
        ],
      ),
    );
  }
}

// ── Todo tab ──────────────────────────────────────────────────────────────

class _TodoTab extends StatefulWidget {
  const _TodoTab();

  @override
  State<_TodoTab> createState() => _TodoTabState();
}

class _TodoTabState extends State<_TodoTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final _repo = TodoRepository();
  final _families = FamilyRepository();
  final _addCtrl = TextEditingController();
  List<TodoItem> _items = [];
  bool _loading = true;
  bool _myDayOnly = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  @override
  void dispose() {
    _addCtrl.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final familyId = context.activeFamilyId;
    if (familyId == null) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final items = _myDayOnly ? await _repo.myDay(familyId) : await _repo.list(familyId);
      if (mounted) setState(() => _items = items);
    } catch (e) {
      if (mounted) setState(() => _error = _repo.errorMessage(e));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _quickAdd(String title) async {
    final familyId = context.activeFamilyId;
    if (familyId == null || title.trim().isEmpty) return;
    _addCtrl.clear();
    try {
      await _repo.create(familyId, title.trim());
      await _load();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_repo.errorMessage(e))),
        );
      }
    }
  }

  Future<void> _toggleDone(TodoItem item) async {
    if (item.id == null || item.status == TodoStatus.done) return;
    try {
      await _repo.complete(item.id!);
      await _load();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_repo.errorMessage(e))),
        );
      }
    }
  }

  Future<void> _assign(TodoItem item) async {
    final familyId = context.activeFamilyId;
    if (familyId == null || item.id == null) return;
    try {
      final members = await _families.listMembers(familyId);
      if (!mounted) return;
      final me = context.read<AppState>().signedInUser?.id;
      final choice = await showModalBottomSheet<int?>(
        context: context,
        builder: (ctx) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text('Assegna a', style: Theme.of(ctx).textTheme.titleMedium),
              ),
              ListTile(
                leading: const Icon(Icons.person_off_outlined),
                title: const Text('Nessuno'),
                onTap: () => Navigator.pop(ctx, -1),
              ),
              for (final m in members)
                ListTile(
                  leading: CircleAvatar(child: Text(m.displayName[0].toUpperCase())),
                  title: Text(m.userId == me ? '${m.displayName} (io)' : m.displayName),
                  subtitle: Text(m.role.name),
                  onTap: () => Navigator.pop(ctx, m.userId),
                ),
            ],
          ),
        ),
      );
      if (choice == null) return;
      await _repo.assign(item.id!, choice < 0 ? null : choice);
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
    super.build(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final width = MediaQuery.of(context).size.width;
    final isWide = width >= 900;

    final open = _items.where((t) => t.status != TodoStatus.done).toList();
    final done = _items.where((t) => t.status == TodoStatus.done).toList();

    return Column(
      children: [
        _QuickAddBar(
          controller: _addCtrl,
          hintText: 'Aggiungi task veloce...',
          onSubmit: _quickAdd,
          trailing: FilterChip(
            label: const Text('Oggi'),
            selected: _myDayOnly,
            onSelected: (v) {
              setState(() => _myDayOnly = v);
              _load();
            },
          ),
        ),
        Expanded(
          child: _loading
              ? const Center(child: CircularProgressIndicator())
              : _error != null
                  ? Center(child: Text(_error!))
                  : RefreshIndicator(
                      onRefresh: _load,
                      child: isWide
                          ? _TodoWideLayout(
                              open: open,
                              done: done,
                              onToggle: _toggleDone,
                              onAssign: _assign,
                              onDelete: (t) async {
                                await _repo.delete(t.id!);
                                await _load();
                              },
                            )
                          : _TodoNarrowLayout(
                              open: open,
                              done: done,
                              onToggle: _toggleDone,
                              onAssign: _assign,
                              onDelete: (t) async {
                                await _repo.delete(t.id!);
                                await _load();
                              },
                            ),
                    ),
        ),
      ],
    );
  }
}

class _TodoNarrowLayout extends StatelessWidget {
  const _TodoNarrowLayout({
    required this.open,
    required this.done,
    required this.onToggle,
    required this.onAssign,
    required this.onDelete,
  });

  final List<TodoItem> open;
  final List<TodoItem> done;
  final void Function(TodoItem) onToggle;
  final void Function(TodoItem) onAssign;
  final void Function(TodoItem) onDelete;

  @override
  Widget build(BuildContext context) {
    if (open.isEmpty && done.isEmpty) {
      return const Center(child: Text('Nessun task. Aggiungine uno!'));
    }
    return ListView(
      padding: const EdgeInsets.only(bottom: 100),
      children: [
        if (open.isNotEmpty) ...[
          _ListSectionLabel('Da fare · ${open.length}'),
          for (final t in open)
            _TodoTile(item: t, onToggle: onToggle, onAssign: onAssign, onDelete: onDelete),
        ],
        if (done.isNotEmpty) ...[
          _ListSectionLabel('Completati · ${done.length}'),
          for (final t in done)
            _TodoTile(item: t, onToggle: onToggle, onAssign: onAssign, onDelete: onDelete),
        ],
      ],
    );
  }
}

class _TodoWideLayout extends StatelessWidget {
  const _TodoWideLayout({
    required this.open,
    required this.done,
    required this.onToggle,
    required this.onAssign,
    required this.onDelete,
  });

  final List<TodoItem> open;
  final List<TodoItem> done;
  final void Function(TodoItem) onToggle;
  final void Function(TodoItem) onAssign;
  final void Function(TodoItem) onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _ListSectionLabel('Da fare · ${open.length}'),
              for (final t in open)
                _TodoTile(item: t, onToggle: onToggle, onAssign: onAssign, onDelete: onDelete),
            ],
          ),
        ),
        const VerticalDivider(width: 1),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _ListSectionLabel('Completati · ${done.length}'),
              for (final t in done)
                _TodoTile(item: t, onToggle: onToggle, onAssign: onAssign, onDelete: onDelete),
            ],
          ),
        ),
      ],
    );
  }
}

class _TodoTile extends StatelessWidget {
  const _TodoTile({
    required this.item,
    required this.onToggle,
    required this.onAssign,
    required this.onDelete,
  });

  final TodoItem item;
  final void Function(TodoItem) onToggle;
  final void Function(TodoItem) onAssign;
  final void Function(TodoItem) onDelete;

  @override
  Widget build(BuildContext context) {
    final done = item.status == TodoStatus.done;
    return Dismissible(
      key: ValueKey(item.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red.shade300,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      confirmDismiss: (_) async {
        if (item.id == null) return false;
        onDelete(item);
        return true;
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: InkWell(
          onLongPress: () => onAssign(item),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: CheckboxListTile(
              value: done,
              onChanged: (_) => onToggle(item),
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(
                item.title,
                style: TextStyle(
                  decoration: done ? TextDecoration.lineThrough : null,
                  color: done ? Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5) : null,
                ),
              ),
              subtitle: item.dueDate != null
                  ? Text(
                      'Scade ${item.dueDate!.day}/${item.dueDate!.month}',
                      style: TextStyle(
                        color: item.dueDate!.isBefore(DateTime.now()) && !done
                            ? Theme.of(context).colorScheme.error
                            : null,
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}

// ── Spesa tab ─────────────────────────────────────────────────────────────

class _SpesaTab extends StatefulWidget {
  const _SpesaTab();

  @override
  State<_SpesaTab> createState() => _SpesaTabState();
}

class _SpesaTabState extends State<_SpesaTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final _repo = ShoppingRepository();
  List<ShoppingList> _lists = [];
  bool _loading = true;
  bool _offline = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    final familyId = context.activeFamilyId;
    if (familyId == null) return;
    setState(() => _loading = true);
    _offline = !await _repo.isOnline;
    try {
      final lists = await _repo.listLists(familyId);
      if (mounted) setState(() => _lists = lists);
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

  Future<void> _createList(String name) async {
    final familyId = context.activeFamilyId;
    if (familyId == null || name.trim().isEmpty) return;
    try {
      final list = await _repo.createList(familyId, name.trim());
      if (mounted && list.id != null) {
        context.push(AppRoutes.shoppingList(list.id!));
      }
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
    super.build(context);
    return Column(
      children: [
        if (_offline)
          Container(
            width: double.infinity,
            color: Colors.orange.shade100,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Icon(Icons.cloud_off, size: 16, color: Colors.orange.shade800),
                const SizedBox(width: 8),
                Text('Offline — modifiche salvate localmente',
                    style: TextStyle(color: Colors.orange.shade900, fontSize: 12)),
              ],
            ),
          ),
        _QuickAddBar(
          hintText: 'Nuova lista (es. Spesa settimanale)...',
          onSubmit: _createList,
        ),
        Expanded(
          child: _loading
              ? const Center(child: CircularProgressIndicator())
              : _lists.isEmpty
                  ? const Center(child: Text('Nessuna lista. Creane una!'))
                  : RefreshIndicator(
                      onRefresh: _load,
                      child: _ShoppingListsGrid(
                        lists: _lists,
                        onTap: (l) {
                          if (l.id != null) context.push(AppRoutes.shoppingList(l.id!));
                        },
                      ),
                    ),
        ),
      ],
    );
  }
}

class _ShoppingListsGrid extends StatelessWidget {
  const _ShoppingListsGrid({required this.lists, required this.onTap});
  final List<ShoppingList> lists;
  final void Function(ShoppingList) onTap;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final crossCount = width >= 900 ? 3 : (width >= 600 ? 2 : 1);

    if (crossCount == 1) {
      return ListView.builder(
        padding: const EdgeInsets.only(bottom: 100),
        itemCount: lists.length,
        itemBuilder: (_, i) => _ShoppingListTile(list: lists[i], onTap: onTap),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossCount,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 2.2,
      ),
      itemCount: lists.length,
      itemBuilder: (_, i) => _ShoppingListCard(list: lists[i], onTap: onTap),
    );
  }
}

class _ShoppingListTile extends StatelessWidget {
  const _ShoppingListTile({required this.list, required this.onTap});
  final ShoppingList list;
  final void Function(ShoppingList) onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green.withValues(alpha: 0.15),
          child: Icon(Icons.shopping_basket_outlined, color: Colors.green.shade600),
        ),
        title: Text(list.name, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: list.store != null ? Text(list.store!) : null,
        trailing: const Icon(Icons.chevron_right),
        onTap: () => onTap(list),
      ),
    );
  }
}

class _ShoppingListCard extends StatelessWidget {
  const _ShoppingListCard({required this.list, required this.onTap});
  final ShoppingList list;
  final void Function(ShoppingList) onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: InkWell(
        onTap: () => onTap(list),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.green.withValues(alpha: 0.15),
                child: Icon(Icons.shopping_basket_outlined, color: Colors.green.shade600),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(list.name, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                    if (list.store != null)
                      Text(list.store!, style: theme.textTheme.bodySmall),
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

// ── Shared components ─────────────────────────────────────────────────────

class _QuickAddBar extends StatelessWidget {
  const _QuickAddBar({
    required this.hintText,
    required this.onSubmit,
    this.controller,
    this.trailing,
  });

  final String hintText;
  final void Function(String) onSubmit;
  final TextEditingController? controller;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final ctrl = controller ?? TextEditingController();
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(bottom: BorderSide(color: scheme.outline.withValues(alpha: 0.2))),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: ctrl,
              decoration: InputDecoration(
                hintText: hintText,
                prefixIcon: const Icon(Icons.add, size: 20),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
              onSubmitted: onSubmit,
              textInputAction: TextInputAction.done,
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: 8),
            trailing!,
          ],
        ],
      ),
    );
  }
}

class _ListSectionLabel extends StatelessWidget {
  const _ListSectionLabel(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 16, 4),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
              letterSpacing: 0.5,
            ),
      ),
    );
  }
}
