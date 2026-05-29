import 'package:famylia_client/famylia_client.dart';

import 'famylia_services.dart';

class LocationRepository {
  LocationRepository({FamyliaServices? services})
      : _client = (services ?? FamyliaServices.instance).client;

  final Client _client;

  Future<LocationSharing> getStatus(int familyId) =>
      _client.location.getStatus(familyId);

  Future<LocationSharing> updateStatus(
    int familyId,
    bool enabled, {
    LocationAccuracyLevel? accuracy,
  }) =>
      _client.location.updateStatus(
        familyId,
        enabled,
        accuracyLevel: accuracy,
      );

  Future<LocationHistory> checkIn(
    int familyId,
    double lat,
    double lng, {
    String? address,
  }) =>
      _client.location.checkIn(
        familyId,
        lat,
        lng,
        address: address,
      );

  Future<List<MemberLocation>> familyLocations(int familyId) =>
      _client.location.getFamilyLocations(familyId);

  String errorMessage(Object e) {
    if (e is FamyliaException) return e.message;
    return 'Errore: $e';
  }
}
