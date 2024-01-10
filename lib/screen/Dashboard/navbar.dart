import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Harish Bhagwan Barhate "),
              accountEmail: Text('harishbarhate29@gamil.com'),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child:  Image.asset('asset/Screenshot(221).png'),
                ),
              ),
            ),
          ]),

    );
  }
}
