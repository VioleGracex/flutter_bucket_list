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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      backgroundColor: Colors.blue[100],
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      title: Text(
        widget.task == null ? 'Добавить Задачу' : 'Редактировать Задачу',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueAccent),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  icon: Icon(Icons.title, color: Colors.blueAccent),
                  labelText: 'Название',
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  icon: Icon(Icons.description, color: Colors.blueAccent),
                  labelText: 'Описание',
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Приоритет:', style: TextStyle(fontSize: 16, color: Colors.blueAccent)),
                SizedBox(width: 10),
                DropdownButton<TaskPriority>(
                  value: _priority,
                  dropdownColor: Colors.blue[100],
                  items: [
                    DropdownMenuItem(
                      child: Text('Низкий', style: TextStyle(color: Colors.blueAccent)),
                      value: TaskPriority.low,
                    ),
                    DropdownMenuItem(
                      child: Text('Средний', style: TextStyle(color: Colors.blueAccent)),
                      value: TaskPriority.medium,
                    ),
                    DropdownMenuItem(
                      child: Text('Высокий', style: TextStyle(color: Colors.blueAccent)),
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
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Отмена', style: TextStyle(color: Colors.blueAccent)),
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}