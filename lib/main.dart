import 'package:bl_todo/service/todo_service_mem.dart';
import 'package:flutter/material.dart';
import 'controller/todo_controller.dart';
import 'model/todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final TodoController _todoController = TodoController(TodoServiceMem());
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Todo App'),
        ),
        body: Column(
          children: [
            TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                labelText: 'Add Todo',
                prefixIcon: Icon(Icons.add),
              ),
              onSubmitted: (value) {
                _addTodo();
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _todoController.todos.length,
                itemBuilder: (BuildContext context, int index) {
                  Todo todo = _todoController.todos[index];
                  return ListTile(
                    leading: Checkbox(
                      value: todo.isCompleted,
                      onChanged: (value) {
                        setState(() {
                          _todoController.toggle(todo);
                        });
                      },
                    ),
                    title: Text(
                      todo.title,
                      style: TextStyle(
                        decoration: todo.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _todoController.remove(todo);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addTodo() {
    String title = _textEditingController.text;
    if (title.isNotEmpty) {
      var todo = Todo(
        title: title,
      );
      _todoController.add(todo.title);
      setState(() {
        _textEditingController.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Title cannot be empty!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
