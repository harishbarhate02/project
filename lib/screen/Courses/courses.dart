import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Course {
  final String id;
  late String name;
  late String fname;

  factory Course.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    return Course(
        id: doc.data()!['id'] ?? '',
        name: doc.data()!['name'] ?? '',
        fname: doc.data()!['fname'] ?? '');
  }

  Course({required this.id, required this.name, required this.fname});
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'fname': fname,
    };
  }
}

class CourseData extends StatefulWidget {
  const CourseData({super.key});

  @override
  State<CourseData> createState() => _CourseDataState();
}

class _CourseDataState extends State<CourseData> {
  final courses = <Course>[]; // List to store courses
  final _firestore = FirebaseFirestore.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _fnameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    _fnameController.dispose();
    super.dispose();
  }

  Future<void> _fetchCourses() async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('courses')
        .get();
    courses.clear();
    for (final doc in snapshot.docs) {
      if (doc.exists) {
        courses.add(Course(
          id: doc.data()['id'] as String? ?? '',
          name: doc.data()['name'] as String? ?? '',
          fname: doc.data()['fname'] as String? ?? '',
        ));
      }
    }
    setState(() {});
  }

  Future<void> addCourse(Course course) async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('courses')
        .add(course.toJson());
    _fetchCourses(); // Refresh the list
  }

  Future<void> _editCourse(Course course) async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('courses')
        .doc(course.id)
        .update(course.toJson());
    _fetchCourses(); // Refresh the list
  }

  Future<void> _deleteCourse(Course course) async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('courses')
        .doc(course.id)
        .delete();
    _fetchCourses(); // Refresh the list
  }

  @override
  void initState() {
    super.initState();
    _fetchCourses();
    // Replace this with your local data fetching or add a function to generate mock data
  }

  // ... other methods for adding, editing, deleting courses (without Firebase)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course'),
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
                            hintText: 'Search Course...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            )),
                        onChanged: (searchText) {
                          if (searchText.isEmpty) {
                            _fetchCourses();
                          } else {
                            _firestore
                                .collection('courses')
                                .where('name',
                                    isGreaterThanOrEqualTo: searchText)
                                .get()
                                .then((snapshot) {
                              courses.clear();
                              for (final doc in snapshot.docs) {
                                courses.add(Course.fromDocument(doc));
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
                        _addNewCourse();
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
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      final Course = courses[index];
                      return _buildTableRow(Course);
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

  Widget _buildTableRow(Course course) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(course.id),
            Text(course.name),
            Text(course.fname),
            // Text(Faculty.category),
            // Text(Faculty.capacity.toString()),
            Row(
              children: [
                IconButton(
                  onPressed: () => _editCourseDialog(course),
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () => _deleteCourse(course),
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

// ... implement _editCourse and _deleteCourse functions for local data management
  void _addNewCourse() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Course'),
        content: Container(
          width: 200, // Set the desired width
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _idController,
                decoration:
                    const InputDecoration(hintText: 'Enter Course Code'),
              ),
              TextField(
                controller: _nameController,
                decoration:
                    const InputDecoration(hintText: 'Enter Course name'),
              ),
              TextField(
                controller: _fnameController,
                decoration:
                    const InputDecoration(hintText: 'Enter Faculty Name'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final courseid = _idController.text;
              final courseName = _nameController.text;
              final coursefname = _fnameController.text;
              if (courseName.isNotEmpty) {
                final String userId = FirebaseAuth.instance.currentUser!.uid;
                _firestore
                    .collection('users')
                    .doc(userId)
                    .collection('courses')
                    .add({
                  'id': courseid,
                  'name': courseName,
                  'fname': coursefname,
                });
                _nameController.clear();
                Navigator.pop(context);
                _fetchCourses(); // Refresh the list
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _editCourseDialog(Course courses) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Course'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Similar to the add room dialog, but pre-fill the fields with existing data
            // TextField(
            //   controller: _nameController..text = courses.name,
            //   decoration: const InputDecoration(hintText: 'Enter Course Name'),
            // ),
            TextField(
              controller: _fnameController..text = courses.fname,
              decoration: const InputDecoration(hintText: 'Enter Faculty Name'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Update the room object with the edited values
              courses.fname = _fnameController.text;
              // room.capacity = int.tryParse(_capacityController.text) ?? 0;

              // Call the _editRoom function
              _editCourseDialog(courses);

              // Clear controllers and close dialog
              _fnameController.clear();
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
