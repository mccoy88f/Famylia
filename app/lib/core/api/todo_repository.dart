import 'package:famylia_client/famylia_client.dart';

import 'famylia_services.dart';

class TodoRepository {
  TodoRepository({FamyliaServices? services})
      : _client = (services ?? FamyliaServices.instance).client;

  final Client _client;

  Future<TodoItem> create(
    int familyId,
    String title, {
    String? description,
    TodoCategory? category,
    TodoPriority? priority,
    int? assignedTo,
    DateTime? dueDate,
  }) =>
      _client.todo.createTodo(
        familyId,
        title,
        description: description,
        category: category,
        priority: priority,
        assignedTo: assignedTo,
        dueDate: dueDate,
      );

  Future<List<TodoItem>> listAssignedTo(int familyId, int userId) async {
    final all = await _client.todo.listTodos(familyId);
    return all.where((t) => t.assignedTo == userId).toList();
  }

  Future<List<TodoItem>> list(int familyId, {TodoStatus? status}) =>
      _client.todo.listTodos(familyId, status: status);

  Future<List<TodoItem>> myDay(int familyId) => _client.todo.myDay(familyId);

  Future<TodoItem> complete(int todoId) => _client.todo.completeTodo(todoId);

  Future<bool> delete(int todoId) => _client.todo.deleteTodo(todoId);

  Future<TodoItem> assign(int todoId, int? userId) =>
      _client.todo.assignTodo(todoId, userId);

  String errorMessage(Object e) {
    if (e is FamyliaException) return e.message;
    return 'Errore: $e';
  }
}
