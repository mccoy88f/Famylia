import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../util/family_access.dart';

class EmergencyEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  static String _channel(int familyId) => 'famylia-emergency-$familyId';

  void _notify(Session session, int familyId) {
    session.messages.postMessage(
      _channel(familyId),
      EmergencyChanged(familyId: familyId),
    );
  }

  Stream<List<EmergencyAlert>> watchAlerts(
    Session session,
    int familyId,
  ) async* {
    await requireFamilyMember(session, familyId);
    final updates =
        session.messages.createStream<EmergencyChanged>(_channel(familyId));
    yield await listActive(session, familyId);
    await for (final _ in updates) {
      yield await listActive(session, familyId);
    }
  }

  Future<EmergencySettings> getSettings(Session session, int familyId) async {
    await requireFamilyMember(session, familyId);
    return _getOrCreateSettings(session, familyId);
  }

  Future<EmergencySettings> updateSettings(
    Session session,
    EmergencySettings settings,
  ) async {
    await requireFamilyMemberNotGuest(session, settings.familyId);
    final existing = await EmergencySettings.db.findFirstRow(
      session,
      where: (t) => t.familyId.equals(settings.familyId),
    );
    if (existing == null) {
      return EmergencySettings.db.insertRow(session, settings);
    }
    return EmergencySettings.db.updateRow(
      session,
      settings.copyWith(id: existing.id),
    );
  }

  Future<EmergencyAlert> triggerAlert(
    Session session,
    int familyId,
    EmergencyAlertType alertType, {
    String? customMessage,
    double? locationLat,
    double? locationLng,
    String? locationAddress,
    int? batteryLevel,
    bool isTest = false,
  }) async {
    await requireFamilyMember(session, familyId);
    final userId = await requireUserId(session);

    final alert = await EmergencyAlert.db.insertRow(
      session,
      EmergencyAlert(
        familyId: familyId,
        triggeredBy: userId,
        alertType: alertType,
        customMessage: customMessage,
        locationLat: locationLat,
        locationLng: locationLng,
        locationAddress: locationAddress,
        batteryLevel: batteryLevel,
        triggerMethod: isTest
            ? EmergencyTriggerMethod.testMode
            : EmergencyTriggerMethod.panicButton,
        status: EmergencyAlertStatus.active,
        isTest: isTest,
      ),
    );
    _notify(session, familyId);
    return alert;
  }

  Future<List<EmergencyAlert>> listActive(
    Session session,
    int familyId,
  ) async {
    await requireFamilyMember(session, familyId);
    return EmergencyAlert.db.find(
      session,
      where: (t) =>
          t.familyId.equals(familyId) &
          t.status.equals(EmergencyAlertStatus.active),
      orderBy: (t) => t.id,
      orderDescending: true,
    );
  }

  Future<List<EmergencyAlert>> listHistory(
    Session session,
    int familyId,
  ) async {
    await requireFamilyMember(session, familyId);
    return EmergencyAlert.db.find(
      session,
      where: (t) => t.familyId.equals(familyId),
      orderBy: (t) => t.id,
      orderDescending: true,
      limit: 50,
    );
  }

  Future<EmergencyAlert> acknowledge(Session session, int alertId) async {
    final alert = await _requireAlert(session, alertId);
    await requireFamilyMember(session, alert.familyId);
    final userId = await requireUserId(session);
    final updated = await EmergencyAlert.db.updateRow(
      session,
      alert.copyWith(
        status: EmergencyAlertStatus.acknowledged,
        acknowledgedBy: userId,
        acknowledgedAt: DateTime.now().toUtc(),
      ),
    );
    _notify(session, alert.familyId);
    return updated;
  }

  Future<EmergencyAlert> resolve(Session session, int alertId) async {
    final alert = await _requireAlert(session, alertId);
    await requireFamilyMember(session, alert.familyId);
    final userId = await requireUserId(session);
    final updated = await EmergencyAlert.db.updateRow(
      session,
      alert.copyWith(
        status: EmergencyAlertStatus.resolved,
        resolvedBy: userId,
        resolvedAt: DateTime.now().toUtc(),
      ),
    );
    _notify(session, alert.familyId);
    return updated;
  }

  Future<EmergencyAlert> markFalseAlarm(Session session, int alertId) async {
    final alert = await _requireAlert(session, alertId);
    await requireFamilyMember(session, alert.familyId);
    final userId = await requireUserId(session);
    final updated = await EmergencyAlert.db.updateRow(
      session,
      alert.copyWith(
        status: EmergencyAlertStatus.falseAlarm,
        resolvedBy: userId,
        resolvedAt: DateTime.now().toUtc(),
      ),
    );
    _notify(session, alert.familyId);
    return updated;
  }

  Future<List<EmergencyContact>> listContacts(
    Session session,
    int familyId,
  ) async {
    await requireFamilyMember(session, familyId);
    return EmergencyContact.db.find(
      session,
      where: (t) => t.familyId.equals(familyId),
      orderBy: (t) => t.priority,
    );
  }

  Future<EmergencyContact> addContact(
    Session session,
    int familyId,
    String name,
    String phone, {
    String? email,
    int? priority,
  }) async {
    await requireFamilyMemberNotGuest(session, familyId);
    final userId = await requireUserId(session);
    return EmergencyContact.db.insertRow(
      session,
      EmergencyContact(
        familyId: familyId,
        createdBy: userId,
        name: name.trim(),
        phone: phone.trim(),
        email: email?.trim(),
        priority: priority ?? 1,
      ),
    );
  }

  Future<bool> deleteContact(Session session, int contactId) async {
    final contact = await EmergencyContact.db.findById(session, contactId);
    if (contact == null) {
      throw FamyliaException(message: 'Contatto non trovato.');
    }
    await requireFamilyMemberNotGuest(session, contact.familyId);
    await EmergencyContact.db.deleteRow(session, contact);
    return true;
  }

  Future<EmergencyAlert> _requireAlert(Session session, int id) async {
    final alert = await EmergencyAlert.db.findById(session, id);
    if (alert == null) {
      throw FamyliaException(message: 'Allerta non trovata.');
    }
    return alert;
  }

  Future<EmergencySettings> _getOrCreateSettings(
    Session session,
    int familyId,
  ) async {
    final existing = await EmergencySettings.db.findFirstRow(
      session,
      where: (t) => t.familyId.equals(familyId),
    );
    if (existing != null) return existing;
    return EmergencySettings.db.insertRow(
      session,
      EmergencySettings(familyId: familyId),
    );
  }
}
