import 'dart:convert';

import 'package:famylia_client/famylia_client.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Cache locale e coda sync per lista spesa.
class ShoppingOfflineStore {
  ShoppingOfflineStore._();
  static final instance = ShoppingOfflineStore._();

  static const _boxName = 'famylia_shopping';

  Future<void> init() async {
    await Hive.openBox<String>(_boxName);
  }

  Box<String> get _box => Hive.box<String>(_boxName);

  Future<void> cacheLists(int familyId, List<ShoppingList> lists) async {
    await _box.put(
      'lists_$familyId',
      jsonEncode(lists.map((e) => e.toJson()).toList()),
    );
  }

  List<ShoppingList> getCachedLists(int familyId) {
    final raw = _box.get('lists_$familyId');
    if (raw == null) return [];
    return (jsonDecode(raw) as List)
        .map((e) => ShoppingList.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> cacheListDetail(ShoppingListWithItems detail) async {
    final id = detail.list.id;
    if (id == null) return;
    await _box.put(
      'detail_$id',
      jsonEncode({
        'list': detail.list.toJson(),
        'items': detail.items.map((e) => e.toJson()).toList(),
      }),
    );
  }

  ShoppingListWithItems? getCachedListDetail(int listId) {
    final raw = _box.get('detail_$listId');
    if (raw == null) return null;
    final map = jsonDecode(raw) as Map<String, dynamic>;
    return ShoppingListWithItems(
      list: ShoppingList.fromJson(map['list'] as Map<String, dynamic>),
      items: (map['items'] as List)
          .map((e) => ShoppingItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Future<ShoppingListWithItems> applyLocalAdd({
    required int listId,
    required String name,
  }) async {
    final detail = getCachedListDetail(listId);
    if (detail == null) throw StateError('Lista non in cache.');
    final item = ShoppingItem(
      id: -DateTime.now().millisecondsSinceEpoch,
      shoppingListId: listId,
      name: name,
      addedBy: 0,
    );
    final updated = ShoppingListWithItems(
      list: detail.list,
      items: [...detail.items, item],
    );
    await cacheListDetail(updated);
    await _enqueue(listId, {'op': 'add', 'name': name, 'tempId': item.id});
    return updated;
  }

  Future<ShoppingListWithItems> applyLocalCheck({
    required int listId,
    required int itemId,
    required bool checked,
  }) async {
    final detail = getCachedListDetail(listId);
    if (detail == null) throw StateError('Lista non in cache.');
    final items = <ShoppingItem>[];
    for (final item in detail.items) {
      if (item.id == itemId) {
        items.add(
          ShoppingItem(
            id: item.id,
            shoppingListId: item.shoppingListId,
            name: item.name,
            quantity: item.quantity,
            unit: item.unit,
            category: item.category,
            isChecked: checked,
            checkedBy: checked ? item.checkedBy : null,
            checkedAt: checked ? DateTime.now().toUtc() : null,
            priceEstimate: item.priceEstimate,
            notes: item.notes,
            addedBy: item.addedBy,
            isUrgent: item.isUrgent,
          ),
        );
      } else {
        items.add(item);
      }
    }
    final updated = ShoppingListWithItems(list: detail.list, items: items);
    await cacheListDetail(updated);
    if (itemId > 0) {
      await _enqueue(listId, {
        'op': 'check',
        'itemId': itemId,
        'checked': checked,
      });
    }
    return updated;
  }

  Future<void> _enqueue(int listId, Map<String, dynamic> op) async {
    final key = 'pending_$listId';
    final raw = _box.get(key);
    final list = raw == null
        ? <Map<String, dynamic>>[]
        : (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
    list.add(op);
    await _box.put(key, jsonEncode(list));
  }

  List<Map<String, dynamic>> takePending(int listId) {
    final key = 'pending_$listId';
    final raw = _box.get(key);
    if (raw == null) return [];
    _box.delete(key);
    return (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
  }
}
