import 'dart:async';

import 'package:famylia_client/famylia_client.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../core/api/shopping_repository.dart';
import '../../core/shopping/shopping_category_style.dart';

class ShoppingListDetailScreen extends StatefulWidget {
  const ShoppingListDetailScreen({required this.listId, super.key});

  final int listId;

  @override
  State<ShoppingListDetailScreen> createState() => _ShoppingListDetailScreenState();
}

class _ShoppingListDetailScreenState extends State<ShoppingListDetailScreen> {
  final _repo = ShoppingRepository();
  ShoppingListWithItems? _detail;
  bool _loading = true;
  bool _offline = false;
  final _quickAddController = TextEditingController();
  StreamSubscription<ShoppingListWithItems>? _watchSub;

  @override
  void dispose() {
    _watchSub?.cancel();
    _quickAddController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _startWatching());
  }

  Future<void> _startWatching() async {
    setState(() => _loading = true);
    _offline = !await _repo.isOnline;

    if (await _repo.isOnline) {
      try {
        _watchSub?.cancel();
        _watchSub = _repo.watchList(widget.listId).listen(
          (detail) {
            if (mounted) {
              setState(() {
                _detail = detail;
                _loading = false;
              });
            }
          },
          onError: (e) {
            if (mounted) {
              setState(() => _loading = false);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(_repo.errorMessage(e))),
              );
            }
          },
        );
        return;
      } catch (_) {
        // fallback poll/load
      }
    }

    await _loadOnce();
  }

  Future<void> _loadOnce() async {
    try {
      final detail = await _repo.getList(widget.listId);
      if (mounted) {
        setState(() {
          _detail = detail;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_repo.errorMessage(e))),
        );
      }
    }
  }

  Future<void> _addItem() async {
    final name = _quickAddController.text.trim();
    if (name.isEmpty) return;
    _quickAddController.clear();
    try {
      final detail = await _repo.addItem(widget.listId, name);
      if (mounted) setState(() => _detail = detail);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_repo.errorMessage(e))),
        );
      }
    }
  }

  Future<void> _check(ShoppingItem item, bool? value) async {
    if (item.id == null || value == null) return;
    try {
      final detail = await _repo.checkItem(widget.listId, item.id!, value);
      if (mounted) setState(() => _detail = detail);
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
    final shadTheme = ShadTheme.of(context);
    final detail = _detail;
    return Scaffold(
      backgroundColor: shadTheme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: shadTheme.colorScheme.background,
        surfaceTintColor: Colors.transparent,
        title: Text(detail?.list.name ?? 'Lista'),
        actions: [
          if (_offline)
            const Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(Icons.cloud_off, size: 20),
            )
          else
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Icon(Icons.sync, size: 20, color: shadTheme.colorScheme.primary),
            ),
        ],
      ),
      body: Column(
        children: [
          if (_offline)
            Container(
              width: double.infinity,
              color: shadTheme.colorScheme.destructive.withValues(alpha: 0.1),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  Icon(Icons.cloud_off, size: 18, color: shadTheme.colorScheme.destructive),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Offline — modifiche in coda, sync al reconnect',
                      style: TextStyle(color: shadTheme.colorScheme.destructive, fontSize: 13),
                    ),
                  ),
                  ShadButton.ghost(
                    onPressed: _loadOnce,
                    size: ShadButtonSize.sm,
                    child: const Text('Riprova'),
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: ShadInput(
                    controller: _quickAddController,
                    placeholder: const Text('Aggiungi articolo…'),
                    onSubmitted: (_) => _addItem(),
                  ),
                ),
                const SizedBox(width: 8),
                ShadButton(
                  onPressed: _addItem,
                  size: ShadButtonSize.icon,
                  child: const Icon(Icons.add, size: 18),
                ),
              ],
            ),
          ),
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : detail == null
                    ? const SizedBox.shrink()
                    : ListView.builder(
                        itemCount: detail.items.length,
                        itemBuilder: (context, index) {
                          final item = detail.items[index];
                          final style = ShoppingCategoryStyle.forCategory(item.category);
                          return Dismissible(
                            key: ValueKey(item.id),
                            direction: DismissDirection.startToEnd,
                            background: Container(
                              color: Colors.green.shade300,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 20),
                              child: const Icon(Icons.check, color: Colors.white),
                            ),
                            confirmDismiss: (_) async {
                              await _check(item, true);
                              return false;
                            },
                            child: CheckboxListTile(
                              value: item.isChecked,
                              onChanged: (v) => _check(item, v),
                              secondary: CircleAvatar(
                                backgroundColor: style.color.withValues(alpha: 0.2),
                                child: Icon(style.icon, color: style.color, size: 20),
                              ),
                              title: Text(item.name),
                              subtitle: Text(
                                item.isUrgent
                                    ? 'Urgente · ${style.label}'
                                    : style.label,
                                style: TextStyle(
                                  color: item.isUrgent ? Colors.orange : null,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
