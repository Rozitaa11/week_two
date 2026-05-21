import 'package:flutter/material.dart';
import 'package:week_nine/models/todo.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;
  final VoidCallback onDelete;
  final VoidCallback onToggle;

  const TodoTile({
    super.key,
    required this.todo,
    required this.onDelete,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: todo.isDone,
        onChanged: (_) => onToggle(),
      ),
      title: Text(
        todo.title,
        style: TextStyle(
          decoration: todo.isDone ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: onDelete,
      ),
    );
  }
}
