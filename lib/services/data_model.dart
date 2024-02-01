import 'package:flutter/material.dart';
import 'package:googleapis/admin/directory_v1.dart';
import 'package:googleapis/authorizedbuyersmarketplace/v1.dart';

import 'day.dart';

class Department {
  String name;
  List<Course> coursesOffered; // Courses offered by this department
  List<Instructor> instructors; // Instructors belonging to this department
// ... other fields as needed, e.g., head of department, contact information

  Department({required this.name,required this.coursesOffered,required this.instructors});
}
class Course {
  String name;
  Department department; // The department offering the course
  Instructor instructor;
  int duration;
  List<Room> requiredRooms;
// ... other fields

  Course({required this.name,required this.department,required this.instructor,required this.duration,required this.requiredRooms});
}
class Instructor {
  String name;
  List<Course> coursesTaught; // Courses taught by this instructor
// ... other fields

  Instructor({required this.name,required this.coursesTaught});
}
class Student {
  String name;
  List<Course> enrollments; // Courses the student is enrolled in
  List<Preference> preferences; // Time slot or course preferences
// ... other fields as needed, e.g., student ID, program

  Student({required this.name,required this.enrollments,required this.preferences});
}

class Room {
  String name;
  int capacity;
  List<Feature> features; // Special features of the room (e.g., lab equipment)
// ... other fields as needed, e.g., building location

  Room({required this.name,required this.capacity,required this.features});

}

class TimeSlot {
  Day day; // Enum for days of the week
  TimeOfDay startTime;
  TimeOfDay endTime;

  TimeSlot({required this.day,required this.startTime,required this.endTime});
}

// Helper classes for constraints and preferences
class Constraint {
  String type; // Describes the constraint (e.g., "no morning classes")
// ... other fields as needed to specify the constraint

  Constraint({required this.type});
}

class Preference {
  String type; // Describes the preference (e.g., "prefer afternoon classes")
// ... other fields as needed to specify the preference

  Preference({required this.type});
}

Room getRandomAvailableRoom(Course course) {
  List<Room> availableRooms = [];

  // Filter rooms based on capacity and other constraints
  for (Room room in requiredRooms) { // Assume a list of all rooms is available
    if (room.capacity >= course.numberOfStudents &&
        !isRoomConflicting(room, course, timetable)) { // Implement isRoomConflicting
      availableRooms.add(room);
    }
  }

  // Return a random available room, or null if none are found
  if (availableRooms.isNotEmpty) {
    return availableRooms[Random().nextInt(availableRooms.length)];
  } else {
    return null; // Handle the case of no available rooms appropriately
  }
}