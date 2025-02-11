enum TaskPriority { low, medium, high }

enum TaskStatus { pending, inProgress, completed }

class Task {
  String title;
  String description;
  TaskStatus status;
  TaskPriority priority;

  Task({
    required this.title,
    required this.description,
    this.status = TaskStatus.pending,
    this.priority = TaskPriority.medium,
  });
}