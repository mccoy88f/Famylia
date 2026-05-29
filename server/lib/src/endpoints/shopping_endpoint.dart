import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../util/family_access.dart';

class ShoppingEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  static String _channelForList(int listId) => 'famylia-shopping-$listId';

  void _notifyListChanged(Session session, int listId) {
    session.messages.postMessage(
      _channelForList(listId),
      ShoppingListChanged(listId: listId),
    );
  }

  /// Stream real-time: primo evento = stato attuale, poi ad ogni modifica.
  Stream<ShoppingListWithItems> watchList(Session session, int listId) async* {
    await _requireList(session, listId);
    final updates =
        session.messages.createStream<ShoppingListChanged>(_channelForList(listId));

    yield await getList(session, listId);

    await for (final _ in updates) {
      yield await getList(session, listId);
    }
  }

  Future<ShoppingList> createList(
    Session session,
    int familyId,
    String name, {
    String? store,
    int? assignedTo,
    DateTime? dueDate,
  }) async {
    await requireFamilyMemberNotGuest(session, familyId);
    final userId = await requireUserId(session);
    final trimmed = name.trim();
    if (trimmed.isEmpty) {
      throw FamyliaException(message: 'Il nome lista è obbligatorio.');
    }

    return ShoppingList.db.insertRow(
      session,
      ShoppingList(
        familyId: familyId,
        createdBy: userId,
        name: trimmed,
        store: store?.trim(),
        status: ShoppingListStatus.active,
        assignedTo: assignedTo,
        dueDate: dueDate,
      ),
    );
  }

  Future<List<ShoppingList>> listLists(
    Session session,
    int familyId, {
    ShoppingListStatus? status,
  }) async {
    await requireFamilyMember(session, familyId);
    return ShoppingList.db.find(
      session,
      where: (t) {
        var expr = t.familyId.equals(familyId);
        if (status != null) {
          expr = expr & t.status.equals(status);
        }
        return expr;
      },
      orderBy: (t) => t.id,
      orderDescending: true,
    );
  }

  Future<ShoppingListWithItems> getList(Session session, int listId) async {
    final list = await _requireList(session, listId);
    final items = await ShoppingItem.db.find(
      session,
      where: (t) => t.shoppingListId.equals(listId),
      orderBy: (t) => t.isChecked,
      orderDescending: false,
    );
    return ShoppingListWithItems(list: list, items: items);
  }

  Future<ShoppingItem> addItem(
    Session session,
    int listId,
    String name, {
    double? quantity,
    ShoppingUnit? unit,
    ShoppingCategory? category,
    String? notes,
    bool? isUrgent,
  }) async {
    final list = await _requireList(session, listId);
    await requireFamilyMemberNotGuest(session, list.familyId);
    final userId = await requireUserId(session);
    final trimmed = name.trim();
    if (trimmed.isEmpty) {
      throw FamyliaException(message: 'Il nome articolo è obbligatorio.');
    }

    final item = await ShoppingItem.db.insertRow(
      session,
      ShoppingItem(
        shoppingListId: listId,
        name: trimmed,
        quantity: quantity ?? 1,
        unit: unit ?? ShoppingUnit.pieces,
        category: category ?? ShoppingCategory.other,
        notes: notes?.trim(),
        addedBy: userId,
        isUrgent: isUrgent ?? false,
      ),
    );
    _notifyListChanged(session, listId);
    return item;
  }

  Future<ShoppingItem> updateItem(Session session, ShoppingItem item) async {
    final list = await _requireList(session, item.shoppingListId);
    await requireFamilyMemberNotGuest(session, list.familyId);
    final updated = await ShoppingItem.db.updateRow(session, item);
    _notifyListChanged(session, item.shoppingListId);
    return updated;
  }

  Future<ShoppingItem> checkItem(
    Session session,
    int itemId,
    bool isChecked,
  ) async {
    final item = await ShoppingItem.db.findById(session, itemId);
    if (item == null) {
      throw FamyliaException(message: 'Articolo non trovato.');
    }
    final list = await _requireList(session, item.shoppingListId);
    await requireFamilyMember(session, list.familyId);
    final userId = await requireUserId(session);

    final updated = await ShoppingItem.db.updateRow(
      session,
      item.copyWith(
        isChecked: isChecked,
        checkedBy: isChecked ? userId : null,
        checkedAt: isChecked ? DateTime.now().toUtc() : null,
      ),
    );
    _notifyListChanged(session, item.shoppingListId);
    return updated;
  }

  Future<bool> deleteItem(Session session, int itemId) async {
    final item = await ShoppingItem.db.findById(session, itemId);
    if (item == null) {
      throw FamyliaException(message: 'Articolo non trovato.');
    }
    final list = await _requireList(session, item.shoppingListId);
    await requireFamilyMemberNotGuest(session, list.familyId);
    await ShoppingItem.db.deleteRow(session, item);
    _notifyListChanged(session, item.shoppingListId);
    return true;
  }

  Future<ShoppingList> completeList(Session session, int listId) async {
    final list = await _requireList(session, listId);
    await requireFamilyMemberNotGuest(session, list.familyId);
    final updated = await ShoppingList.db.updateRow(
      session,
      list.copyWith(status: ShoppingListStatus.completed),
    );
    _notifyListChanged(session, listId);
    return updated;
  }

  Future<ShoppingList> _requireList(Session session, int listId) async {
    final list = await ShoppingList.db.findById(session, listId);
    if (list == null) {
      throw FamyliaException(message: 'Lista non trovata.');
    }
    await requireFamilyMember(session, list.familyId);
    return list;
  }
}
