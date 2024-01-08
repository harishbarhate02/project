import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AddCourseScreen(),
    );
  }
}

class AddCourseScreen extends StatelessWidget {
  const AddCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Course'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AddCourseDialog();
              },
            );
          },
          child: const Text('Add New Course'),
        ),
      ),
    );
  }
}

class AddCourseDialog extends StatefulWidget {
  const AddCourseDialog({super.key});

  @override
  _AddCourseDialogState createState() => _AddCourseDialogState();
}

class _AddCourseDialogState extends State<AddCourseDialog> {
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _courseCodeController = TextEditingController();
  final TextEditingController _facultyNameController = TextEditingController();

  @override
  void dispose() {
    _courseNameController.dispose();
    _courseCodeController.dispose();
    _facultyNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Course'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _courseNameController,
            decoration: const InputDecoration(labelText: 'Course Name'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _courseCodeController,
            decoration: const InputDecoration(labelText: 'Course Code'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _facultyNameController,
            decoration: const InputDecoration(labelText: 'Faculty Name'),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // Here you can use the values entered in the text fields
            String courseName = _courseNameController.text;
            String courseCode = _courseCodeController.text;
            String facultyName = _facultyNameController.text;

            // Add logic to save course details
            // For example: call a function to handle the data
            saveCourseDetails(courseName, courseCode, facultyName);

            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }

  void saveCourseDetails(String courseName, String courseCode, String facultyName) {
    // Implement your logic here to save course details
    // This could be API calls, database operations, etc.
    // print('Course Name: $courseName, Course Code: $courseCode, Faculty Name: $facultyName');
  }
}

