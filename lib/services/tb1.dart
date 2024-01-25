import 'dart:math';

class Classes {
  final String name;
  final List<String> subjects;

  const Classes(this.name, this.subjects);
}

class Teacher {
  final String name;
  final List<String> subjects;

  const Teacher(this.name, this.subjects);
}

class Room {
  final String name;
  final int capacity;

  const Room(this.name, this.capacity);
}


class TimeSlot {
  final String time;

  const TimeSlot(this.time);
}

class Subject {
  final String name;
  final int duration;

  const Subject(this.name, this.duration);
}

class Timetable {
  final List<List<Map<String, dynamic>>> schedule;

  Timetable(this.schedule);

  double calculateFitness() {
    double fitness = 0.0;
    // 1. Conflict Detection:
    for (int i = 0; i < schedule.length; i++) {
      final daySchedule = schedule[i];
      for (int j = 0; j < daySchedule.length; j++) {
        final class1 = daySchedule[j];
        for (int k = j + 1; k < daySchedule.length; k++) {
          final class2 = daySchedule[k];

          // Check for teacher conflicts:
          if (class1['teacher'] == class2['teacher']) {
            fitness -= 10.0; // High penalty for teacher conflicts
          }

          // Check for room conflicts:
          if (class1['room'] == class2['room']) {
            fitness -= 5.0; // Moderate penalty for room conflicts
          }

          // Check for class conflicts (same class in multiple rooms):
          if (class1['class'] == class2['class']) {
            fitness -= 10.0; // High penalty for class conflicts
          }
        }
      }
    }
// 2. Teacher Workload Balance:
    final teacherWorkloads = <String, int>{};
    for (List<Map<String, dynamic>> daySchedule in schedule) {
      for (Map<String, dynamic> classSchedule in daySchedule) {
        teacherWorkloads[classSchedule['teacher']] ??= 0;
        teacherWorkloads[classSchedule['teacher']]++;
      }
    }
    final averageWorkload = teacherWorkloads.values.reduce((a, b) => a + b) / teacherWorkloads.length;
    final workloadVariance = teacherWorkloads.values.map((w) => (w - averageWorkload) * (w - averageWorkload)).reduce((a, b) => a + b) / teacherWorkloads.length;
    fitness -= workloadVariance * 2.0; // Penalize unbalanced workloads

    // 3. Subject Distribution:
    final subjectDistribution = <String, int>{};
    for (List<Map<String, dynamic>> daySchedule in schedule) {
      for (Map<String, dynamic> classSchedule in daySchedule) {
        subjectDistribution[classSchedule['subject']] ??= 0;
        subjectDistribution[classSchedule['subject']]++;
      }
    }
    final idealDistribution = subjects.length / schedule.length; // Assuming equal distribution across days
    final distributionVariance = subjectDistribution.values.map((d) => (d - idealDistribution) * (d - idealDistribution)).reduce((a, b) => a + b) / subjects.length;
    fitness -= distributionVariance * 1.0; // Encourage even distribution of subjects

    // Implement your fitness calculation logic here
    // Consider penalties for conflicts, unbalanced workloads, etc.
    return fitness;
  }
}

class TimetableGenerator {
  final int populationSize;
  final List<Class> classes;
  final List<Teacher> teachers;
  final List<Room> rooms;
  final List<TimeSlot> timeSlots;
  final List<Subject> subjects;
  final Random random = Random();

  TimetableGenerator(this.populationSize,
      this.classes,
      this.teachers,
      this.rooms,
      this.timeSlots,
      this.subjects);

  List<Timetable> initializePopulation() {
    final List<Timetable> population = [];

    for (int i = 0; i < populationSize; i++) {
      final List<
          List<Map<String, dynamic>>> schedule = generateRandomTimetable();
      population.add(Timetable(schedule));
    }

    return population;
  }

  List<List<Map<String, dynamic>>> generateRandomTimetable() {
    final List<List<Map<String, dynamic>>> schedule = [];

    for (TimeSlot timeSlot in timeSlots) {
      final List<Map<String, dynamic>> daySchedule = [];

      for (Class Class in classes) {
        Subject assignedSubject;
        Teacher assignedTeacher;
        Room assignedRoom;

        // Randomly assign a subject, teacher, and room for the class in this time slot

        assignedSubject = subjects[random.nextInt(subjects.length)];
        assignedTeacher = teachers.firstWhere((teacher) =>
            teacher.subjects.contains(assignedSubject.name));
        assignedRoom =
            rooms.firstWhere((room) => room.capacity >= Class.subjects.length);

        daySchedule.add({
          'class': Class.name,
          'subject': assignedSubject.name,
          'teacher': assignedTeacher.name,
          'room': assignedRoom.name,
        });
      }

      schedule.add(daySchedule);
    }

    return schedule;
  }

  Timetable selection(List<Timetable> population) {
    // Implement your selection strategy here (e.g., roulette wheel selection, tournament selection)
    return population.first;
  }

  Timetable crossover(Timetable parent1, Timetable parent2) {
    // Implement your crossover operator here (e.g., single-point crossover, two-point crossover)
    final newSchedule = List.from(parent1.schedule);

    // Swap randomly chosen time slots between parents
    final crossoverPoint = random.nextInt(timeSlots.length);
    for (int i = crossoverPoint; i < timeSlots.length; i++) {
      newSchedule[i] = parent2.schedule[i];
    }

    return Timetable(newSchedule);
  }

  void mutation(Timetable child) {
    // Implement your mutation operator here (e.g., swap subjects, change rooms)
    final randomClassIndex = random.nextInt(classes.length);
    final randomTimeSlotIndex = random.nextInt(timeSlots.length);

    // Swap subjects in a randomly chosen time slot for a random class
    final subject1 = child.schedule[randomTimeSlotIndex][subjects.length];
    child.schedule[randomTimeSlotIndex][subjects.length] =
    child.schedule[randomTimeSlotIndex + 1][subjects.length];
    child.schedule[randomTimeSlotIndex + 1][subjects.length] = subject1;
  }

  Timetable runGeneticAlgorithm(int generations) {
    List<Timetable> population = initializePopulation();
  }
}