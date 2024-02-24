import 'package:flutter/material.dart';

class TimetableScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Timetable'),
    ),
    body: SingleChildScrollView(
    child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    'Shri Sant Gajanan Maharaj College of Engineering, Shegaon',
    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    ),
    Text(
    'Department of Computer Science & Engineering',
    ),
    Text(
    'Session 2023-2024 (Spring)',
    ),
    Text(
    'Time-Table',
    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
    ),
    SizedBox(height: 20.0),
    Text(
    'Class Room: B1/B3/B5',
    ),
    Text(
    'Class: 2R Semester IV w.e.f.: 22/01/2024',
    ),
    SizedBox(height: 20.0),
    Table(
    border: TableBorder.all(),
    columnWidths: {
    0: FractionColumnWidth(0.15),
    1: FractionColumnWidth(0.15),
    2: FractionColumnWidth(0.2),
    3: FractionColumnWidth(0.2),
    4: FractionColumnWidth(0.2),
    5: FractionColumnWidth(0.15),
    6: FractionColumnWidth(0.15),
  },
    children: [
    TableRow(
    children: [
    Text('Day'),
    Text('08.30 AM'),
    Text('09.30 AM'),
    Text('10.30AM'),
    Text('10.45 AM'),
    Text('11.45AM'),
    Text('12.45 AM'),
    ],
    ),
    TableRow(
    children: [
    Text('Mon'),
    Text('M&ALP(PVD) B3'),
    Text('DCN(KPS) B3'),
    Text('TOC(NMK) B3'),
    Text('Al(CMM) B3'),
    Text('OS(PKB) B1\nENVS(ASA) B1'),
    Text('RE'),
    ],
    ),
    TableRow(
    children: [
    Text('Tue'),
    Text('M&ALP(PVD) B3'),
    Text('Al(CMM) B3'),
    Text('OS(B)/DCN(C)/M&ALP(D)/CSKILL(A)PKB/KPS/PVD/VSM'),
    Text('OS(PKB) 81'),
    Text('TOC(NMK) B1'),
    Text('CE'),
    ],
    ),
    TableRow(
    children: [
    Text('Wed'),
    Text('M&ALP(PVD) B3'),
    Text('Al(CMM) B3'),
    Text('OS(C)/DON(D)/M&ALP(A)/CSKILL(B)PKB/KPS/PVD/VSM'),
    Text('OS(PKB) B1'),
    Text('DCN(KPS) B1'),
    Text('SS'),
    ],
    ),
    TableRow(
    children: [
    Text('Thu'),
    Text('DCN(KPS) B3'),
    Text('TOC(NMK) 83'),
    Text('OS(D)/DCN/A)/M&ALP(B)/CSKILL(C)PKE/KPSPVD/SBP'),
    Text('M&ALP(PVD) B1'),
    Text('OS(PKB) 81'),
    Text('Tu'),
    ],
    ),
    TableRow(
    children: [
    Text('Fri'),
    Text('Skill Development Program'),
    Text('BREAK'),
    Text('Skill Development Program'),
      ],
    ),
    ]
    ),
    ],
    ),
    ),
    ),
    );

    }
}

