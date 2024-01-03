// TODO Implement this library.
import 'package:flutter/material.dart';
import 'package:untitled/screen/home/navbar.dart';

import '../../services/auth.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Home();
  }
}

class _Home extends State<Home> {
  final AuthService _auth = new AuthService();

  @override
  Widget build(BuildContext context) {
    final SignOut = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          await _auth.signOut();
        },
        child: Text(
          "Log out",
          style: TextStyle(color: Theme.of(context).primaryColorLight),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return  Scaffold(
      drawer : NavBar(),
      appBar: AppBar(
        title: const Text('Smart TimeTable'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(child: SignOut),
    );
  }
}