import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// URL base del server Serverpod.
///
/// Priorità:
/// 1. --dart-define=SERVER_URL (CI / build esplicito)
/// 2. URL custom salvato dall'utente (solo mobile/desktop)
/// 3. Su web: stesso host della pagina, porta 8080
/// 4. Default pubblico: https://api.famylia.app/
abstract final class AppConfig {
  static const _envUrl = String.fromEnvironment('SERVER_URL');
  static const _keyCustomUrl = 'custom_server_url';

  /// URL custom impostato dall'utente a runtime (solo native).
  static String? _customUrl;

  /// Legge l'URL custom da SharedPreferences all'avvio dell'app.
  static Future<void> load(SharedPreferences prefs) async {
    _customUrl = prefs.getString(_keyCustomUrl);
  }

  /// Salva un URL custom e lo applica immediatamente.
  /// Passa null per tornare al default.
  static Future<void> setCustomUrl(SharedPreferences prefs, String? url) async {
    final normalized = _normalize(url);
    _customUrl = normalized;
    if (normalized == null) {
      await prefs.remove(_keyCustomUrl);
    } else {
      await prefs.setString(_keyCustomUrl, normalized);
    }
  }

  static String? get customUrl => _customUrl;

  static String get serverUrl {
    // 1. Build-time override (CI, dev)
    if (_envUrl.isNotEmpty) return _envUrl;

    // 2. User-defined custom URL (native only)
    if (!kIsWeb && _customUrl != null && _customUrl!.isNotEmpty) {
      return _customUrl!;
    }

    // 3. Web: stessa origine, porta 8080
    if (kIsWeb) {
      final base = Uri.base;
      return '${base.scheme}://${base.host}:8080/';
    }

    // 4. Default pubblico
    return 'https://api.famylia.app/';
  }

  static String? _normalize(String? url) {
    if (url == null || url.trim().isEmpty) return null;
    var u = url.trim();
    if (!u.startsWith('http://') && !u.startsWith('https://')) {
      u = 'https://$u';
    }
    if (!u.endsWith('/')) u = '$u/';
    return u;
  }
}
