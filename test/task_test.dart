import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_internship_tracker/models/task.dart';
import 'package:mobile_internship_tracker/repository/task_repository.dart';

void main() {
  group('Task Repository Tests', () {
    late TaskRepository repository;

    setUp(() {
      repository = TaskRepository();
    });

    test('Add Task', () {
      final task = Task(id: 1, title: "Test", description: "Testing");
      repository.addTask(task);

      expect(repository.getAllTasks().length, 1);
    });

    test('Delete Task', () {
      final task = Task(id: 1, title: "Test", description: "Testing");
      repository.addTask(task);

      repository.deleteTask(1);

      expect(repository.getAllTasks().isEmpty, true);
    });

    test('Update Task Status', () {
      final task = Task(id: 1, title: "Test", description: "Testing");
      repository.addTask(task);

      repository.updateTaskStatus(1, TaskStatus.completed);

      expect(repository.getTaskById(1)?.status, TaskStatus.completed);
    });
  });
}
