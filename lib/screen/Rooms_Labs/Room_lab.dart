
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/screen/Popups/addnew_room_lab.dart';




class Room {
  final String id;
  final String name;
  final int capacity;

  Room({required this.id, required this.name, required this.capacity});
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
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
  final _rooms = <Room>[]; // List to store rooms
  final _firestore = FirebaseFirestore.instance;

  Future<void> _fetchRooms() async {
    final snapshot = await _firestore.collection('rooms').get();
    _rooms.clear();
    for (final doc in snapshot.docs) {
      _rooms.add(Room(
        id: doc.id,
        name: doc.data()['name'] as String,
        capacity: doc.data()['capacity'] as int,
      ));
    }
    setState(() {});
  }

  Future<void> _addRoom(Room room) async {
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
                      // Implement search functionality
                    },
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                    );
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
        // Handle row tap (e.g., for editing)
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
}