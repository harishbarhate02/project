import 'dart:math';

import 'package:untitled/services/tb.dart';
import 'package:untitled/services/timetable.dart';

import 'data_model.dart'; // Import your data models

// Generates a diverse initial population of timetables
List<Timetable> generateInitialPopulation(int populationSize) {
  List<Timetable> population = [];
  // Create timetables with random course assignments, ensuring diversity
  // ... (implementation details)
  return population;
}

// Selects parents for crossover based on fitness
List<Timetable> selectParents(List<Timetable> population) {
  // Choose a selection method (tournament or roulette wheel)
  String selectionMethod = 'tournament'; // or 'rouletteWheel'

  List<Timetable> parents = [];

  if (selectionMethod == 'tournament') {
    // Tournament selection
    for (int i = 0; i < 2; i++) {
      List<Timetable> tournament = [];
      for (int j = 0; j < 3; j++) { // Adjust tournament size as needed
        tournament.add(population[Random().nextInt(population.length)]);
      }
      parents.add(tournament.reduce((a, b) => a.fitness > b.fitness ? a : b));
    }
  } else if (selectionMethod == 'rouletteWheel') {
    // Roulette wheel selection
    int totalFitness = population.fold(0, (sum, timetable) => sum + timetable.fitness);
    double randomValue1 = Random().nextDouble() * totalFitness;
    double randomValue2 = Random().nextDouble() * totalFitness;
    int index1 = 0, index2 = 0;
    int accumulatedFitness = 0;
    for (int i = 0; i < population.length; i++) {
      accumulatedFitness += population[i].fitness;
      if (accumulatedFitness >= randomValue1) {
        index1 = i;
        break;
      }
    }
    accumulatedFitness = 0;
    for (int i = 0; i < population.length; i++) {
      accumulatedFitness += population[i].fitness;
      if (accumulatedFitness >= randomValue2) {
        index2 = i;
        break;
      }
    }
    parents.add(population[index1]);
    parents.add(population[index2]);
  }

  return parents;
}

List<Timetable> crossover(Timetable parent1, Timetable parent2) {
  // Choose a crossover method (single-point or multi-point)
  String crossoverMethod = 'singlePoint'; // or 'multiPoint'

  List<Timetable> offspring = [];

  if (crossoverMethod == 'singlePoint') {
    // Single-point crossover
    int crossoverPoint = Random().nextInt(parent1.courses.length);
    List<Course> offspring1Courses = parent1.courses.sublist(0, crossoverPoint) + parent2.courses.sublist(crossoverPoint);
    List<Course> offspring2Courses = parent2.courses.sublist(0, crossoverPoint) + parent1.courses.sublist(crossoverPoint);
    offspring.add(Timetable(offspring1Courses));
    offspring.add(Timetable(offspring2Courses));
  } else if (crossoverMethod == 'multiPoint') {
    // Multi-point crossover
    int numCrossoverPoints = 2; // Adjust as needed
    List<int> crossoverPoints = [];
    for (int i = 0; i < numCrossoverPoints; i++) {
      crossoverPoints.add(Random().nextInt(parent1.courses.length));
    }
    crossoverPoints.sort(); // Ensure points are in ascending order
    List<Course> offspring1Courses = [];
    List<Course> offspring2Courses = [];
    int currentParent = 1; // Start with parent1
    for (int i = 0; i < parent1.courses.length; i++) {
      if (crossoverPoints.contains(i)) {
        currentParent = currentParent == 1 ? 2 : 1; // Switch parents
      }
      if (currentParent == 1) {
        offspring1Courses.add(parent1.courses[i]);
        offspring2Courses.add(parent2.courses[i]);
      } else {
        offspring1Courses.add(parent2.courses[i]);
        offspring2Courses.add(parent1.courses[i]);
      }
    }
    offspring.add(Timetable(offspring1Courses));
    offspring.add(Timetable(offspring2Courses));
  }

  return offspring;
}

void mutate(Timetable timetable) {
  // Choose a mutation type with a certain probability
  if (Random().nextDouble() < 0.5) { // Change probability as needed
    // Swap courses between random time slots
    int index1 = Random().nextInt(timetable.courses.length);
    int index2 = Random().nextInt(timetable.courses.length);
    Course temp = timetable.courses[index1];
    timetable.courses[index1] = timetable.courses[index2];
    timetable.courses[index2] = temp;
  } else {
    // Change the room for a random course
    int courseIndex = Random().nextInt(timetable.courses.length);
    Room newRoom = getRandomAvailableRoom(timetable.courses[courseIndex]); // Implement getRandomAvailableRoom
    timetable.courses[courseIndex].room = newRoom;
  }

  // Recalculate fitness after mutation
  calculateFitness(timetable);
}