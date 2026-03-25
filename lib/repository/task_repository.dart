import '../models/task.dart';

class TaskRepository {
  final List<Task> _tasks = [];

  void addTask(Task task) {
    _tasks.add(task);
  }

  List<Task> getAllTasks() {
    return _tasks;
  }

  Task? getTaskById(int id) {
    try {
      return _tasks.firstWhere((task) => task.id == id);
    } catch (e) {
      return null;
    }
  }

  void deleteTask(int id) {
    _tasks.removeWhere((task) => task.id == id);
  }

  void updateTaskStatus(int id, TaskStatus status) {
    final task = getTaskById(id);
    if (task != null) {
      task.status = status;
    }
  }
}
