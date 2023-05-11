import '../model/todo.dart';

abstract class TodoService {
  List<Todo> getAll();
  void add(Todo todo);
  void remove(Todo todo);
  void toggle(Todo todo);
}
