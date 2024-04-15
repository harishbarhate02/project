import 'package:flutter/material.dart';


class Timetable1 extends StatelessWidget {
  final List<List<String>> timetable;
  final List<String> subjects;
  final List<String> dayLabels;

  const Timetable1({
    Key? key,
    required this.timetable,
    required this.subjects,
    required this.dayLabels,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: Colors.black),
      children: [
        _buildHeaderRow(),
        ...timetable.map((rowData) => _buildTimetableRow(rowData)).toList(),
      ],
    );
  }

  TableRow _buildHeaderRow() {
    return TableRow(
      children: [
        const TableCell(
          child: Center(
            child: Text('Day'),
          ),
        ),
        ...subjects.map((subject) => TableCell(
          child: Center(
            child: Text(subject),
          ),
        )).toList(),
      ],
    );
  }

  TableRow _buildTimetableRow(List<String> rowData) {
    return TableRow(
      children: [
        TableCell(
          child: Center(
            child: Text(rowData[0]),
          ),
        ),
        ...rowData.sublist(1).map((subjectData) => TableCell(
          child: Center(
            child: Text(subjectData),
          ),
        )).toList(),
      ],
    );
  }
}
main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  List<List<String>> timetable = [
    ['Mon', 'DCN', 'TOC', 'OS(A)/DCN(B)/M&ALP(C)/CSKILL(D)', 'Al', 'ENVS','envs'],
    ['Tue', 'M&ALP', 'DCN', 'TOC', 'Al', 'OS', 'ENVS'],
    ['Wed', 'M&ALP', 'DCN', 'TOC', 'Al', 'OS', 'ENVS'],
    ['Thu', 'M&ALP', 'DCN', 'TOC', 'Al', 'OS', 'ENVS'],
    ['Fri', 'M&ALP', 'DCN', 'TOC', 'Al', 'OS', 'ENVS'],

    // ... (similar data for other days)
  ];

  List<String> subjects = [
    'DCN',
    'TOC',
    'OS',
    'Al',
    'ENVS',
  ];

  List<String> dayLabels = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
    useMaterial3: true,
    ),
      home: Scaffold(
        body: Timetable1(
          timetable: timetable,
          subjects: subjects,
          dayLabels: dayLabels,
      )
      ),
    );
  }
}