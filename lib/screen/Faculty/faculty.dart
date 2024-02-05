import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Faculty {
  final String id;
  late String name;

  factory Faculty.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    return Faculty(
      id: doc.data()!['id'] ?? '',
      name: doc.data()!['name'] ?? '',
    );
  }

  Faculty({required this.id, required this.name});
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class FacultysLabs extends StatefulWidget {
  const FacultysLabs({super.key});

  @override
  State<FacultysLabs> createState() => _FacultysLabsState();
}

class _FacultysLabsState extends State<FacultysLabs> {
  final _facultys = <Faculty>[]; // List to store Facultys
  final _firestore = FirebaseFirestore.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    super.dispose();
  }

  Future<void> _fetchFacultys() async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('Facultys')
        .get();
    _facultys.clear();
    for (final doc in snapshot.docs) {
      if (doc.exists) {
        _facultys.add(Faculty(
          id: doc.data()['id'] as String? ?? '',
          name: doc.data()['name'] as String? ?? '',
        ));
      }
    }
    setState(() {});
  }

  Future<void> addFaculty(Faculty Faculty) async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('Facultys')
        .add(Faculty.toJson());
    _fetchFacultys(); // Refresh the list
  }

  Future<void> _editFaculty(Faculty Faculty) async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('Facultys')
        .doc(Faculty.id)
        .update(Faculty.toJson());
    _fetchFacultys(); // Refresh the list
  }

  Future<void> _deleteFaculty(Faculty Faculty) async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('Facultys')
        .doc(Faculty.id)
        .delete();
    _fetchFacultys(); // Refresh the list
  }

  @override
  void initState() {
    super.initState();
    _fetchFacultys();
    // Replace this with your local data fetching or add a function to generate mock data
  }

  // ... other methods for adding, editing, deleting Facultys (without Firebase)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Faculty'),
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
                            hintText: 'Search Facultys and labs...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            )),
                        onChanged: (searchText) {
                          if (searchText.isEmpty) {
                            _fetchFacultys();
                          } else {
                            _firestore
                                .collection('Facultys')
                                .where('name',
                                    isGreaterThanOrEqualTo: searchText)
                                .get()
                                .then((snapshot) {
                              _facultys.clear();
                              for (final doc in snapshot.docs) {
                                _facultys.add(Faculty.fromDocument(doc));
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
                        _addNewFaculty();
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
                    itemCount: _facultys.length,
                    itemBuilder: (context, index) {
                      final Faculty = _facultys[index];
                      return _buildTableRow(Faculty);
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

  Widget _buildTableRow(Faculty Faculty) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(Faculty.id),
            Text(Faculty.name),
            // Text(Faculty.category),
            // Text(Faculty.capacity.toString()),
            Row(
              children: [
                IconButton(
                  onPressed: () => _editFacultyDialog(Faculty),
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () => _deleteFaculty(Faculty),
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
  void _addNewFaculty() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Faculty'),
        content: Container(
          width: 200, // Set the desired width
          padding: const EdgeInsets.all(10.0),

          child: Column(mainAxisSize: MainAxisSize.min, children: [
            TextField(
              controller: _idController,
              decoration: const InputDecoration(hintText: 'Enter Faculty id'),
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(hintText: 'Enter Faculty name'),
            ),
            // DropdownButtonFormField<String>(
            //   value: _selectedCategory,
            //   onChanged: (String? newValue) {
            //     setState(() {
            //       _selectedCategory = newValue!;
            //     });
            //   },
            //   items: <String>['Faculty', 'Lab'].map<DropdownMenuItem<String>>(
            //     (String value) {
            //       return DropdownMenuItem<String>(
            //         value: value,
            //         child: Text(value),
            //       );
            //     },
            //   ).toList(),
            // ),
            //   TextField(
            //     controller: _capacityController,
            //     decoration: const InputDecoration(hintText: 'Enter Capacity'),
            //   ),
            // ],
          ]),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final FacultyId = _idController.text;
              final FacultyName = _nameController.text;
              // final FacultyCategory = _selectedCategory;
              // final FacultyCapacity = int.tryParse(_capacityController.text);

              if (FacultyName.isNotEmpty) {
                final String userId = FirebaseAuth.instance.currentUser!.uid;
                _firestore
                    .collection('users')
                    .doc(userId)
                    .collection('Facultys')
                    .add({
                  'id': FacultyId,
                  'name': FacultyName,
                  // 'category': FacultyCategory,
                  // 'capacity': FacultyCapacity, // Set default capacity
                });
                _nameController.clear();
                Navigator.pop(context);
                _fetchFacultys(); // Refresh the list
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _editFacultyDialog(Faculty Faculty) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Faculty'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Similar to the add Faculty dialog, but pre-fill the fields with existing data
            TextField(
              controller: _nameController..text = Faculty.name,
              decoration: const InputDecoration(hintText: 'Enter Faculty name'),
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
              Faculty.name = _nameController.text;
              // Faculty.capacity = int.tryParse(_capacityController.text) ?? 0;

              // Call the _editFaculty function
              _editFaculty(Faculty);

              // Clear controllers and close dialog
              _nameController.clear();
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
