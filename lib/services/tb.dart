import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Timetable')),
        body: SingleChildScrollView(
          child: DataTable(columns: [
            DataColumn(label: Text('Day/Time')),
            DataColumn(label: Text('11.00AM')),
            DataColumn(label: Text('12.00PM')),
            DataColumn(label: Text('01.00PM')),
            DataColumn(label: Text('01.15PM')),
            DataColumn(label: Text('02.15PM')),
            DataColumn(label: Text('03.15PM')),
            DataColumn(label: Text('03.45PM')),
            DataColumn(label: Text('04.45PM')),
          ], rows: [
            DataRow(cells: [
              DataCell(Text('Mon')),
              DataCell(Text('ML&AI / SSSS (PVD) / (VSM) B3')),
              DataCell(Text('PE&BM')),
              DataCell(Text('DLT')),
              DataCell(Text('OOAD')),
              DataCell(Text('COURSERA / PROJECT & SEMINAR')),
              DataCell(Text('')),
              DataCell(Text('')),
              DataCell(Text('')),
            ]),
            DataRow(cells: [
              DataCell(Text('Tue')),
              DataCell(Text('DLT (A) LAB')),
              DataCell(Text('BREAK')),
              DataCell(Text('ML&AI / SSSS')),
              DataCell(Text('PE&BM')),
              DataCell(Text('COURSERA / PROJECT & SEMINAR')),
              DataCell(Text('(PVD)/(VSM)B5')),
              DataCell(Text('')),
              DataCell(Text('')),
            ]),
            DataRow(cells: [
              DataCell(Text('Wed')),
              DataCell(Text('DLT(B)LAb')),
              DataCell(Text('BREAK')),
              DataCell(Text('')),
              DataCell(Text('')),
              DataCell(Text('')),
              DataCell(Text('')),
              DataCell(Text('')),
              DataCell(Text('')),
            ]),
            DataRow(cells: [
              DataCell(Text('Thu')),
              DataCell(Text('PE&BM')),
              DataCell(Text('DLT (A) LAB')),
              DataCell(Text('COURSERA / PROJECT & SEMINAR')),
              DataCell(Text('ML&AI / SSSS')),
              DataCell(Text('BREAK')),
              DataCell(Text('(PVD)/(VSM)B5')),
              DataCell(Text('')),
              DataCell(Text('')),
            ]),
            DataRow(cells: [
              DataCell(Text('Fri')),
              DataCell(Text('DLT (A) LAB')),
              DataCell(Text('BREAK')),
              DataCell(Text('PE&BM')),
              DataCell(Text('COURSERA / PROJECT & SEMINAR')),
              DataCell(Text('ML&AI / SSSS')),
              DataCell(Text('(PVD)/(VSM)B5')),
              DataCell(Text('')),
              DataCell(Text('')),
            ]),
            DataRow(cells: [
              DataCell(Text('Sat')),
              DataCell(Text('BREAK')),
              DataCell(Text('DLT (A) LAB')),
              DataCell(Text('PE&BM')),
              DataCell(Text('COURSERA / PROJECT & SEMINAR')),
              DataCell(Text('ML&AI / SSSS')),
              DataCell(Text('(PVD)/(VSM)B5')),
              DataCell(Text('')),
              DataCell(Text('')),
            ]),
          ]),
        ),
      ),
    );
  }
}