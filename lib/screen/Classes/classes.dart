import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Class {
  final String id;
  late String classname;
  late String strength;
  late String course;

  factory Class.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    return Class(
      id: doc.data()!['id'] ?? '',
      classname: doc.data()!['classname'] ?? '',
      strength: doc.data()!['strength'] ?? '',
      course: doc.data()!['course'] ?? '',
    );
  }

  Class({
    required this.id,
    required this.classname,
    required this.strength,
    required this.course,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'classname': classname,
      'strength': strength,
      'course': course,
    };
  }
}

class ClassLabs extends StatefulWidget {
  const ClassLabs({super.key});

  @override
  State<ClassLabs> createState() => _ClassLabsState();
}

class _ClassLabsState extends State<ClassLabs> {
  final _class = <Class>[]; // List to store Classes
  final _firestore = FirebaseFirestore.instance;
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _classnameController = TextEditingController();
  final TextEditingController _strengthController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();
  @override
  void dispose() {
    _idController.dispose();
    _classnameController.dispose();
    _strengthController.dispose();
    _courseController.dispose();
    super.dispose();
  }

  Future<void> _fetchClasses() async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('Classes')
        .get();
    _class.clear();
    for (final doc in snapshot.docs) {
      if (doc.exists) {
        _class.add(Class(
          id: doc.id,
          classname: doc.data()['classname'] as String? ?? '',
          strength: doc.data()['strength'] as String? ?? '',
          course: doc.data()['course'] as String? ?? '',
        ));
      }
    }
    setState(() {});
  }

  Future<void> addClass(Class classes) async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('classes')
        .add(classes.toJson());
    _fetchClasses(); // Refresh the list
  }

  Future<void> _editClass(Class classes) async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('Classes')
        // .doc(Classes.classname)
        .doc(classes.id as String?)
        .update(classes.toJson());
    _fetchClasses(); // Refresh the list
  }

  Future<void> _deleteClass(Class classes) async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('Classes')
        // .doc(Classes.classname)
        .doc(classes.id)
        .delete();
    _fetchClasses(); // Refresh the list
  }

  @override
  void initState() {
    super.initState();
    _fetchClasses();
    // Replace this with your local data fetching or add a function to generate mock data
  }

  // ... other methods for adding, editing, deleting Facultys (without Firebase)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Classes'),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * .9,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * .4,
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: 'Search Classes...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            )),
                        onChanged: (searchText) {
                          if (searchText.isEmpty) {
                            _fetchClasses();
                          } else {
                            _firestore
                                .collection('Classes')
                                .where('name',
                                    isGreaterThanOrEqualTo: searchText)
                                .get()
                                .then((snapshot) {
                              _class.clear();
                              for (final doc in snapshot.docs) {
                                _class.add(Class.fromDocument(doc));
                              }
                              setState(() {});
                            });
                          }
                          // Implement search functionality
                        },
                      ),
                    ),
                    Expanded(child: const SizedBox(width: 10)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              //to set border radius to button
                              borderRadius: BorderRadius.circular(20)),
                          padding: EdgeInsets.only(
                              left: 25,
                              top: 25,
                              right: 25,
                              bottom: 25) //content padding inside button
                          ),
                      onPressed: () {
                        _addNewClasses();
                      },
                      child: const Text('Add New'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width * .8,
                  child: ListView.builder(
                    itemCount: _class.length,
                    itemBuilder: (context, index) {
                      final Classes = _class[index];
                      return _buildTableRow(Classes);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTableRow(Class Classes) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(Classes.classname),
            Text(Classes.strength),
            Text(Classes.course),
            Row(
              children: [
                IconButton(
                  onPressed: () => _editClassesDialog(Classes),
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () => _deleteClass(Classes),
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

// ... implement _editFaculty and _deleteFaculty functions for local data management
  void _addNewClasses() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Class Name'),
        content: Container(
          width: 200, // Set the desired width
          padding: const EdgeInsets.all(10.0),

          child: Column(mainAxisSize: MainAxisSize.min, children: [
            TextField(
              controller: _classnameController,
              decoration: const InputDecoration(hintText: 'Enter Class Name'),
            ),
            TextField(
              controller: _strengthController,
              decoration: const InputDecoration(hintText: 'Enter Strength'),
            ),
            TextField(
              controller: _courseController,
              decoration: const InputDecoration(hintText: 'Enter Courses'),
            ),
          ]),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final Classesname = _classnameController.text;
              final Classesstrength = _strengthController.text;
              final Classescourse = _courseController.text;
              // final FacultyCategory = _selectedCategory;
              // final FacultyCapacity = int.tryParse(_capacityController.text);

              if (Classesstrength.isNotEmpty) {
                final String userId = FirebaseAuth.instance.currentUser!.uid;
                _firestore
                    .collection('users')
                    .doc(userId)
                    .collection('Classes')
                    .add({
                  'classname': Classesname,
                  'strength': Classesstrength,
                  'course': Classescourse,
                  // 'category': FacultyCategory,
                  // 'capacity': FacultyCapacity, // Set default capacity
                });
                _strengthController.clear();
                Navigator.pop(context);
                _fetchClasses(); // Refresh the list
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _editClassesDialog(Class Classes) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Classes'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Similar to the add Faculty dialog, but pre-fill the fields with existing data
            TextField(
              controller: _strengthController..text = Classes.strength,
              decoration: const InputDecoration(hintText: 'Enter Strength'),
            ),
            TextField(
              controller: _courseController..text = Classes.course,
              decoration: const InputDecoration(hintText: 'Enter Course name'),
            ),

            // TextField(
            //   // controller: _capacityController
            //   //   ..text = Faculty.capacity.toString(),
            //   decoration: const InputDecoration(hintText: 'Enter Capacity'),
            // ),
            // Other fields as needed
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Update the Faculty object with the edited values
              Classes.strength = _strengthController.text;
              Classes.course = _courseController.text;
              // Faculty.capacity = int.tryParse(_capacityController.text) ?? 0;

              // Call the _editFaculty function
              _editClass(Classes);

              // Clear controllers and close dialog
              _strengthController.clear();
              _courseController.clear();

              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
