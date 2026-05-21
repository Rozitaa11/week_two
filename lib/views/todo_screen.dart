import 'package:flutter/material.dart';
import '../controllers/todo_controller.dart';
import '../models/todo.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TodoController _controller = TodoController();
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.fetchTodosSample();
  }

  @override
  void dispose() {
    // CRITICAL PERF: explicit disposal avoids background allocation leaks
    _textController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onSaveSubmitted() {
    if (_textController.text.isNotEmpty) {
      _controller.addTodo(_textController.text);
      _textController.clear();
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('todo_screen_scaffold'),
      appBar: AppBar(
        title: const Text('Audited Task Suite'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    key: const Key('todo_input_field'),
                    controller: _textController,
                    decoration: const InputDecoration(
                      labelText: 'Enter mission milestone item...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _onSaveSubmitted(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  key: const Key('todo_add_button'),
                  icon: const Icon(Icons.send),
                  onPressed: _onSaveSubmitted,
                ),
              ],
            ),
          ),
          Expanded(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                if (_controller.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (_controller.todos.isEmpty) {
                  return const Center(
                    child: Text('All metrics optimal. Complete!'),
                  );
                }

                return ListView.builder(
                  itemCount: _controller.todos.length,
                  itemBuilder: (context, index) {
                    final item = _controller.todos[index];
                    // Performance optimization: Extracted into a const sub-widget
                    return TodoItemTile(
                      key: ValueKey(item.id),
                      item: item,
                      onToggle: _controller.toggleTodoStatus,
                      onDelete: _controller.removeTodo,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Extracted Const Component to isolate widget rebuild trees efficiently
class TodoItemTile extends StatelessWidget {
  final Todo item;
  final ValueChanged<String> onToggle;
  final ValueChanged<String> onDelete;

  const TodoItemTile({
    super.key,
    required this.item,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: Key('todo_tile_${item.id}'),
      leading: Checkbox(
        key: Key('todo_check_${item.id}'),
        value: item.isCompleted,
        onChanged: (_) => onToggle(item.id),
      ),
      title: Text(
        item.title,
        style: TextStyle(
          decoration: item.isCompleted ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: IconButton(
        key: Key('todo_delete_${item.id}'),
        icon: const Icon(Icons.delete_outline, color: Colors.red),
        onPressed: () => onDelete(item.id),
      ),
    );
  }
}
