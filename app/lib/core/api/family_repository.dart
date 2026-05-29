import 'package:famylia_client/famylia_client.dart';

import 'famylia_services.dart';

/// API famiglia (Serverpod).
class FamilyRepository {
  FamilyRepository({FamyliaServices? services})
      : _client = (services ?? FamyliaServices.instance).client;

  final Client _client;

  Future<Family> createFamily(String name) => _client.family.createFamily(name);

  Future<FamilyMember> joinFamily(String inviteCode) =>
      _client.family.joinFamily(inviteCode);

  Future<List<FamilyWithRole>> listMyFamilies() => _client.family.listMyFamilies();

  Future<List<FamilyMemberInfo>> listMembers(int familyId) =>
      _client.family.listMembers(familyId);

  String userFacingError(Object error) {
    if (error is FamyliaException) return error.message;
    return error.toString();
  }
}
