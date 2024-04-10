// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: AddCourseScreen(),
//     );
//   }
// }
//
// class AddCourseScreen extends StatelessWidget {
//   const AddCourseScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add New Course'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return AddCourseDialog();
//               },
//             );
//           },
//           child: const Text('Add New Course'),
//         ),
//       ),
//     );
//   }
// }
//
// class AddCourseDialog extends StatelessWidget {
//   const AddCourseDialog({super.key});
//
//   // @override
//   // _AddCourseDialogState createState() => _AddCourseDialogState();
//   //
//   // @override
//   // Widget build(BuildContext context) {
//   // TODO: implement build
//   //   throw UnimplementedError();
//   // }
//
// // class _AddCourseDialogState extends State<AddCourseDialog> {
// //   final TextEditingController _nameController = TextEditingController();
// //   final TextEditingController _codeController = TextEditingController();
// //   final TextEditingController _fnameController = TextEditingController();
//
//   // @override
//   // void dispose() {
//   //   _nameController.dispose();
//   //   _codeController.dispose();
//   //   _fnameController.dispose();
//   //   super.dispose();
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('Add New Course'),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           TextFormField(
//             // controller: _nameController,
//             decoration: const InputDecoration(labelText: 'Course Name'),
//           ),
//           const SizedBox(height: 10),
//           TextField(
//             // controller: _codeController,
//             decoration: const InputDecoration(labelText: 'Course Code'),
//           ),
//           const SizedBox(height: 10),
//           TextField(
//             // controller: _fnameController,
//             decoration: const InputDecoration(labelText: 'Faculty Name'),
//           ),
//         ],
//       ),
//       actions: <Widget>[
//         ElevatedButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: const Text('Save'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             // Here you can use the values entered in the text fields
//             // String courseName = _nameController.text;
//             // String courseCode = _codeController.text;
//             // String facultyName = _fnameController.text;
//
//             // Add logic to save course details
//             // For example: call a function to handle the data
//             // saveCourseDetails(courseName, courseCode, facultyName);
//
//             Navigator.of(context).pop();
//           },
//           child: const Text('Cancel'),
//         ),
//       ],
//     );
//   }
// }
// // void saveCourseDetails(
// //     String courseName, String courseCode, String facultyName) {
// //   // Implement your logic here to save course details
// //   // This could be API calls, database operations, etc.
// //   // print('Course Name: $courseName, Course Code: $courseCode, Faculty Name: $facultyName');
// // }
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

class AddCourseDialog extends StatefulWidget {
  const AddCourseDialog({Key? key});

  @override
  AddCourseDialogState createState() => AddCourseDialogState();
}

class AddCourseDialogState extends State<AddCourseDialog> {
  String _selectedCategory = 'Course'; // Default selection for dropdown
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();

  @override
  void dispose() {
    // _nameController.dispose();
    _fnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Course'),
      content: Container(
        width: 200, // Set the desired width
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _idController,
              decoration: const InputDecoration(labelText: 'Code'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _fnameController,
              decoration: const InputDecoration(labelText: 'Fname'),
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
            String fname = _fnameController.text;

            // Add logic to save room/lab details
            // For example: call a function to handle the data

            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
