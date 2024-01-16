import 'package:flutter/material.dart';
import 'package:untitled/screen/wrapper.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
void  initState(){
  super.initState();
  _navigatetohome();
  }
_navigatetohome() async{
  await Future.delayed(const Duration(seconds: 1));
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => Wrapper()));
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: const Column(

            children: [
              SizedBox( height : 250),
              CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage('assets/image/logo.png'),
              ),
              SizedBox( height : 150),
              Text('Smart TimeTable;',style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w400,
              ),),

            ],
          ),
    ),
      ),
    );

  }
}