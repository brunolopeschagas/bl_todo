import '../model/todo.dart';
import '../service/todo_service.dart';
import 'package:flutter/material.dart';

class TodoController {
  TodoService? _todoService;
  List<Todo> _todos = [];

  TodoController(TodoService todoService) {
    _todoService = todoService;
  }

  List<Todo> get todos => _todos;

  void add(BuildContext context, String title) {
    if (title.isNotEmpty) {
      var todo = Todo(
        title: title,
      );
      _todoService?.add(todo);
      _todos.add(todo);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Title cannot be empty!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void remove(Todo todo) {
    _todoService?.remove(todo);
    _todos.remove(todo);
  }

  void toggle(Todo todo) {
    _todoService?.toggle(todo);
    _todos = _todoService!.getAll();
  }
}
