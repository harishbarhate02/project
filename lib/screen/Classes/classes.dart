import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Classes {
  final String id;
  late String classname;
  late String strength;
  late String course;

  factory Classes.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    return Classes(
      id: doc.data()!['id'] ?? '',
      classname: doc.data()!['classname'] ?? '',
      strength: doc.data()!['strength'] ?? '',
      course: doc.data()!['course'] ?? '',
    );
  }

  Classes({
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

class Class extends StatefulWidget {
  const Class({super.key});

  @override
  State<Class> createState() => _ClassState();
}

class _ClassState extends State<Class> {
  final _class = <Classes>[]; // List to store Classes
  final _firestore = FirebaseFirestore.instance;
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _classnameController = TextEditingController();
  final TextEditingController _strengthController = TextEditingController();
  final TextEditingController _coursecontroller = TextEditingController();
  @override
  void dispose() {
    _idController.dispose();
    _classnameController.dispose();
    _strengthController.dispose();
    _coursecontroller.dispose();
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
        _class.add(Classes(
          id: doc.data()['id'] as String? ?? '',
          classname: doc.data()['classname'] as String? ?? '',
          strength: doc.data()['strength'] as String? ?? '',
          course: doc.data()['course'] as String? ?? '',
        ));
      }
    }
    setState(() {});
  }

  Future<void> addClasses(Classes Classes) async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('CLasses')
        .add(Classes.toJson());
    _fetchClasses(); // Refresh the list
  }

  Future<void> _editClasses(Classes Classes) async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('Classes')
        // .doc(Classes.classname)
        .doc(Classes.id)
        .update(Classes.toJson());
    _fetchClasses(); // Refresh the list
  }

  Future<void> _deleteClasses(Classes Classes) async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('Classes')
        // .doc(Classes.classname)
        .doc(Classes.id)
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
                                _class.add(Classes.fromDocument(doc));
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

  Widget _buildTableRow(Classes Classes) {
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
                  onPressed: () => _deleteClasses(Classes),
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
              controller: _coursecontroller,
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

  void _editClassesDialog(Classes Classes) {
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
              // Faculty.capacity = int.tryParse(_capacityController.text) ?? 0;

              // Call the _editFaculty function
              _editClasses(Classes);

              // Clear controllers and close dialog
              _strengthController.clear();
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
