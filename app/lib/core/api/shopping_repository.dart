import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:famylia_client/famylia_client.dart';

import '../shopping/shopping_offline_store.dart';
import 'famylia_services.dart';

class ShoppingRepository {
  ShoppingRepository({
    FamyliaServices? services,
    ShoppingOfflineStore? offline,
    Connectivity? connectivity,
  })  : _client = (services ?? FamyliaServices.instance).client,
        _offline = offline ?? ShoppingOfflineStore.instance,
        _connectivity = connectivity ?? Connectivity();

  final Client _client;
  final ShoppingOfflineStore _offline;
  final Connectivity _connectivity;

  Future<bool> get isOnline async {
    final result = await _connectivity.checkConnectivity();
    return !result.contains(ConnectivityResult.none);
  }

  Future<List<ShoppingList>> listLists(int familyId) async {
    if (await isOnline) {
      try {
        final lists = await _client.shopping.listLists(
          familyId,
          status: ShoppingListStatus.active,
        );
        await _offline.cacheLists(familyId, lists);
        return lists;
      } catch (_) {}
    }
    return _offline.getCachedLists(familyId);
  }

  Future<ShoppingListWithItems> getList(int listId) async {
    if (await isOnline) {
      try {
        final detail = await _client.shopping.getList(listId);
        await _offline.cacheListDetail(detail);
        return detail;
      } catch (_) {}
    }
    final cached = _offline.getCachedListDetail(listId);
    if (cached != null) return cached;
    throw StateError('Lista non disponibile.');
  }

  Future<ShoppingList> createList(int familyId, String name) async {
    final list = await _client.shopping.createList(familyId, name);
    final lists = await _client.shopping.listLists(
      familyId,
      status: ShoppingListStatus.active,
    );
    await _offline.cacheLists(familyId, lists);
    return list;
  }

  Future<ShoppingListWithItems> addItem(int listId, String name) async {
    if (await isOnline) {
      try {
        await _client.shopping.addItem(listId, name);
        await flushPending(listId);
        return getList(listId);
      } catch (_) {}
    }
    await _offline.applyLocalAdd(listId: listId, name: name);
    return _offline.getCachedListDetail(listId)!;
  }

  Future<ShoppingListWithItems> checkItem(
    int listId,
    int itemId,
    bool checked,
  ) async {
    if (await isOnline) {
      try {
        await _client.shopping.checkItem(itemId, checked);
        await flushPending(listId);
        return getList(listId);
      } catch (_) {}
    }
    return _offline.applyLocalCheck(
      listId: listId,
      itemId: itemId,
      checked: checked,
    );
  }

  Future<void> flushPending(int listId) async {
    if (!await isOnline) return;
    for (final op in _offline.takePending(listId)) {
      switch (op['op']) {
        case 'add':
          await _client.shopping.addItem(listId, op['name'] as String);
        case 'check':
          await _client.shopping.checkItem(
            op['itemId'] as int,
            op['checked'] as bool,
          );
      }
    }
    final detail = await _client.shopping.getList(listId);
    await _offline.cacheListDetail(detail);
  }

  /// Ascolta aggiornamenti real-time (richiede WebSocket aperto).
  Stream<ShoppingListWithItems> watchList(int listId) async* {
    await FamyliaServices.instance.ensureStreaming();
    yield* _client.shopping.watchList(listId);
  }

  Future<void> syncFamily(int familyId) async {
    if (!await isOnline) return;
    final lists = await listLists(familyId);
    for (final list in lists) {
      if (list.id != null) await flushPending(list.id!);
    }
  }

  String errorMessage(Object e) {
    if (e is FamyliaException) return e.message;
    return e.toString();
  }
}
