class Task {
  String title;
  String description;
  TaskStatus status;

  Task({
    required this.title,
    required this.description,
    this.status = TaskStatus.pending,
  });
}

enum TaskStatus { pending, inProgress, completed }