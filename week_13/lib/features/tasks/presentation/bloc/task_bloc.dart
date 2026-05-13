import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/task_model.dart';
import '../../domain/usecases/add_task.dart';
import '../../domain/usecases/delete_task.dart';

import '../../domain/usecases/update_task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final AddTask addTask;
  final UpdateTask updateTask;
  final DeleteTask deleteTask;
  final GetTasks getTasks;

  StreamSubscription<List<TaskModel>>? _taskSubscription;

  TaskBloc({
    required this.addTask,
    required this.updateTask,
    required this.deleteTask,
    required this.getTasks,
  }) : super(TaskInitial()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTaskRequested>(_onAddTask);
    on<UpdateTaskRequested>(_onUpdateTask);
    on<DeleteTaskRequested>(_onDeleteTask);
    on<ToggleTaskCompletion>(_onToggleCompletion);
  }

  void _onLoadTasks(LoadTasks event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    await _taskSubscription?.cancel();

    await emit.forEach<List<TaskModel>>(
      getTasks(event.userId),
      onData: (tasks) => TaskLoaded(tasks),
      onError: (_, __) => TaskError('Failed to load tasks'),
    );
  }

  Future<void> _onAddTask(
    AddTaskRequested event,
    Emitter<TaskState> emit,
  ) async {
    try {
      await addTask(event.task);
      // Stream update will trigger TaskLoaded automatically
    } catch (e) {
      emit(TaskError('Failed to add task: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateTask(
    UpdateTaskRequested event,
    Emitter<TaskState> emit,
  ) async {
    try {
      await updateTask(event.task);
    } catch (e) {
      emit(TaskError('Failed to update task: ${e.toString()}'));
    }
  }

  Future<void> _onDeleteTask(
    DeleteTaskRequested event,
    Emitter<TaskState> emit,
  ) async {
    try {
      await deleteTask(event.taskId);
    } catch (e) {
      emit(TaskError('Failed to delete task: ${e.toString()}'));
    }
  }

  Future<void> _onToggleCompletion(
    ToggleTaskCompletion event,
    Emitter<TaskState> emit,
  ) async {
    final updated = event.task.copyWith(isCompleted: !event.task.isCompleted);
    await updateTask(updated);
  }

  @override
  Future<void> close() {
    _taskSubscription?.cancel();
    return super.close();
  }
}
