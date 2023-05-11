import 'package:bl_todo/service/todo_service.dart';

import '../model/todo.dart';

class TodoServiceMem implements TodoService {
  final List<Todo> _todos = [];

  @override
  void add(Todo todo) {
    _todos.add(todo);
  }

  @override
  List<Todo> getAll() {
    return _todos;
  }

  @override
  void remove(Todo todo) {
    _todos.remove(todo);
  }

  @override
  void toggle(Todo todo) {
    todo.isCompleted = !todo.isCompleted;
  }
}
