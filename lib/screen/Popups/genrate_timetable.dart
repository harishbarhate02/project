s





void _addNewRoom() {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Add New Room/Lab'),
      content: Container(
        width: 200, // Set the desired width
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _idController,
              decoration: const InputDecoration(hintText: 'Enter room id'),
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
              final String userId = FirebaseAuth.instance.currentUser!.uid;
              _firestore
                  .collection('users')
                  .doc(userId)
                  .collection('rooms')
                  .add({
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