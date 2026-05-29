import 'package:famylia_client/famylia_client.dart';

import 'famylia_services.dart';

class GdprRepository {
  GdprRepository({FamyliaServices? services})
      : _client = (services ?? FamyliaServices.instance).client;

  final Client _client;

  Future<GdprExport> exportMyData() => _client.gdpr.exportMyData();

  Future<bool> deleteMyAccount() => _client.gdpr.deleteMyAccount();

  Future<PrivacyDashboard> privacyDashboard(int familyId) =>
      _client.gdpr.getPrivacyDashboard(familyId);

  String errorMessage(Object e) {
    if (e is FamyliaException) return e.message;
    return 'Errore: $e';
  }
}
