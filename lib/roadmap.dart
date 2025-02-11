import 'task.dart';

class Roadmap {
  String title;
  String description;
  List<Task> tasks = [];
  double progress = 0.0;

  Roadmap({required this.title, this.description = ''});

  void calculateProgress() {
    if (tasks.isEmpty) {
      progress = 0.0;
    } else {
      int completedTasks = tasks.where((task) => task.status == TaskStatus.finished).length;
      progress = completedTasks / tasks.length;
    }
  }
}