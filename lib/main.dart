import 'models/task.dart';
import 'repository/task_repository.dart';
import 'services/task_service.dart';

void main() {
  final repo = TaskRepository();
  final service = TaskService(repo);

  service.createTask(1, "Learn Dart", "Study OOP concepts");
  service.createTask(2, "Build App", "Create Flutter UI");

  service.completeTask(1);

  final tasks = service.fetchTasks();

  for (var task in tasks) {
    print(task);
  }
}
