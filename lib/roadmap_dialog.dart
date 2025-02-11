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

  @override
  void initState() {
    super.initState();
    if (widget.roadmap != null) {
      _titleController.text = widget.roadmap!.title;
      _descriptionController.text = widget.roadmap!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                final title = _titleController.text;
                final description = _descriptionController.text;
                if (title.isNotEmpty) {
                  final roadmap = Roadmap(title: title, description: description);
                  Navigator.of(context).pop(roadmap);
                }
              },
              child: Text('Save'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                textStyle: TextStyle(fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}