import 'task.dart';

class Roadmap {
  String title;
  String description;
  List<Task> tasks;
  double progress;

  Roadmap({
    required this.title,
    required this.description,
    this.tasks = const [],
    this.progress = 0.0,
  });

  void calculateProgress() {
    if (tasks.isEmpty) {
      progress = 0.0;
    } else {
      int completedTasks = tasks.where((task) => task.status == TaskStatus.completed).length;
      progress = completedTasks / tasks.length;
    }
  }
}