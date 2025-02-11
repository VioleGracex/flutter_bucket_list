class Task {
  String title;
  String description;
  TaskStatus status;

  Task({
    required this.title,
    this.description = '',
    this.status = TaskStatus.pending,
  });
}

enum TaskStatus {
  pending,
  inProgress,
  finished,
}