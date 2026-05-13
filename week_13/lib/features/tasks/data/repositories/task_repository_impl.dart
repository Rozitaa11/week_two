import '../../data/datasources/task_firestore_datasource.dart';
import '../../data/models/task_model.dart';
import '../../domain/repositories/task_repository.dart'
    hide TaskFirestoreDataSource;

class TaskRepositoryImpl implements TaskRepository {
  final TaskFirestoreDataSource _dataSource;

  TaskRepositoryImpl(this._dataSource);

  @override
  Future<TaskModel> addTask(TaskModel task) => _dataSource.addTask(task);

  @override
  Future<void> updateTask(TaskModel task) => _dataSource.updateTask(task);

  @override
  Future<void> deleteTask(String taskId) => _dataSource.deleteTask(taskId);

  @override
  Stream<List<TaskModel>> getTasks(String userId) =>
      _dataSource.getTasks(userId);
}
