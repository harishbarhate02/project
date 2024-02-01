import 'data_model.dart';

class Timetable {
  // List of courses with their assigned time slots and rooms
  List<Course> courses;
  List<Room> rooms; // List of available rooms>
  List<TimeSlot> timeSlots; // List of available time slots>
  // Fitness score calculated based on constraints and preferences
  int fitness = 0;

  // Additional properties as needed, e.g.,
  // - Number of conflicts
  // - Constraints that are not fully satisfied
  // - Preferences that are not met

  // Constructor to create a timetable with initial courses (optional)
  Timetable(this.courses, this.rooms, this.timeSlots);
}