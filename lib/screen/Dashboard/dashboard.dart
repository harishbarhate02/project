// TODO Implement this library.
import 'package:flutter/material.dart';
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
        color: Colors.white,
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
      backgroundColor: Colors.orange[200],
      drawer: NavBar(),
      appBar: AppBar(
        title: const Text('Dashbooard'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width * 0.04,top: 35),
        margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.04),
        child: Column(

          children: [
            Row(children: [
              itemdetails('Room', '8'),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.04,
              ),
              itemdetails('romm', '8'),
              SizedBox(
                width:MediaQuery.of(context).size.width * 0.04,
              ),
              itemdetails('romm', '8'),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.04,
              ),
              itemdetails('romm', '8'),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.04,
              ),

            ]),
            Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: TimetableGeneratorButon,
            )
          ],
        ),
      ),
    );
  }

  itemdetails(String title, String count) => Container(
    margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(8),
    height: MediaQuery.of(context).size.height * 0.22,
    width: MediaQuery.of(context).size.width * 0.17,
    decoration: BoxDecoration(
      color: Colors.deepOrange[400],
          borderRadius: BorderRadius.circular(40),
      boxShadow: [
        BoxShadow(
          offset: Offset(0, 5),
          blurRadius: 5,
          color: Color(0xffEEEEEE),
        spreadRadius: 2
        ),
      ]
    ),
    child: Column(
      children: [
        Text(title,style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
        SizedBox(height: 10,),
        Text(count,style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
      ]
    ),
  );
}