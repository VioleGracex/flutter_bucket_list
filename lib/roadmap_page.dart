import 'package:flutter/material.dart';
import 'roadmap.dart';
import 'task.dart'; // Ensure Task class is imported
import 'task_widget.dart'; // Ensure TaskWidget class is imported

class RoadmapPage extends StatefulWidget {
  final Roadmap roadmap;

  RoadmapPage({required this.roadmap});

  @override
  _RoadmapPageState createState() => _RoadmapPageState();
}

class _RoadmapPageState extends State<RoadmapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.roadmap.title),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[100]!, Colors.blue[300]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              LinearProgressIndicator(
                value: widget.roadmap.progress,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.roadmap.tasks.length,
                  itemBuilder: (context, index) {
                    return TaskWidget(
                      task: widget.roadmap.tasks[index],
                      onStatusChanged: (status) {
                        setState(() {
                          widget.roadmap.tasks[index].status = status;
                          widget.roadmap.calculateProgress();
                        });
                      },
                      onEdit: () async {
                        final editedTask = await showDialog<Task>(
                          context: context,
                          builder: (BuildContext context) {
                            return TaskDialog(task: widget.roadmap.tasks[index]);
                          },
                        );
                        if (editedTask != null) {
                          setState(() {
                            widget.roadmap.tasks[index] = editedTask;
                            widget.roadmap.calculateProgress();
                          });
                        }
                      },
                      onDelete: () {
                        setState(() {
                          widget.roadmap.tasks.removeAt(index);
                          widget.roadmap.calculateProgress();
                        });
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () async {
                  final newTask = await showDialog<Task>(
                    context: context,
                    builder: (BuildContext context) {
                      return TaskDialog();
                    },
                  );
                  if (newTask != null) {
                    setState(() {
                      widget.roadmap.tasks.add(newTask);
                      widget.roadmap.calculateProgress();
                    });
                  }
                },
                icon: Icon(Icons.add),
                label: Text('Add Task'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}