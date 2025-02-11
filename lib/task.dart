import 'package:flutter/material.dart';

enum TaskStatus { pending, inProgress, finished }

class Task {
  String title;
  String description;
  TaskStatus status;

  Task({required this.title, required this.description, required this.status});
}

class TaskWidget extends StatelessWidget {
  final Task task;
  final ValueChanged<TaskStatus> onStatusChanged;

  TaskWidget({required this.task, required this.onStatusChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.status == TaskStatus.finished
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        subtitle: Text(task.description),
        trailing: DropdownButton<TaskStatus>(
          value: task.status,
          items: [
            DropdownMenuItem(
              child: Text('Pending'),
              value: TaskStatus.pending,
            ),
            DropdownMenuItem(
              child: Text('In Progress'),
              value: TaskStatus.inProgress,
            ),
            DropdownMenuItem(
              child: Text('Finished'),
              value: TaskStatus.finished,
            ),
          ],
          onChanged: (TaskStatus? status) {
            if (status != null) {
              onStatusChanged(status);
            }
          },
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                title: Text(task.title),
                content: Text(task.description),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Close'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class TaskDialog extends StatefulWidget {
  @override
  _TaskDialogState createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text('New Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(labelText: 'Description'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final title = _titleController.text;
            final description = _descriptionController.text;
            if (title.isNotEmpty) {
              final newTask = Task(
                title: title,
                description: description,
                status: TaskStatus.pending,
              );
              Navigator.of(context).pop(newTask);
            }
          },
          child: Text('Create'),
        ),
      ],
    );
  }
}