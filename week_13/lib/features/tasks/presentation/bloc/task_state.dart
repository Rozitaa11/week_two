part of 'task_bloc.dart';

abstract class TaskEvent {}

class LoadTasks extends TaskEvent {
  final String userId;
  LoadTasks(this.userId);
}

class AddTaskRequested extends TaskEvent {
  final TaskModel task;
  AddTaskRequested(this.task);
}

class UpdateTaskRequested extends TaskEvent {
  final TaskModel task;
  UpdateTaskRequested(this.task);
}

class DeleteTaskRequested extends TaskEvent {
  final String taskId;
  DeleteTaskRequested(this.taskId);
}

class ToggleTaskCompletion extends TaskEvent {
  final TaskModel task;
  ToggleTaskCompletion(this.task);
}
