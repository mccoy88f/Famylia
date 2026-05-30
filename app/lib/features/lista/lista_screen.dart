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
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attività'),
        bottom: TabBar(
          controller: _tab,
          tabs: const [
            Tab(icon: Icon(Icons.task_alt_outlined), text: 'Todo'),
            Tab(icon: Icon(Icons.shopping_cart_outlined), text: 'Spesa'),
          ],
          indicatorColor: scheme.primary,
          labelColor: scheme.primary,
          unselectedLabelColor: scheme.onSurface.withValues(alpha: 0.55),
          labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontSize: 13),
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
  // 0 = tutti, 1 = assegnati a me
  int _view = 0;

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
    setState(() => _loading = true);
    try {
      final items = _view == 1 ? await _repo.myDay(familyId) : await _repo.list(familyId);
      if (mounted) setState(() => _items = items);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_repo.errorMessage(e))));
      }
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_repo.errorMessage(e))));
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_repo.errorMessage(e))));
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
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Text('Assegna task a', style: Theme.of(ctx).textTheme.titleMedium),
              ),
              ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person_off_outlined, size: 18)),
                title: const Text('Nessuno'),
                onTap: () => Navigator.pop(ctx, -1),
              ),
              for (final m in members)
                ListTile(
                  leading: CircleAvatar(child: Text(m.displayName[0].toUpperCase())),
                  title: Text(m.userId == me ? '${m.displayName} (io)' : m.displayName),
                  subtitle: Text(m.role.name, style: const TextStyle(fontSize: 12)),
                  onTap: () => Navigator.pop(ctx, m.userId),
                ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      );
      if (choice == null) return;
      await _repo.assign(item.id!, choice < 0 ? null : choice);
      await _load();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_repo.errorMessage(e))));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final scheme = Theme.of(context).colorScheme;
    final isWide = MediaQuery.of(context).size.width >= 900;

    final open = _items.where((t) => t.status != TodoStatus.done).toList();
    final done = _items.where((t) => t.status == TodoStatus.done).toList();

    return Column(
      children: [
        // Barra aggiungi + filtro vista
        Container(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border(bottom: BorderSide(color: scheme.outline.withValues(alpha: 0.18))),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _addCtrl,
                  decoration: InputDecoration(
                    hintText: 'Nuovo task...',
                    prefixIcon: const Icon(Icons.add_task_outlined, size: 20),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send_rounded, size: 20, color: scheme.primary),
                      tooltip: 'Aggiungi',
                      onPressed: () => _quickAdd(_addCtrl.text),
                    ),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                  onSubmitted: _quickAdd,
                  textInputAction: TextInputAction.done,
                ),
              ),
              const SizedBox(width: 10),
              SegmentedButton<int>(
                segments: const [
                  ButtonSegment(value: 0, label: Text('Tutti', style: TextStyle(fontSize: 12))),
                  ButtonSegment(value: 1, icon: Icon(Icons.person_outline, size: 16), label: Text('Miei', style: TextStyle(fontSize: 12))),
                ],
                selected: {_view},
                onSelectionChanged: (v) {
                  setState(() => _view = v.first);
                  _load();
                },
                style: const ButtonStyle(
                  visualDensity: VisualDensity(horizontal: -2, vertical: -2),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: _loading
              ? const Center(child: CircularProgressIndicator())
              : (open.isEmpty && done.isEmpty)
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.task_alt_outlined, size: 48, color: scheme.onSurface.withValues(alpha: 0.2)),
                          const SizedBox(height: 12),
                          Text('Nessun task', style: TextStyle(color: scheme.onSurface.withValues(alpha: 0.5))),
                          const SizedBox(height: 8),
                          Text('Scrivilo sopra e premi invio',
                              style: TextStyle(fontSize: 12, color: scheme.onSurface.withValues(alpha: 0.35))),
                        ],
                      ),
                    )
                  : isWide
                      ? _TodoWide(open: open, done: done, onToggle: _toggleDone, onAssign: _assign,
                          onDelete: (t) async { await _repo.delete(t.id!); await _load(); })
                      : _TodoNarrow(open: open, done: done, onToggle: _toggleDone, onAssign: _assign,
                          onDelete: (t) async { await _repo.delete(t.id!); await _load(); }),
        ),
      ],
    );
  }
}

