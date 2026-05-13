import '../../data/models/task_model.dart';
import '../repositories/task_repository.dart';

class AddTask {
  final TaskRepository _repository;
  AddTask(this._repository);
  Future<TaskModel> call(TaskModel task) => _repository.addTask(task);
}

class UpdateTask {
  final TaskRepository _repository;
  UpdateTask(this._repository);
  Future<void> call(TaskModel task) => _repository.updateTask(task);
}

class DeleteTask {
  final TaskRepository _repository;
  DeleteTask(this._repository);
  Future<void> call(String taskId) => _repository.deleteTask(taskId);
}

class GetTasks {
  final TaskRepository _repository;
  GetTasks(this._repository);
  Stream<List<TaskModel>> call(String userId) => _repository.getTasks(userId);
}
