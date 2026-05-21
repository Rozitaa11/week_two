import 'package:flutter/material.dart';
import '../models/todo.dart';

class TodoController extends ChangeNotifier {
  final List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  void addTodo(String title) {
    if (title.isEmpty) return;

    _todos.add(Todo(title: title));
    notifyListeners();
  }

  void toggleTodo(int index) {
    _todos[index].toggle();
    notifyListeners();
  }

  void removeTodo(int index) {
    _todos.removeAt(index);
    notifyListeners();
  }
}
