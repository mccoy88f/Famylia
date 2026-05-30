import 'package:famylia_client/famylia_client.dart';

import 'famylia_services.dart';

class HealthRepository {
  HealthRepository({FamyliaServices? services})
      : _client = (services ?? FamyliaServices.instance).client;

  final Client _client;

  Future<HealthEntry> create(
    int familyId,
    HealthEntryType type,
    String title, {
    String? description,
    HealthEntryStatus? status,
    DateTime? scheduledAt,
    String? providerName,
    String? location,
    String? dietGoal,
    int? caloriesTarget,
    String? sportType,
    int? durationMinutes,
    SportIntensity? intensity,
  }) =>
      _client.health.createEntry(
        familyId,
        type,
        title,
        description: description,
        status: status,
        scheduledAt: scheduledAt,
        providerName: providerName,
        location: location,
        dietGoal: dietGoal,
        caloriesTarget: caloriesTarget,
        sportType: sportType,
        durationMinutes: durationMinutes,
        intensity: intensity,
      );

  Future<List<HealthEntry>> list(
    int familyId, {
    HealthEntryType? type,
    HealthEntryStatus? status,
  }) =>
      _client.health.listEntries(
        familyId,
        type: type,
        status: status,
      );

  Future<List<HealthEntry>> upcoming(
    int familyId, {
    int days = 30,
    HealthEntryType? type,
  }) =>
      _client.health.upcoming(familyId, days: days, type: type);

  Future<HealthEntry> complete(int id) => _client.health.completeEntry(id);

  Future<bool> delete(int id) => _client.health.deleteEntry(id);

  String errorMessage(Object e) {
    if (e is FamyliaException) return e.message;
    return 'Errore: $e';
  }
}
