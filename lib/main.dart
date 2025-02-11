import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'roadmap_page.dart';
import 'roadmap.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bucket List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Roadmap> roadmaps = [];

  void _addRoadmap(Roadmap roadmap) {
    setState(() {
      roadmaps.add(roadmap);
    });
  }

  void _deleteRoadmap(int index) {
    setState(() {
      roadmaps.removeAt(index);
    });
  }

  void _editRoadmap(int index, Roadmap roadmap) {
    setState(() {
      roadmaps[index] = roadmap;
    });
  }

  void _updateRoadmaps() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bucket List'),
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
        child: roadmaps.isEmpty
            ? Center(
                child: Text(
                  'No Roadmaps yet! Start by adding a new roadmap.',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              )
            : ListView.builder(
                itemCount: roadmaps.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: ListTile(
                      title: Text(roadmaps[index].title),
                      subtitle: Text('${roadmaps[index].tasks.length} tasks'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomPaint(
                            foregroundPainter: CircleProgressPainter(roadmaps[index].progress),
                            child: SizedBox(
                              width: 40,
                              height: 40,
                              child: Center(
                                child: Text(
                                  '${(roadmaps[index].progress * 100).round()}%',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                          PopupMenuButton<String>(
                            onSelected: (String result) {
                              if (result == 'edit') {
                                _editRoadmap(index, roadmaps[index]);
                              } else if (result == 'delete') {
                                _deleteRoadmap(index);
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
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RoadmapPage(roadmap: roadmaps[index]),
                          ),
                        );
                        _updateRoadmaps();
                      },
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newRoadmap = await showDialog<Roadmap>(
            context: context,
            builder: (BuildContext context) {
              return RoadmapDialog();
            },
          );
          if (newRoadmap != null) {
            _addRoadmap(newRoadmap);
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}

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
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(widget.roadmap == null ? 'New Roadmap' : 'Edit Roadmap'),
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
              final roadmap = Roadmap(title: title, description: description);
              Navigator.of(context).pop(roadmap);
            }
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}

class CircleProgressPainter extends CustomPainter {
  final double progress;

  CircleProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final startAngle = -90.0;
    final sweepAngle = 360.0 * progress;
    final useCenter = false;
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, startAngle * 0.0174533, sweepAngle * 0.0174533, useCenter, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}