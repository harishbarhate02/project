import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Room {
  final String id;
  final String name;
  final String category;
  final int capacity;
  factory Room.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    return Room(
      id: doc.id,
      name: doc.data()!['name'] ?? '',
      capacity: doc.data()!['capacity'] ?? 0,
      category: doc.data()!['category'] ?? '',
    );
  }

  Room({required this.id, required this.name, required this.capacity,required this.category});
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'capacity': capacity,
      // Add other attributes as needed
    };
  }
}
class RoomsLabs extends StatefulWidget {
  const RoomsLabs({super.key});

  @override
  State<RoomsLabs> createState() => _RoomsLabsState();
}

class _RoomsLabsState extends State<RoomsLabs> {
  final _rooms = <Room>[];// List to store rooms
  final _firestore = FirebaseFirestore.instance;
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

  Future<void> _fetchRooms() async {
    final snapshot = await _firestore.collection('rooms').get();
    _rooms.clear();
    for (final doc in snapshot.docs) {
      _rooms.add(Room(
        id: doc.id,
        name: doc.data()['name'] as String,
        category: doc.data()['category'] as String,
        capacity: doc.data()['capacity'] as int,
      ));
    }
    setState(() {});
  }

  Future<void> addRoom(Room room) async {
    await _firestore.collection('rooms').add(room.toJson());
    _fetchRooms(); // Refresh the list
  }

  Future<void> _editRoom(Room room) async {
    await _firestore.collection('rooms').doc(room.id).update(room.toJson());
    _fetchRooms(); // Refresh the list
  }

  Future<void> _deleteRoom(Room room) async {
    await _firestore.collection('rooms').doc(room.id).delete();
    _fetchRooms(); // Refresh the list
  }

  @override
  void initState() {
    super.initState();
    // Replace this with your local data fetching or add a function to generate mock data
  }

  // ... other methods for adding, editing, deleting rooms (without Firebase)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rooms and Labs'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search rooms and labs...',
                    ),
                    onChanged: (searchText) {
                      if (searchText.isEmpty) {
                        _fetchRooms();
                      } else {
                        _firestore
                            .collection('rooms')
                            .where('name', isGreaterThanOrEqualTo: searchText)
                            .get()
                            .then((snapshot) {
                          _rooms.clear();
                          for (final doc in snapshot.docs) {
                            _rooms.add(Room.fromDocument(doc));
                          }
                          setState(() {});
                        });
                      }
                      // Implement search functionality
                    },
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    _addNewRoom();
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => AddRoomLabDialog()),
                    // );

                  },
                  child: const Text('Add New'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _rooms.length,
              itemBuilder: (context, index) {
                final room = _rooms[index];
                return _buildTableRow(room);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow(Room room) {
    return GestureDetector(
      onTap: () {

      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(room.name),
            Text(room.capacity.toString()),
            Row(
              children: [
                IconButton(
                  onPressed: () => _editRoom(room),
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () => _deleteRoom(room),
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

// ... implement _editRoom and _deleteRoom functions for local data management
  void _addNewRoom() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Room'),
        content: Column(
          children: [
            TextField(
              controller: _idController,
              decoration: const InputDecoration(hintText: 'Enter room name'),
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(hintText: 'Enter room name'),
            ),
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
            TextField(
              controller: _capacityController,
              decoration: const InputDecoration(hintText: 'Enter Capacity'),
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
              final roomId = _idController.text;
              final roomName = _nameController.text;
              final roomCategory = _selectedCategory;
              final roomCapacity = int.tryParse(_capacityController.text);

              if (roomName.isNotEmpty) {
                _firestore.collection('rooms').add({
                  'id': roomId,
                  'name': roomName,
                  'category': roomCategory,
                  'capacity': roomCapacity, // Set default capacity
                });
                _nameController.clear();
                Navigator.pop(context);
                _fetchRooms(); // Refresh the list
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }


}
