import 'package:flutter/material.dart';
import 'task.dart';

class TaskDialog extends StatefulWidget {
  final Task? task;

  TaskDialog({this.task});

  @override
  _TaskDialogState createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  TaskPriority _priority = TaskPriority.medium;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
      _priority = widget.task!.priority;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.task == null ? 'Добавить Задачу' : 'Редактировать Задачу'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                icon: Icon(Icons.title),
                labelText: 'Название',
              ),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                icon: Icon(Icons.description),
                labelText: 'Описание',
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Приоритет:', style: TextStyle(fontSize: 16)),
                SizedBox(width: 10),
                DropdownButton<TaskPriority>(
                  value: _priority,
                  items: [
                    DropdownMenuItem(
                      child: Text('Низкий'),
                      value: TaskPriority.low,
                    ),
                    DropdownMenuItem(
                      child: Text('Средний'),
                      value: TaskPriority.medium,
                    ),
                    DropdownMenuItem(
                      child: Text('Высокий'),
                      value: TaskPriority.high,
                    ),
                  ],
                  onChanged: (TaskPriority? priority) {
                    setState(() {
                      _priority = priority!;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Отмена'),
        ),
        ElevatedButton(
          onPressed: () {
            final title = _titleController.text;
            final description = _descriptionController.text;
            if (title.isNotEmpty) {
              final task = Task(
                title: title,
                description: description,
                priority: _priority,
              );
              Navigator.of(context).pop(task);
            }
          },
          child: Text('Сохранить'),
        ),
      ],
    );
  }
}