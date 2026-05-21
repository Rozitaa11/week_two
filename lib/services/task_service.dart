import '../models/task.dart';
import '../repository/task_repository.dart';

class TaskService {
  final TaskRepository repository;

  TaskService(this.repository);

  void createTask(int id, String title, String description) {
    final task = Task(id: id, title: title, description: description);
    repository.addTask(task);
  }

  List<Task> fetchTasks() {
    return repository.getAllTasks();
  }

  void completeTask(int id) {
    repository.updateTaskStatus(id, TaskStatus.completed);
  }
}
