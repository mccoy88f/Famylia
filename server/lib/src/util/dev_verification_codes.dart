/// Codici verifica in memoria (solo sviluppo locale, senza SMTP).
abstract final class DevVerificationCodes {
  static final Map<String, String> _codes = {};

  static void put(String email, String code) {
    _codes[email.trim().toLowerCase()] = code;
  }

  static String? peek(String email) {
    return _codes[email.trim().toLowerCase()];
  }
}
