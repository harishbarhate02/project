import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AddClassScreen(),
    );
  }
}

class AddClassScreen extends StatelessWidget {
  const AddClassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Class'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AddClassDialog();
              },
            );
          },
          child: const Text('Add New Class'),
        ),
      ),
    );
  }
}

class AddClassDialog extends StatefulWidget {
  const AddClassDialog({super.key});

  @override
  _AddClassDialogState createState() => _AddClassDialogState();
}

class _AddClassDialogState extends State<AddClassDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _strengthController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _strengthController.dispose();
    _courseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Class'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _strengthController,
            decoration: const InputDecoration(labelText: 'Strength'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _courseController,
            decoration: const InputDecoration(labelText: 'Course'),
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
            String name = _nameController.text;
            int strength = int.tryParse(_strengthController.text) ?? 0;
            String course = _courseController.text;

            // Add logic to save class details
            // For example: call a function to handle the data
            saveClassDetails(name, strength, course);

            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }

  void saveClassDetails(String name, int strength, String course) {
    // Implement your logic here to save class details
    // This could be API calls, database operations, etc.
    // print('Name: $name, Strength: $strength, Course: $course');
  }
}

