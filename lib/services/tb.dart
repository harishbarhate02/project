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

  TimetableGenerator(
      this.populationSize,
      this.subjects,
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
      int remainingTimeSlots = timeSlots.length;

      // Shuffle the subjects to randomly select a consecutive subset
      List<Map<String, int>> shuffledSubjects = List.from(subjects)..shuffle(random);

      for (Map<String, int> subject in shuffledSubjects) {
        // Check if the subject's duration fits in the remaining time slots
        int subjectDuration = subject.values.first;

        // Add the subject to the timetable
        daySchedule.add(subject);
        remainingTimeSlots -= subjectDuration;

        // Add a break after every two hours
        if (remainingTimeSlots > 0 && subjectDuration % 2 == 0) {
          daySchedule.add({'Break': 1}); // Assuming breaks are 1 hour
          remainingTimeSlots--;
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

      population = newPopulation;
    }

    return population.reduce((a, b) => a.calculateFitness() > b.calculateFitness() ? a : b);
  }
}

List<List<Map<String, int>>> main() {
  final List<Map<String, int>> subjects = [
    {'Math': 2},
    {'Physics': 1},
    {'Chemistry': 2},
    {'English': 1},
  ];

  final List<String> days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
  final List<String> timeSlots = ['9:00 AM - 10:00 AM', '10:00 AM - 11:00 AM', '11:00 AM - 12:00 PM'];

  final TimetableGenerator timetableGenerator = TimetableGenerator(10, subjects, days, timeSlots);

  final Timetable bestTimetable = timetableGenerator.runGeneticAlgorithm(100);

  // Print the best timetable
  return(bestTimetable.timetable);
}