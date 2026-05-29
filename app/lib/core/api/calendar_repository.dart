import 'package:famylia_client/famylia_client.dart';

import 'famylia_services.dart';

class CalendarRepository {
  CalendarRepository({FamyliaServices? services})
      : _client = (services ?? FamyliaServices.instance).client;

  final Client _client;

  Future<CalendarEvent> create(
    int familyId,
    String title,
    DateTime startAt, {
    DateTime? endAt,
    CalendarEventCategory? category,
    String? location,
  }) =>
      _client.calendar.createEvent(
        familyId,
        title,
        startAt,
        endAt: endAt,
        category: category,
        location: location,
      );

  Future<List<CalendarEvent>> list(
    int familyId,
    DateTime from,
    DateTime to,
  ) =>
      _client.calendar.listEvents(familyId, from, to);

  Future<bool> delete(int id) => _client.calendar.deleteEvent(id);

  String errorMessage(Object e) {
    if (e is FamyliaException) return e.message;
    return 'Errore: $e';
  }
}