class _TodoNarrow extends StatelessWidget {
  const _TodoNarrow({required this.open, required this.done, required this.onToggle, required this.onAssign, required this.onDelete});
  final List<TodoItem> open;
  final List<TodoItem> done;
  final void Function(TodoItem) onToggle;
  final void Function(TodoItem) onAssign;
  final void Function(TodoItem) onDelete;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: ListView(
        padding: const EdgeInsets.only(bottom: 120),
        children: [
          if (open.isNotEmpty) ...[
            _SectionLabel('Da fare · ${open.length}'),
            for (final t in open) _TodoTile(item: t, onToggle: onToggle, onAssign: onAssign, onDelete: onDelete),
          ],
          if (done.isNotEmpty) ...[
            _SectionLabel('Completati · ${done.length}'),
            for (final t in done) _TodoTile(item: t, onToggle: onToggle, onAssign: onAssign, onDelete: onDelete),
          ],
        ],
      ),
    );
  }
}

class _TodoWide extends StatelessWidget {
  const _TodoWide({required this.open, required this.done, required this.onToggle, required this.onAssign, required this.onDelete});
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
            padding: const EdgeInsets.fromLTRB(0, 4, 0, 120),
            children: [
              _SectionLabel('Da fare · ${open.length}'),
              for (final t in open) _TodoTile(item: t, onToggle: onToggle, onAssign: onAssign, onDelete: onDelete),
            ],
          ),
        ),
        VerticalDivider(width: 1, color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3)),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(0, 4, 0, 120),
            children: [
              _SectionLabel('Completati · ${done.length}'),
              for (final t in done) _TodoTile(item: t, onToggle: onToggle, onAssign: onAssign, onDelete: onDelete),
            ],
          ),
        ),
      ],
    );
  }
}

class _TodoTile extends StatelessWidget {
  const _TodoTile({required this.item, required this.onToggle, required this.onAssign, required this.onDelete});
  final TodoItem item;
  final void Function(TodoItem) onToggle;
  final void Function(TodoItem) onAssign;
  final void Function(TodoItem) onDelete;

