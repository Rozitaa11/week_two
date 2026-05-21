import 'package:flutter/material.dart';
import '../controllers/todo_controller.dart';

class TodoScreen extends StatefulWidget {
  final TodoController controller;

  const TodoScreen({
    super.key,
    required this.controller,
  });

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: AnimatedBuilder(
        animation: widget.controller,
        builder: (context, _) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        key: const Key('todoField'),
                        controller: textController,
                        decoration: const InputDecoration(
                          hintText: 'Enter todo',
                        ),
                      ),
                    ),
                    ElevatedButton(
                      key: const Key('addButton'),
                      onPressed: () {
                        widget.controller.addTodo(
                          textController.text,
                        );
                        textController.clear();
                      },
                      child: const Text('Add'),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.controller.todos.length,
                  itemBuilder: (context, index) {
                    final todo = widget.controller.todos[index];

                    return ListTile(
                      title: Text(todo.title),
                      trailing: Checkbox(
                        value: todo.completed,
                        onChanged: (_) {
                          widget.controller.toggleTodo(index);
                        },
                      ),
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
