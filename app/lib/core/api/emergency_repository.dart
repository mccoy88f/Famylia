import 'package:famylia_client/famylia_client.dart';

import 'famylia_services.dart';

class EmergencyRepository {
  EmergencyRepository({FamyliaServices? services})
      : _services = services ?? FamyliaServices.instance;

  final FamyliaServices _services;
  Client get _client => _services.client;

  Stream<List<EmergencyAlert>> watch(int familyId) {
    _services.ensureStreaming();
    return _client.emergency.watchAlerts(familyId);
  }

  Future<EmergencySettings> settings(int familyId) =>
      _client.emergency.getSettings(familyId);

  Future<EmergencyAlert> trigger(
    int familyId,
    EmergencyAlertType type, {
    String? message,
    bool isTest = false,
  }) =>
      _client.emergency.triggerAlert(
        familyId,
        type,
        customMessage: message,
        isTest: isTest,
      );

  Future<EmergencyAlert> acknowledge(int alertId) =>
      _client.emergency.acknowledge(alertId);

  Future<EmergencyAlert> resolve(int alertId) =>
      _client.emergency.resolve(alertId);

  Future<List<EmergencyContact>> contacts(int familyId) =>
      _client.emergency.listContacts(familyId);

  Future<EmergencyContact> addContact(
    int familyId,
    String name,
    String phone,
  ) =>
      _client.emergency.addContact(familyId, name, phone);

  String errorMessage(Object e) {
    if (e is FamyliaException) return e.message;
    return 'Errore: $e';
  }
}
