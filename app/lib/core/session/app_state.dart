import 'package:flutter/foundation.dart';
import 'package:serverpod_auth_client/serverpod_auth_client.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

import '../api/famylia_services.dart';

/// Stato autenticazione collegato a [SessionManager] Serverpod.
class AppState extends ChangeNotifier {
  AppState() {
    FamyliaServices.instance.sessionManager.addListener(_onSessionChanged);
  }

  SessionManager get _session => FamyliaServices.instance.sessionManager;

  bool get isSignedIn => _session.isSignedIn;

  UserInfo? get signedInUser => _session.signedInUser;

  String? get userEmail => _session.signedInUser?.email;

  String? get userName => _session.signedInUser?.userName;

  void _onSessionChanged() => notifyListeners();

  @override
  void dispose() {
    _session.removeListener(_onSessionChanged);
    super.dispose();
  }
}
