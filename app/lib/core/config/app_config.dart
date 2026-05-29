/// URL base del server Serverpod.
///
/// - Web/desktop locale: `http://localhost:8080/`
/// - Emulatore Android: `http://10.0.2.2:8080/`
/// - Dispositivo fisico: IP della macchina host
abstract final class AppConfig {
  static const serverUrl = String.fromEnvironment(
    'SERVER_URL',
    defaultValue: 'http://localhost:8080/',
  );
}
