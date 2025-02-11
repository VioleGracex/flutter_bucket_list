import 'task.dart';

enum RoadmapPriority { low, medium, high }

class Roadmap {
  String title;
  String description;
  List<Task> tasks;
  double progress;
  RoadmapPriority priority;

  Roadmap({
    required this.title,
    required this.description,
    List<Task>? tasks,
    this.progress = 0.0,
    this.priority = RoadmapPriority.medium,
  }) : tasks = tasks ?? [];

  void calculateProgress() {
    if (tasks.isEmpty) {
      progress = 0.0;
    } else {
      int completedTasks = tasks.where((task) => task.status == TaskStatus.completed).length;
      progress = completedTasks / tasks.length;
    }
  }
}