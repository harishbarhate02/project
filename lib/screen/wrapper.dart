import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../model/FirebaseUser.dart';
import 'Dashboard/dashboard.dart';
import 'authenticate/handler.dart';

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