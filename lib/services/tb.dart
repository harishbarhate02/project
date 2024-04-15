import 'dart:math';

class Timetable {
  List<List<Map<String, int>>> timetable;

  Timetable(this.timetable);

  double calculateFitness() {
    // Implement your fitness calculation logic here
    // Return a value indicating how good the timetable is
    return 0.0;
  }
}

class TimetableGenerator {
  final int populationSize;
  final List<Map<String, int>> subjects;
  final List<String> days;
  final List<String> timeSlots;

  late  Map<String, int> subjectCount;

  TimetableGenerator(
      this.populationSize,
      this.subjects,
      this.subjectCount,
      this.days,
      this.timeSlots,
      );

  List<Timetable> initializePopulation() {
    final List<Timetable> population = [];

    for (int i = 0; i < populationSize; i++) {
      final List<List<Map<String, int>>> timetable = generateRandomTimetable();
      population.add(Timetable(timetable));
    }

    return population;
  }

  List<List<Map<String, int>>> generateRandomTimetable() {
    final Random random = Random();
    final List<List<Map<String, int>>> timetable = [];

    for (String day in days) {
      final List<Map<String, int>> daySchedule = [];
      int remainingTimeSlots = 6;
      if(day == 'saturday'){
        remainingTimeSlots = 4;
      }

      // Shuffle the subjects to randomly select a consecutive subset
      List<Map<String, int>> shuffledSubjects = List.from(subjects)..shuffle(random);

      for (Map<String, int> subject in shuffledSubjects) {
        String subjectName = subject.keys.first;
        // Check if the subject's duration fits in the remaining time slots
        int subjectDuration = subject.values.first;

        // Add the subject to the timetable
        if (remainingTimeSlots > 0) {
          if (remainingTimeSlots % 2!= 0 && subjectDuration % 2 != 0 && subjectCount[subjectName]!= 0) {
            daySchedule.add(subject);
            remainingTimeSlots -= subjectDuration;
            subjectCount[subjectName] = subjectCount[subjectName]! - 1;
          }
          else if (remainingTimeSlots % 2 != 0 && subjectDuration % 2 == 0) {
            continue;
          }
          else if (remainingTimeSlots % 2 == 0 && subjectDuration % 2 == 0 && subjectCount[subjectName]!= 0) {
            daySchedule.add(subject);
            subjects.remove(subject);
            remainingTimeSlots -= subjectDuration;
            subjectCount[subjectName] = (subjectCount[subjectName]! - 1);
          }
          else if (remainingTimeSlots % 2 == 0 && subjectDuration % 2 != 0 && subjectCount[subjectName]!= 0) {
            daySchedule.add(subject);
            remainingTimeSlots -= subjectDuration;
            subjectCount[subjectName] = (subjectCount[subjectName]! - 1);
          }
          else{
              daySchedule.add({'off': 1}); // Assuming breaks are 1 hour
              remainingTimeSlots -= 1;
          }
        }
        // Add a break after every two hours
        if (remainingTimeSlots > 0 && remainingTimeSlots % 2 == 0) {
          daySchedule.add({'Break': 1}); // Assuming breaks are 1 hour
        }
      }

      timetable.add(daySchedule);
    }

    return timetable;
  }

  Timetable selection(List<Timetable> population) {
    return population.first;
  }

  Timetable crossover(Timetable parent1, Timetable parent2) {
    return parent1;
  }

  void mutation(Timetable child) {
    // Implement mutation logic (e.g., swap two subjects in the timetable)
  }

  Timetable runGeneticAlgorithm(int generations) {
    List<Timetable> population = initializePopulation();

    for (int generation = 0; generation < generations; generation++) {
      for (Timetable timetable in population) {
        timetable.calculateFitness();
      }

      List<Timetable> newPopulation = [];

      for (int i = 0; i < populationSize; i++) {
        Timetable parent1 = selection(population);
        Timetable parent2 = selection(population);
        Timetable child = crossover(parent1, parent2);
        mutation(child);
        newPopulation.add(child);
      }
      subjectCount = Map.fromEntries(
          subjects.map((subject) => MapEntry(subject.keys.first, 0)));

      population = newPopulation;
    }

    return population.reduce((a, b) => a.calculateFitness() > b.calculateFitness() ? a : b);
  }
}

void main() {
  final List<Map<String, int>> subjects = [
    {'SSEE': 1},
    {'CG': 1},
    {'CC': 1},
    {'PE-3': 1},
    {'BF': 1},
    {'CG-LAB': 2},
    {'ET-3 -LAB': 2},
    {'ET-4 -LAB': 2},
    {'ab-LAB': 2},
    {'bc-LAB': 2},
  ];
  final Map<String, int> subjectcount = {
    'SSEE': 3,
    'CG': 3,
    'CC': 3,
    'PE-3': 3,
    'BF': 3,
    'CG-LAB': 1,
    'ET-3 -LAB': 1,
    'ET-4 -LAB': 1,
    'ab-LAB': 1,
    'bc-LAB': 1,

  };


  final List<String> days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday','saturday'];
  final List<String> timeSlots = ['11:00 AM - 12:00 PM', '12:00 PM - 1:00 PM', '1:15 PM - 2:15 PM', '2:15 PM - 3:15 PM', '3:45 PM- 4:45 PM','4:45 PM - 5:45 PM'];
  final TimetableGenerator timetableGenerator = TimetableGenerator(10, subjects,subjectcount ,days, timeSlots);

  final Timetable bestTimetable = timetableGenerator.runGeneticAlgorithm(100);

  // Print the best timetable
  print(bestTimetable.timetable);
}