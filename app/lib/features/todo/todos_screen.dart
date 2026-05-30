import 'package:famylia_client/famylia_client.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:provider/provider.dart';

import '../../core/api/family_repository.dart';
import '../../core/api/todo_repository.dart';
import '../../core/extensions/context_extensions.dart';
import '../../core/session/app_state.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({super.key});

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  final _repo = TodoRepository();
  final _families = FamilyRepository();
  List<TodoItem> _items = [];
  bool _loading = true;
  bool _myDayOnly = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    final familyId = context.activeFamilyId;
    if (familyId == null) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final items = _myDayOnly
          ? await _repo.myDay(familyId)
          : await _repo.list(familyId);
      if (mounted) {
        setState(() {
          _items = items;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = _repo.errorMessage(e);
          _loading = false;
        });
      }
    }
  }

  Future<void> _addTodo() async {
    final familyId = context.activeFamilyId;
    if (familyId == null) return;
    final controller = TextEditingController();
    final title = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Nuovo task'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Cosa fare?'),
        ),
        actions: [
          ShadButton.ghost(onPressed: () => Navigator.pop(ctx), child: const Text('Annulla')),
          ShadButton(
              onPressed: () => Navigator.pop(ctx, controller.text),
            child: const Text('Aggiungi'),
          ),
        ],
      ),
    );
    if (title == null || title.trim().isEmpty) return;
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
              ListTile(
                title: const Text('Nessun assegnatario'),
                onTap: () => Navigator.pop(ctx, -1),
              ),
              for (final m in members)
                ListTile(
                  title: Text(
                    m.userId == me ? '${m.displayName} (io)' : m.displayName,
                  ),
                  subtitle: Text(m.role.name),
                  onTap: () => Navigator.pop(ctx, m.userId),
                ),
            ],
          ),
        ),
      );
      if (choice == null) return;
      final assignee = choice < 0 ? null : choice;
      await _repo.assign(item.id!, assignee);
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
    if (item.id == null) return;
    try {
      if (item.status == TodoStatus.done) {
        // MVP: no uncomplete endpoint — refresh only
        await _load();
      } else {
        await _repo.complete(item.id!);
        await _load();
      }
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
        actions: [
          FilterChip(
            label: const Text('Oggi'),
            selected: _myDayOnly,
            onSelected: (v) {
              setState(() => _myDayOnly = v);
              _load();
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        child: const Icon(Icons.add),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!))
              : _items.isEmpty
                  ? const Center(child: Text('Nessun task. Aggiungine uno!'))
                  : RefreshIndicator(
                      onRefresh: _load,
                      child: ListView.builder(
                        itemCount: _items.length,
                        itemBuilder: (context, index) {
                          final item = _items[index];
                          final done = item.status == TodoStatus.done;
                          return Dismissible(
                            key: ValueKey(item.id),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              color: Colors.red.shade300,
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20),
                              child: const Icon(Icons.delete, color: Colors.white),
                            ),
                            confirmDismiss: (_) async {
                              if (item.id == null) return false;
                              await _repo.delete(item.id!);
                              return true;
                            },
                            onDismissed: (_) => _load(),
                            child: InkWell(
                              onLongPress: () => _assign(item),
                              child: CheckboxListTile(
                                value: done,
                                onChanged: (_) => _toggleDone(item),
                                title: Text(
                                item.title,
                                style: done
                                    ? const TextStyle(decoration: TextDecoration.lineThrough)
                                    : null,
                              ),
                              subtitle: Text(
                                [
                                  if (item.assignedTo != null)
                                    'Assegnato: #${item.assignedTo}',
                                  if (item.dueDate != null)
                                    'Scadenza: ${item.dueDate!.toLocal()}'.split('.').first,
                                ].join(' · '),
                              ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
    );
  }
}
