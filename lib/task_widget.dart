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
            decoration: task.status == TaskStatus.finished
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        subtitle: Text(task.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButton<TaskStatus>(
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
                      Text('Edit'),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete),
                      SizedBox(width: 8),
                      Text('Delete'),
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
}

class TaskDialog extends StatefulWidget {
  final Task? task;

  TaskDialog({this.task});

  @override
  _TaskDialogState createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(widget.task == null ? 'New Task' : 'Edit Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              icon: Icon(Icons.title),
              labelText: 'Title',
            ),
          ),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(
              icon: Icon(Icons.description),
              labelText: 'Description',
            ),
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
              final task = Task(
                title: title,
                description: description,
                status: widget.task?.status ?? TaskStatus.pending,
              );
              Navigator.of(context).pop(task);
            }
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}