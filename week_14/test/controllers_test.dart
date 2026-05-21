import 'package:flutter_test/flutter_test.dart';
import 'package:week_14/controllers/todo_controller.dart';

void main() {
  group('TodoController Tests', () {
    late TodoController controller;

    setUp(() {
      controller = TodoController();
    });

    test('Add todo', () {
      controller.addTodo('Study Flutter');

      expect(controller.todos.length, 1);
      expect(controller.todos.first.title, 'Study Flutter');
    });

    test('Toggle todo', () {
      controller.addTodo('Test');

      controller.toggleTodo(0);

      expect(controller.todos.first.completed, true);
    });

    test('Remove todo', () {
      controller.addTodo('Delete me');

      controller.removeTodo(0);

      expect(controller.todos.isEmpty, true);
    });
  });
}
