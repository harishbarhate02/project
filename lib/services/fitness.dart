
import 'package:untitled/services/timetable.dart';

import 'data_model.dart';

class fitness {
  int calculateFitness(Timetable timetable) {
    int fitness = 0;

    // Add points for satisfied constraints and preferences
    for (Course course in timetable.courses) {
      if (checkRoomCapacity(course, timetable)) fitness += 10;
      if (checkInstructorAvailability(course, timetable)) fitness += 10;
      // ... other constraints
      if (checkStudentPreferences(course, timetable)) fitness += 5; // Optional
    }

    // Subtract points for violations
    for (Constraint violation in findViolations(timetable)) {
      fitness -= 5; // Adjust penalty based on violation severity
    }

    return fitness;
  }
}