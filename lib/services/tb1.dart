class Faculty {
  final String name;
  final List<String> courses; // List of courses the faculty can teach

  Faculty(this.name, this.courses);
}

class TimetableSlot {
  final String course;
  final Faculty faculty;
  final DateTime startTime;
  final DateTime endTime;

  TimetableSlot(this.course, this.faculty, this.startTime, this.endTime);

  @override
  String toString() => '$course: $faculty - $startTime - $endTime';
}

class SemesterTimetable {
  final List<TimetableSlot> slots;

  SemesterTimetable(this.slots);

  bool overlapsWith(SemesterTimetable other) {
    int penalty = 0;
    for (var slot1 in slots) {
      for (var slot2 in other.slots) {
        if (_overlaps(slot1, slot2)) {
          if (slot1.faculty == slot2.faculty) {
            penalty += _overlapDuration(slot1, slot2).inMinutes * 2; // Higher penalty for faculty overlap
          } else {
            penalty += _overlapDuration(slot1, slot2).inMinutes;
          }
        }
      }
    }
    return penalty > 0;
  }

  int fitness(SemesterTimetable other) {
    return overlapsWith(other) ? 1: 0; // Fitness score based on overlap existence
  }

  bool _overlaps(TimetableSlot slot1, TimetableSlot slot2) {
    // Check if slot1 starts before slot2 ends and slot2 starts before slot1 ends
    return slot1.startTime.isBefore(slot2.endTime) &&
        slot2.startTime.isBefore(slot1.endTime);
  }

  Duration _overlapDuration(TimetableSlot slot1, TimetableSlot slot2) {
    // Find the later start time and the earlier end time
    var laterStart = slot1.startTime.isAfter(slot2.startTime)
        ? slot1.startTime
        : slot2.startTime;
    var earlierEnd = slot1.endTime.isBefore(slot2.endTime) ? slot1.endTime : slot2.endTime;
    return earlierEnd.difference(laterStart);
  }
}

void main() {
  // Sample faculties
  var faculty1 = Faculty("Prof. Smith", ["Math", "Chemistry"]);
  var faculty2 = Faculty("Prof. Jones", ["Physics", "History"]);

  // Sample timetables (with faculty and courses assigned)
  var timetable1 = SemesterTimetable([
    TimetableSlot("Math", faculty1, DateTime(2024, 4, 15, 9, 0), DateTime(2024, 4, 15, 10, 0)),
    TimetableSlot("Physics", faculty2, DateTime(2024, 4, 16, 11, 0), DateTime(2024, 4, 16, 12, 0)),
  ]);
  var timetable2 = SemesterTimetable([
    TimetableSlot("Chemistry", faculty1, DateTime(2024, 4, 15, 9, 30), DateTime(2024, 4, 15, 10, 30)), // Faculty overlap
    TimetableSlot("History", faculty2, DateTime(2024, 4, 16, 10, 0), DateTime(2024, 4, 16, 11, 0)),
  ]);

  // Check for overlap
  if (timetable1.overlapsWith(timetable2)) {
    print("Timetables overlap! (Teacher conflicts)");

    // Calculate fitness score (0 for no overlap, non-zero for overlap)
    var fitnessScore = timetable1.fitness(timetable2);
    print("Fitness score (overlap existence): $fitnessScore");
  } else {
    print("Timetables do not overlap.");
  }
}
class Faculty {
  final String name;
  final List<String> courses; // List of courses the faculty can teach

  Faculty(this.name, this.courses);
}

class TimetableSlot {
  final String course;
  final Faculty faculty;
  final DateTime startTime;
  final DateTime endTime;

  TimetableSlot(this.course, this.faculty, this.startTime, this.endTime);

  @override
  String toString() => '$course: $faculty - $startTime - $endTime';
}

class SemesterTimetable {
  final List<TimetableSlot> slots;

  SemesterTimetable(this.slots);

  bool overlapsWith(SemesterTimetable other) {
    int penalty = 0;
    for (var slot1 in slots) {
      for (var slot2 in other.slots) {
        if (_overlaps(slot1, slot2)) {
          if (slot1.faculty == slot2.faculty) {
            penalty += _overlapDuration(slot1, slot2).inMinutes * 2; // Higher penalty for faculty overlap
          } else {
            penalty += _overlapDuration(slot1, slot2).inMinutes;
          }
        }
      }
    }
    return penalty > 0;
  }

  int fitness(SemesterTimetable other) {
    return overlapsWith(other) ? this.overlapsWith(other) : 0; // Fitness score based on overlap existence
  }

  bool _overlaps(TimetableSlot slot1, TimetableSlot slot2) {
    // Check if slot1 starts before slot2 ends and slot2 starts before slot1 ends
    return slot1.startTime.isBefore(slot2.endTime) &&
        slot2.startTime.isBefore(slot1.endTime);
  }

  Duration _overlapDuration(TimetableSlot slot1, TimetableSlot slot2) {
    // Find the later start time and the earlier end time
    var laterStart = slot1.startTime.isAfter(slot2.startTime)
        ? slot1.startTime
        : slot2.startTime;
    var earlierEnd = slot1.endTime.isBefore(slot2.endTime) ? slot1.endTime : slot2.endTime;
    return earlierEnd.difference(laterStart);
  }
}

void main() {
  // Sample faculties
  var faculty1 = Faculty("Prof. Smith", ["Math", "Chemistry"]);
  var faculty2 = Faculty("Prof. Jones", ["Physics", "History"]);

  // Sample timetables (with faculty and courses assigned)
  var timetable1 = SemesterTimetable([
    TimetableSlot("Math", faculty1, DateTime(2024, 4, 15, 9, 0), DateTime(2024, 4, 15, 10, 0)),
    TimetableSlot("Physics", faculty2, DateTime(2024, 4, 16, 11, 0), DateTime(2024, 4, 16, 12, 0)),
  ]);
  var timetable2 = SemesterTimetable([
    TimetableSlot("Chemistry", faculty1, DateTime(2024, 4, 15, 9, 30), DateTime(2024, 4, 15, 10, 30)), // Faculty overlap
    TimetableSlot("History", faculty2, DateTime(2024, 4, 16, 10, 0), DateTime(2024, 4, 16, 11, 0)),
  ]);

  // Check for overlap
  if (timetable1.overlapsWith(timetable2)) {
    print("Timetables overlap! (Teacher conflicts)");

    // Calculate fitness score (0 for no overlap, non-zero for overlap)
    var fitnessScore = timetable1.fitness(timetable2);
    print("Fitness score (overlap existence): $fitnessScore");
  } else {
    print("Timetables do not overlap.");
  }
}