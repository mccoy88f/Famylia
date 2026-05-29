import 'package:famylia_client/famylia_client.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:serverpod_client/serverpod_client.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

import '../config/app_config.dart';

/// Servizi globali: client Serverpod e sessione auth.
class FamyliaServices {
  FamyliaServices._();

  static FamyliaServices? _instance;

  static FamyliaServices get instance {
    final i = _instance;
    if (i == null) {
      throw StateError('FamyliaServices non inizializzato. Chiamare init() in main.');
    }
    return i;
  }

  static bool get isInitialized => _instance != null;

  late final Client client;
  late final SessionManager sessionManager;

  static Future<FamyliaServices> init() async {
    if (_instance != null) return _instance!;

    final services = FamyliaServices._();
    services.client = Client(
      AppConfig.serverUrl,
      authenticationKeyManager: FlutterAuthenticationKeyManager(),
    )..connectivityMonitor = FlutterConnectivityMonitor();

    services.sessionManager = SessionManager(
      caller: services.client.modules.auth,
    );
    await services.sessionManager.initialize();

    if (services.sessionManager.isSignedIn) {
      await services.client.openStreamingConnection();
    }

    _instance = services;
    return services;
  }

  Future<void> ensureStreaming() async {
    if (!sessionManager.isSignedIn) return;
    if (client.streamingConnectionStatus !=
        StreamingConnectionStatus.connected) {
      await client.openStreamingConnection();
    }
  }
}
