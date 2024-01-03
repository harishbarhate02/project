import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../model/FirebaseUser.dart';
import 'authenticate/handler.dart';
import 'home/dashboard.dart';
import 'home/rooms_labs.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser?>(context);

    if (user == null) {
      return Handler();
    } else {
      return Home();
    }
  }
}