import 'package:famylia_client/famylia_client.dart';

import 'famylia_services.dart';

class ReportRepository {
  ReportRepository({FamyliaServices? services})
      : _client = (services ?? FamyliaServices.instance).client;

  final Client _client;

  Future<FamilyReport> getReport(int familyId) =>
      _client.report.getReport(familyId);

  String errorMessage(Object e) {
    if (e is FamyliaException) return e.message;
    return 'Errore: $e';
  }
}
