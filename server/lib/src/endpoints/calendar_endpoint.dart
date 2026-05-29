import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../util/family_access.dart';

class CalendarEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<CalendarEvent> createEvent(
    Session session,
    int familyId,
    String title,
    DateTime startAt, {
    String? description,
    CalendarEventCategory? category,
    DateTime? endAt,
    bool? isAllDay,
    String? location,
    int? assignedTo,
    bool? isPrivate,
    String? color,
  }) async {
    await requireFamilyMemberNotGuest(session, familyId);
    final userId = await requireUserId(session);
    final trimmed = title.trim();
    if (trimmed.isEmpty) {
      throw FamyliaException(message: 'Il titolo è obbligatorio.');
    }

    return CalendarEvent.db.insertRow(
      session,
      CalendarEvent(
        familyId: familyId,
        createdBy: userId,
        title: trimmed,
        description: description?.trim(),
        category: category ?? CalendarEventCategory.other,
        startAt: startAt,
        endAt: endAt,
        isAllDay: isAllDay ?? false,
        location: location?.trim(),
        assignedTo: assignedTo,
        isPrivate: isPrivate ?? false,
        color: color,
      ),
    );
  }

  Future<List<CalendarEvent>> listEvents(
    Session session,
    int familyId,
    DateTime from,
    DateTime to,
  ) async {
    final userId = await requireUserId(session);
    await requireFamilyMember(session, familyId);
    final rows = await CalendarEvent.db.find(
      session,
      where: (t) => t.familyId.equals(familyId),
      orderBy: (t) => t.startAt,
    );
    return rows.where((e) {
      if (e.isPrivate && e.createdBy != userId) return false;
      final start = e.startAt;
      final end = e.endAt ?? start;
      return !end.isBefore(from) && !start.isAfter(to);
    }).toList();
  }

  Future<CalendarEvent> updateEvent(
    Session session,
    CalendarEvent event,
  ) async {
    await requireFamilyMemberNotGuest(session, event.familyId);
    final existing = await CalendarEvent.db.findById(session, event.id!);
    if (existing == null) {
      throw FamyliaException(message: 'Evento non trovato.');
    }
    return CalendarEvent.db.updateRow(session, event);
  }

  Future<bool> deleteEvent(Session session, int eventId) async {
    final row = await CalendarEvent.db.findById(session, eventId);
    if (row == null) {
      throw FamyliaException(message: 'Evento non trovato.');
    }
    await requireFamilyMemberNotGuest(session, row.familyId);
    await CalendarEvent.db.deleteRow(session, row);
    return true;
  }
}
