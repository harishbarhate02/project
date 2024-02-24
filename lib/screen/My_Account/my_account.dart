// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'My Account Page',
//       theme: ThemeData(
//         primarySwatch: Colors.teal,
//       ),
//       home: MyAccountPage(),
//     );
//   }
// }
//
// class MyAccountPage extends StatefulWidget {
//   @override
//   _MyAccountPageState createState() => _MyAccountPageState();
// }
//
// class _MyAccountPageState extends State<MyAccountPage> {
//   final _formKey = GlobalKey<FormState>();
//   final ImagePicker _picker = ImagePicker();
//   XFile? _image;
//
//   Future<void> _showChoiceDialog(BuildContext context) {
//     return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("Make a Choice!"),
//             content: SingleChildScrollView(
//               child: ListBody(
//                 children: <Widget>[
//                   GestureDetector(
//                     child: Text("Choose from Gallery"),
//                     onTap: () {
//                       _openGallery(context);
//                     },
//                   ),
//                   Padding(padding: EdgeInsets.all(8.0)),
//                   GestureDetector(
//                     child: Text("Take a Photo"),
//                     onTap: () {
//                       _openCamera(context);
//                     },
//                   )
//                 ],
//               ),
//             ),
//           );
//         });
//   }
//
//   void _openGallery(BuildContext context) async {
//     var picture = await _picker.pickImage(source: ImageSource.gallery);
//     this.setState(() {
//       _image = picture;
//     });
//     Navigator.of(context).pop();
//   }
//
//   void _openCamera(BuildContext context) async {
//     var picture = await _picker.pickImage(source: ImageSource.camera);
//     this.setState(() {
//       _image = picture;
//     });
//     Navigator.of(context).pop();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Account'),
//       ),
//       body: Center(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.only(bottom: 20.0),
//                 child: Stack(
//                   children: <Widget>[
//                     CircleAvatar(
//                       radius: 70,
//                       backgroundImage: AssetImage('assets/profile.jpeg'),
//                       backgroundColor: Colors.grey,
//                     ),
//                     Positioned(
//                       right: 5,
//                       bottom: 5,
//                       child: InkWell(
//                         onTap: () {
//                           _showChoiceDialog(context);
//                         },
//                         child: Icon(
//                           Icons.camera_alt,
//                           color: Colors.teal,
//                           size: 28,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width * .4,
//                 child: Column(
//                   children: [
//               TextField(
//                 textAlign: TextAlign.center,
//                 decoration: InputDecoration(hintText: 'Name',
//                     contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                     border:
//                     OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
//                 ),
//               ),
//               TextField(
//                 textAlign: TextAlign.center,
//                 decoration: InputDecoration(hintText: 'Student ID',
//                     contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                     border:
//                     OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
//                 ),
//                 ),
//               TextField(
//                 textAlign: TextAlign.center,
//                 decoration: InputDecoration(hintText: 'Mobile',
//                     contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                     border:
//                     OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
//                 ),
//               ),
//               TextField(
//                 textAlign: TextAlign.center,
//                 decoration: InputDecoration(hintText: 'Email',
//                     contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                     border:
//                     OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
//                 ),
//               ),
//                 ],
//               Padding(
//                 padding: EdgeInsets.only(top: 20.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     ElevatedButton(
//                       onPressed: () {
//                         // Add your edit functionality here
//                       },
//                       child: Text('Edit', style: TextStyle(fontSize: 20)),
//                       style: ElevatedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
//                       ),
//                     ),
//                     SizedBox(width: 10), // Space between the buttons
//                     Flexible(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         if (_formKey.currentState?.validate() ?? false) {
//                           ScaffoldMessenger.of(context)
//                               .showSnackBar(SnackBar(content: Text('Processing Data')));
//                         }
//                       },
//                       child: Text('Save', style: TextStyle(fontSize: 20)),
//                       style: ElevatedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
//                       ),
//                     ),
//                     ),
//
//                   ],
//                 ),
//               ),
//
//
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       );
//   }
// }
