enum TaskStatus { pending, inProgress, completed }

class Task {
  final int id;
  String title;
  String description;
  TaskStatus status;
  DateTime createdAt;

  Task({
    required this.id,
    required this.title,
    required this.description,
    this.status = TaskStatus.pending,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  void markCompleted() {
    status = TaskStatus.completed;
  }

  @override
  String toString() {
    return 'Task(id: $id, title: $title, status: $status)';
  }
}
