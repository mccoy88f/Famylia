import 'package:flutter/foundation.dart';

/// URL base del server Serverpod.
///
/// Su web: derivato automaticamente dall'host della pagina (porta 8080).
/// Override tramite --dart-define=SERVER_URL=https://... al build.
abstract final class AppConfig {
  static const _envUrl = String.fromEnvironment('SERVER_URL');

  static String get serverUrl {
    // Explicit override always wins
    if (_envUrl.isNotEmpty) return _envUrl;

    // On web: derive from current page origin (same host, port 8080)
    if (kIsWeb) {
      final base = Uri.base;
      final scheme = base.scheme; // http or https
      final host = base.host;     // real hostname / IP
      return '$scheme://$host:8080/';
    }

    // Native fallback
    return 'http://localhost:8080/';
  }
}
