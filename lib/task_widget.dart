import 'package:flutter/material.dart';
import 'task.dart';

class TaskWidget extends StatelessWidget {
  final Task task;
  final ValueChanged<TaskStatus> onStatusChanged;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  TaskWidget({
    required this.task,
    required this.onStatusChanged,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.status == TaskStatus.completed
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        subtitle: Text('${task.description}, Приоритет: ${_priorityText(task.priority)}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButton<TaskStatus>(
              value: task.status,
              items: [
                DropdownMenuItem(
                  child: Text('В ожидании'),
                  value: TaskStatus.pending,
                ),
                DropdownMenuItem(
                  child: Text('В процессе'),
                  value: TaskStatus.inProgress,
                ),
                DropdownMenuItem(
                  child: Text('Завершено'),
                  value: TaskStatus.completed,
                ),
              ],
              onChanged: (TaskStatus? status) {
                if (status != null) {
                  onStatusChanged(status);
                }
              },
            ),
            PopupMenuButton<String>(
              onSelected: (String result) {
                if (result == 'edit') {
                  onEdit();
                } else if (result == 'delete') {
                  onDelete();
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 8),
                      Text('Редактировать'),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete),
                      SizedBox(width: 8),
                      Text('Удалить'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _priorityText(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.low:
        return 'Низкий';
      case TaskPriority.medium:
        return 'Средний';
      case TaskPriority.high:
        return 'Высокий';
      default:
        return 'Средний';
    }
  }
}