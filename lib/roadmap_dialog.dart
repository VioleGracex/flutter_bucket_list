import 'package:flutter/material.dart';
import 'roadmap.dart';

class RoadmapDialog extends StatefulWidget {
  final Roadmap? roadmap;

  RoadmapDialog({this.roadmap});

  @override
  _RoadmapDialogState createState() => _RoadmapDialogState();
}

class _RoadmapDialogState extends State<RoadmapDialog> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  RoadmapPriority _priority = RoadmapPriority.medium;

  @override
  void initState() {
    super.initState();
    if (widget.roadmap != null) {
      _titleController.text = widget.roadmap!.title;
      _descriptionController.text = widget.roadmap!.description;
      _priority = widget.roadmap!.priority;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.roadmap == null ? 'Добавить План' : 'Редактировать План'),
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
                DropdownButton<RoadmapPriority>(
                  value: _priority,
                  items: [
                    DropdownMenuItem(
                      child: Text('Низкий'),
                      value: RoadmapPriority.low,
                    ),
                    DropdownMenuItem(
                      child: Text('Средний'),
                      value: RoadmapPriority.medium,
                    ),
                    DropdownMenuItem(
                      child: Text('Высокий'),
                      value: RoadmapPriority.high,
                    ),
                  ],
                  onChanged: (RoadmapPriority? priority) {
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
              final roadmap = Roadmap(
                title: title,
                description: description,
                priority: _priority,
              );
              Navigator.of(context).pop(roadmap);
            }
          },
          child: Text('Сохранить'),
        ),
      ],
    );
  }
}