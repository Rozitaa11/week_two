import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:week_nine/cubit/todo_cubit.dart';
import 'package:week_nine/cubit/todo_state.dart';

class HomePage extends StatelessWidget {
  final controller = TextEditingController();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo BLoC App"),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Enter task",
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (controller.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Task required"),
                        ),
                      );
                      return;
                    }

                    context.read<TodoCubit>().addTodo(controller.text);

                    controller.clear();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<TodoCubit, TodoState>(
              builder: (context, state) {
                if (state.todos.isEmpty) {
                  return Center(
                    child: Text("No tasks yet"),
                  );
                }

                return ListView.builder(
                  itemCount: state.todos.length,
                  itemBuilder: (context, index) {
                    final todo = state.todos[index];

                    return ListTile(
                      leading: Checkbox(
                        value: todo.isDone,
                        onChanged: (_) {
                          context.read<TodoCubit>().toggleTodo(index);
                        },
                      ),
                      title: Text(
                        todo.title,
                        style: TextStyle(
                          decoration:
                              todo.isDone ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          context.read<TodoCubit>().deleteTodo(index);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
