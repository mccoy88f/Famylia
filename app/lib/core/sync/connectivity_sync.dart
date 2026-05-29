import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

import '../api/shopping_repository.dart';
import '../session/family_context.dart';

/// Sincronizza liste spesa quando la connessione torna disponibile.
class ConnectivitySync {
  ConnectivitySync({
    Connectivity? connectivity,
    ShoppingRepository? shopping,
    FamilyContext? familyContext,
  })  : _connectivity = connectivity ?? Connectivity(),
        _shopping = shopping ?? ShoppingRepository(),
        _familyContext = familyContext;

  final Connectivity _connectivity;
  final ShoppingRepository _shopping;
  final FamilyContext? _familyContext;

  StreamSubscription<List<ConnectivityResult>>? _sub;
  bool _wasOffline = false;

  void start() {
    _sub?.cancel();
    _sub = _connectivity.onConnectivityChanged.listen(_onChange);
  }

  void dispose() => _sub?.cancel();

  Future<void> _onChange(List<ConnectivityResult> results) async {
    final offline = results.contains(ConnectivityResult.none);
    if (_wasOffline && !offline) {
      final familyId = _familyContext?.activeFamilyId;
      if (familyId != null) {
        try {
          await _shopping.syncFamily(familyId);
        } catch (e) {
          debugPrint('Sync dopo reconnect: $e');
        }
      }
    }
    _wasOffline = offline;
  }
}