  @override
  Widget build(BuildContext context) {
    final done = item.status == TodoStatus.done;
    final scheme = Theme.of(context).colorScheme;
    final isOverdue = !done && item.dueDate != null && item.dueDate!.isBefore(DateTime.now());

    return Dismissible(
      key: ValueKey(item.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      confirmDismiss: (_) async {
        if (item.id == null) return false;
        onDelete(item);
        return true;
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
        child: InkWell(
          onLongPress: () => onAssign(item),
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Checkbox(
                  value: done,
                  onChanged: (_) => onToggle(item),
                  shape: const CircleBorder(),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 15,
                          decoration: done ? TextDecoration.lineThrough : null,
                          color: done ? scheme.onSurface.withValues(alpha: 0.4) : null,
                          fontWeight: done ? FontWeight.normal : FontWeight.w500,
                        ),
                      ),
                      if (item.dueDate != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            'Scade ${item.dueDate!.day}/${item.dueDate!.month}',
                            style: TextStyle(
                              fontSize: 12,
                              color: isOverdue ? scheme.error : scheme.onSurface.withValues(alpha: 0.5),
                              fontWeight: isOverdue ? FontWeight.w500 : FontWeight.normal,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                // Icona assegna (hint tenere premuto)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.more_horiz,
                    size: 20,
                    color: scheme.onSurface.withValues(alpha: 0.25),
                  ),
                ),
              ],
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
  final _addCtrl = TextEditingController();
  List<ShoppingList> _lists = [];
  bool _loading = true;
  bool _offline = false;

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
    setState(() => _loading = true);
    _offline = !await _repo.isOnline;
    try {
      final lists = await _repo.listLists(familyId);
      if (mounted) setState(() => _lists = lists);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_repo.errorMessage(e))));
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  // Aggiunge articolo alla prima lista (o crea lista se vuota)
  Future<void> _quickAddItem(String name) async {
    final familyId = context.activeFamilyId;
    if (familyId == null || name.trim().isEmpty) return;
    _addCtrl.clear();

    if (_lists.isEmpty) {
      // Crea lista di default e aggiunge
      try {
        final list = await _repo.createList(familyId, 'Lista della spesa');
        await _repo.addItem(list.id!, name.trim());
        await _load();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Lista creata e articolo aggiunto'), duration: Duration(seconds: 2)),
          );
        }
      } catch (e) {
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_repo.errorMessage(e))));
      }
      return;
    }

    // Se c'è una sola lista, aggiunge direttamente
    if (_lists.length == 1 && _lists.first.id != null) {
      try {
        await _repo.addItem(_lists.first.id!, name.trim());
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Aggiunto a "${_lists.first.name}"'), duration: const Duration(seconds: 2)),
          );
        }
      } catch (e) {
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_repo.errorMessage(e))));
      }
      return;
    }

    // Più liste → scegli
    if (!mounted) return;
    int? selectedId = _lists.first.id;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDlg) => AlertDialog(
          title: const Text('Aggiungi a quale lista?'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final l in _lists)
                RadioListTile<int>(
                  value: l.id!,
                  groupValue: selectedId,
                  title: Text(l.name),
                  onChanged: (v) => setDlg(() => selectedId = v),
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
    if (ok != true || selectedId == null) return;
    try {
      await _repo.addItem(selectedId!, name.trim());
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_repo.errorMessage(e))));
    }
  }

  Future<void> _createList() async {
    final familyId = context.activeFamilyId;
    if (familyId == null) return;
    final ctrl = TextEditingController(text: 'Lista della spesa');
    final name = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Nuova lista'),
        content: TextField(controller: ctrl, autofocus: true),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Annulla')),
          FilledButton(onPressed: () => Navigator.pop(ctx, ctrl.text), child: const Text('Crea')),
        ],
      ),
    );
    if (name == null || name.trim().isEmpty) return;
    try {
      final list = await _repo.createList(familyId, name.trim());
      if (mounted && list.id != null) context.push(AppRoutes.shoppingList(list.id!));
      await _load();
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_repo.errorMessage(e))));
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final scheme = Theme.of(context).colorScheme;
    final isWide = MediaQuery.of(context).size.width >= 600;

    return Column(
      children: [
        // Offline banner
        if (_offline)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.orange.shade50,
            child: Row(
              children: [
                Icon(Icons.cloud_off, size: 16, color: Colors.orange.shade700),
                const SizedBox(width: 8),
                Text('Offline — modifiche salvate localmente',
                    style: TextStyle(fontSize: 12, color: Colors.orange.shade800)),
              ],
            ),
          ),
        // Barra aggiunta articolo veloce
        Container(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border(bottom: BorderSide(color: scheme.outline.withValues(alpha: 0.18))),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _addCtrl,
                  decoration: InputDecoration(
                    hintText: 'Aggiungi articolo alla spesa...',
                    prefixIcon: const Icon(Icons.add_shopping_cart_outlined, size: 20),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send_rounded, size: 20, color: scheme.primary),
                      tooltip: 'Aggiungi',
                      onPressed: () => _quickAddItem(_addCtrl.text),
                    ),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                  onSubmitted: _quickAddItem,
                  textInputAction: TextInputAction.done,
                ),
              ),
              const SizedBox(width: 10),
              // Crea nuova lista
              Tooltip(
                message: 'Nuova lista',
                child: IconButton.outlined(
                  onPressed: _createList,
                  icon: const Icon(Icons.playlist_add_outlined, size: 20),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: _loading
              ? const Center(child: CircularProgressIndicator())
              : _lists.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.shopping_cart_outlined, size: 48, color: scheme.onSurface.withValues(alpha: 0.2)),
                          const SizedBox(height: 12),
                          Text('Nessuna lista', style: TextStyle(color: scheme.onSurface.withValues(alpha: 0.5))),
                          const SizedBox(height: 8),
                          Text('Crea una lista o aggiungi un articolo sopra',
                              style: TextStyle(fontSize: 12, color: scheme.onSurface.withValues(alpha: 0.35))),
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: _load,
                      child: isWide
                          ? _ShoppingGrid(lists: _lists)
                          : _ShoppingList(lists: _lists),
                    ),
        ),
      ],
    );
  }
}

class _ShoppingList extends StatelessWidget {
  const _ShoppingList({required this.lists});
  final List<ShoppingList> lists;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
      itemCount: lists.length,
      itemBuilder: (_, i) => _ShoppingCard(list: lists[i]),
    );
  }
}

class _ShoppingGrid extends StatelessWidget {
  const _ShoppingGrid({required this.lists});
  final List<ShoppingList> lists;

  @override
  Widget build(BuildContext context) {
    final crossCount = MediaQuery.of(context).size.width >= 900 ? 3 : 2;
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 120),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossCount,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 2.4,
      ),
      itemCount: lists.length,
      itemBuilder: (_, i) => _ShoppingCard(list: lists[i]),
    );
  }
}

class _ShoppingCard extends StatelessWidget {
  const _ShoppingCard({required this.list});
  final ShoppingList list;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {
          if (list.id != null) context.push(AppRoutes.shoppingList(list.id!));
        },
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: Colors.green.withValues(alpha: 0.12),
                child: Icon(Icons.shopping_basket_outlined, color: Colors.green.shade600, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(list.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                    if (list.store != null)
                      Text(list.store!, style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurface.withValues(alpha: 0.55))),
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

// ── Shared ────────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 16, 4),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.7,
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}
