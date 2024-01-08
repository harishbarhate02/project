import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AddTimeSlotScreen(),
    );
  }
}

class AddTimeSlotScreen extends StatelessWidget {
  const AddTimeSlotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Time Slot'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AddTimeSlotDialog();
              },
            );
          },
          child: const Text('Add New Time Slot'),
        ),
      ),
    );
  }
}

class AddTimeSlotDialog extends StatefulWidget {
  const AddTimeSlotDialog({super.key});

  @override
  _AddTimeSlotDialogState createState() => _AddTimeSlotDialogState();
}

class _AddTimeSlotDialogState extends State<AddTimeSlotDialog> {
  final TextEditingController _timeSlotController = TextEditingController();

  @override
  void dispose() {
    _timeSlotController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Time Slot'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _timeSlotController,
            decoration: const InputDecoration(labelText: 'Time Slot'),
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
            // Here you can use the value entered in the text field
            String timeSlot = _timeSlotController.text;

            // Add logic to save time slot details
            // For example: call a function to handle the data
            saveTimeSlotDetails(timeSlot);

            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }

  void saveTimeSlotDetails(String timeSlot) {
    // Implement your logic here to save time slot details
    // This could be API calls, database operations, etc.
    // print('Time Slot: $timeSlot');
  }
}

