import 'package:famylia_client/famylia_client.dart';

import 'famylia_services.dart';

class DeadlineRepository {
  DeadlineRepository({FamyliaServices? services})
      : _client = (services ?? FamyliaServices.instance).client;

  final Client _client;

  Future<Deadline> create(
    int familyId,
    String title,
    DateTime dueDate, {
    double? amount,
    DeadlineCategory? category,
  }) =>
      _client.deadline.createDeadline(
        familyId,
        title,
        dueDate,
        amount: amount,
        category: category,
      );

  Future<List<Deadline>> list(int familyId, {DeadlineStatus? status}) =>
      _client.deadline.listDeadlines(familyId, status: status);

  Future<List<Deadline>> upcoming(int familyId, {int days = 30}) =>
      _client.deadline.upcoming(familyId, days: days);

  Future<Deadline> complete(int id) => _client.deadline.completeDeadline(id);

  Future<bool> delete(int id) => _client.deadline.deleteDeadline(id);

  String errorMessage(Object e) {
    if (e is FamyliaException) return e.message;
    return 'Errore: $e';
  }
}
