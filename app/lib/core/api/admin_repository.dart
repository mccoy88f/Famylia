import 'package:famylia_client/famylia_client.dart';
import 'famylia_services.dart';

class AdminRepository {
  String? _adminToken;

  bool get isAuthenticated => _adminToken != null;
  String? get adminToken => _adminToken;

  Future<void> login(String email, String password) async {
    final client = FamyliaServices.client;
    final token = await client.admin.adminLogin(email, password);
    _adminToken = token;
  }

  void logout() {
    _adminToken = null;
  }

  Future<AiConfig> getAiConfig() async {
    final token = _requireToken();
    return FamyliaServices.client.admin.getAiConfig(token);
  }

  Future<AiConfig> setAiConfig(String provider, String modelName) async {
    final token = _requireToken();
    return FamyliaServices.client.admin
        .setAiConfig(token, provider, modelName);
  }

  Future<List<UsageStat>> getUsageStats({int days = 30}) async {
    final token = _requireToken();
    return FamyliaServices.client.admin
        .getUsageStats(token, days: days);
  }

  String _requireToken() {
    final token = _adminToken;
    if (token == null) throw Exception('Not authenticated');
    return token;
  }

  String errorMessage(Object e) {
    final msg = e.toString();
    if (msg.contains('Invalid credentials')) return 'Credenziali non valide';
    if (msg.contains('Unauthorized')) return 'Non autorizzato';
    return 'Errore: $msg';
  }
}
