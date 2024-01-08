import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AddRoomLabScreen(),
    );
  }
}

class AddRoomLabScreen extends StatelessWidget {
  const AddRoomLabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Room/Lab'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AddRoomLabDialog();
              },
            );
          },
          child: const Text('Add New Room/Lab'),
        ),
      ),
    );
  }
}

class AddRoomLabDialog extends StatefulWidget {
  const AddRoomLabDialog({super.key});

  @override
  _AddRoomLabDialogState createState() => _AddRoomLabDialogState();
}

class _AddRoomLabDialogState extends State<AddRoomLabDialog> {
  String _selectedCategory = 'Room'; // Default selection for dropdown
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _capacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Room/Lab'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: _selectedCategory,
            onChanged: (String? newValue) {
              setState(() {
                _selectedCategory = newValue!;
              });
            },
            items: <String>['Room', 'Lab'].map<DropdownMenuItem<String>>(
                  (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              },
            ).toList(),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _capacityController,
            decoration: const InputDecoration(labelText: 'Capacity'),
            keyboardType: TextInputType.number,
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
            // Here you can use the values entered in the text fields and dropdown
            String name = _nameController.text;
            String category = _selectedCategory;
            int capacity = int.tryParse(_capacityController.text) ?? 0;

            // Add logic to save room/lab details
            // For example: call a function to handle the data
            saveRoomLabDetails(name, category, capacity);

            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }

  void saveRoomLabDetails(String name, String category, int capacity) {
    // Implement your logic here to save room/lab details
    // This could be API calls, database operations, etc.
    print('Name: $name, Category: $category, Capacity: $capacity');
  }
}

