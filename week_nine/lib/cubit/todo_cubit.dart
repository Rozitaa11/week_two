import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:week_nine/cubit/todo_state.dart';
import 'package:week_nine/models/todo.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoState([]));

  void addTodo(String title) {
    if (title.trim().isEmpty) return;

    final updated = List<Todo>.from(state.todos)..add(Todo(title: title));

    emit(TodoState(updated));
  }

  void deleteTodo(int index) {
    final updated = List<Todo>.from(state.todos)..removeAt(index);

    emit(TodoState(updated));
  }

  void toggleTodo(int index) {
    final updated = List<Todo>.from(state.todos);

    updated[index] = updated[index].copyWith(
      isDone: !updated[index].isDone,
    );

    emit(TodoState(updated));
  }
}
