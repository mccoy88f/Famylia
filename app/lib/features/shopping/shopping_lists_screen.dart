import 'package:famylia_client/famylia_client.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/api/shopping_repository.dart';
import '../../core/extensions/context_extensions.dart';
import '../../core/router/app_router.dart';

class ShoppingListsScreen extends StatefulWidget {
  const ShoppingListsScreen({super.key});

  @override
  State<ShoppingListsScreen> createState() => _ShoppingListsScreenState();
}

class _ShoppingListsScreenState extends State<ShoppingListsScreen> {
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
      if (mounted) {
        setState(() {
          _lists = lists;
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

  Future<void> _createList() async {
    final familyId = context.activeFamilyId;
    if (familyId == null) return;
    final controller = TextEditingController(text: 'Spesa');
    final name = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Nuova lista'),
        content: TextField(
          controller: controller,
          autofocus: true,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Annulla')),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, controller.text),
            child: const Text('Crea'),
          ),
        ],
      ),
    );
    if (name == null || name.trim().isEmpty) return;
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista spesa'),
        actions: [
          if (_offline)
            const Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(Icons.cloud_off, size: 20),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createList,
        child: const Icon(Icons.add),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _lists.isEmpty
              ? const Center(child: Text('Nessuna lista attiva'))
              : RefreshIndicator(
                  onRefresh: _load,
                  child: ListView.builder(
                    itemCount: _lists.length,
                    itemBuilder: (context, index) {
                      final list = _lists[index];
                      return ListTile(
                        leading: const Icon(Icons.shopping_basket_outlined),
                        title: Text(list.name),
                        subtitle: list.store != null ? Text(list.store!) : null,
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          if (list.id != null) {
                            context.push(AppRoutes.shoppingList(list.id!));
                          }
                        },
                      );
                    },
                  ),
                ),
    );
  }
}
