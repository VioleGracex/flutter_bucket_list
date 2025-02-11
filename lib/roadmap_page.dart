import 'package:flutter/material.dart';
import 'roadmap.dart';
import 'task.dart';

class RoadmapPage extends StatefulWidget {
  final Roadmap roadmap;

  RoadmapPage({required this.roadmap});

  @override
  _RoadmapPageState createState() => _RoadmapPageState();
}

class _RoadmapPageState extends State<RoadmapPage> {
  void _addTask(Task task) {
    setState(() {
      widget.roadmap.tasks.add(task);
      widget.roadmap.calculateProgress();
    });
  }

  void _updateTask(Task task, TaskStatus status) {
    setState(() {
      task.status = status;
      widget.roadmap.calculateProgress();
    });
  }

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
                        _updateTask(widget.roadmap.tasks[index], status);
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final newTask = await showDialog<Task>(
                    context: context,
                    builder: (BuildContext context) {
                      return TaskDialog();
                    },
                  );
                  if (newTask != null) {
                    _addTask(newTask);
                  }
                },
                child: Text('Add Task'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}