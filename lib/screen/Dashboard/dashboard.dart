// TODO Implement this library.
import 'package:flutter/material.dart';
import 'package:untitled/screen/Classes/classes.dart';
import 'package:untitled/screen/Faculty/faculty.dart';
import 'package:untitled/screen/Rooms_Labs/Room_lab.dart';
import '../Courses/courses.dart';
import 'navbar.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Home();
  }
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final TimetableGeneratorButon = Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.teal[600],
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width * .25,
          height: MediaQuery.of(context).size.height * .1,
          padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          },
          child: Text(
            'Generate TimeTable',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ));

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: NavBar(),
      appBar: AppBar(
        title: const Text('Dashbooard'),
        backgroundColor: Colors.teal[600],
      ),
      body: Container(
        padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width * 0.04,top: 35),
        margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.04),

        child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  itemdetails('Rooms/Labs', '10', RoomsLabs()),
                  SizedBox(width: 10.0), // Fixed spacing
                  itemdetails('Courses', '4', Home()),
                  SizedBox(width: 10.0), // Fixed spacing
                  itemdetails('Faculty', '10', FacultysLabs()),
                  SizedBox(width: 10.0), // Fixed spacing
                  itemdetails('Classes', '5',ClassLabs()),

                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: TimetableGeneratorButon,
            ),
          ],
        ),
      ),
    );
  }

  itemdetails(String title, String count, Widget route) => Container(
    margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(8),
    height: MediaQuery.of(context).size.height * 0.22,
    width: MediaQuery.of(context).size.width * 0.17,
    decoration: BoxDecoration(
      color: Colors.white,
          borderRadius: BorderRadius.circular(40),
      border: Border.all(
        color: Color(0xFF00796B), // Customize border color
        width: 2.0, // Adjust border width
        style: BorderStyle.solid, // Choose border style (e.g., dashed, dotted)
      ),
      // boxShadow: [
      //   BoxShadow(
      //     offset: Offset(0, 5),
      //     blurRadius: 5,
      //     color: Color(0xFF00796B),
      //   spreadRadius: 2
      //   ),
      // ]
    ),
    child: InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => route),
        );

      },
      child: Container(
        child: Column(
          children: [
            Text(title,style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text(count,style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
          ]
        ),
      ),
    ),
  );
}