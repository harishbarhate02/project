// import 'package:flutter/material.dart';
//
// import '../Rooms_Labs/Room_lab.dart';
//
// class AddRoomLabDialog extends StatefulWidget {
//   const AddRoomLabDialog({super.key});
//
//   @override
//   AddRoomLabDialogState createState() => AddRoomLabDialogState();
// }
//
// class AddRoomLabDialogState extends State<AddRoomLabDialog> {
//   String _selectedCategory = 'Room'; // Default selection for dropdown
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _capacityController = TextEditingController();
//   final TextEditingController _idController = TextEditingController();
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _capacityController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('Add New Room/Lab'),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           TextField(
//             controller: _idController,
//             decoration: const InputDecoration(labelText: 'Name'),
//           ),
//           const SizedBox(height: 10),
//           TextField(
//             controller: _nameController,
//             decoration: const InputDecoration(labelText: 'Name'),
//           ),
//           const SizedBox(height: 10),
//           DropdownButtonFormField<String>(
//             value: _selectedCategory,
//             onChanged: (String? newValue) {
//               setState(() {
//                 _selectedCategory = newValue!;
//               });
//             },
//             items: <String>['Room', 'Lab'].map<DropdownMenuItem<String>>(
//               (String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               },
//             ).toList(),
//           ),
//           const SizedBox(height: 10),
//           TextField(
//             controller: _capacityController,
//             decoration: const InputDecoration(labelText: 'Capacity'),
//             keyboardType: TextInputType.number,
//           ),
//         ],
//       ),
//       actions: <Widget>[
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: const Text('Cancel'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             // Here you can use the values entered in the text fields and dropdown
//             String name = _nameController.text;
//             String id = _idController.text;
//             String category = _selectedCategory;
//             int capacity = int.tryParse(_capacityController.text) ?? 0;
//
//             // Add logic to save room/lab details
//             // For example: call a function to handle the data
//             var x = Room(
//                 id: id, name: name, capacity: capacity, category: category);
//
//             Navigator.of(context).pop();
//           },
//           child: const Text('Save'),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../Rooms_Labs/Room_lab.dart';

class AddRoomLabDialog extends StatefulWidget {
  const AddRoomLabDialog({Key? key});

  @override
  AddRoomLabDialogState createState() => AddRoomLabDialogState();
}

class AddRoomLabDialogState extends State<AddRoomLabDialog> {
  String _selectedCategory = 'Room'; // Default selection for dropdown
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController();
  final TextEditingController _idController = TextEditingController();

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
      content: Container(
        width: 200, // Set the desired width
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _idController,
              decoration: const InputDecoration(labelText: 'ID'),
            ),
            const SizedBox(height: 10),
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
            String id = _idController.text;
            String category = _selectedCategory;
            int capacity = int.tryParse(_capacityController.text) ?? 0;

            // Add logic to save room/lab details
            // For example: call a function to handle the data
            var x = Room(
                id: id, name: name, capacity: capacity, category: category);

            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
