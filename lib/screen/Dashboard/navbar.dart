import 'package:flutter/material.dart';
import 'package:untitled/screen/Dashboard/dashboard.dart';

import '../../services/auth.dart';

class NavBar extends StatelessWidget {
  NavBar({super.key});
  final AuthService _auth =  AuthService();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text("Harish Bhagwan Barhate "),
              accountEmail: const Text('harishbarhate29@gamil.com'),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child:  Image.asset('assets/image/profile.jpeg'),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.space_dashboard),
              title: const Text("Dashboard"),
              onTap: (){
                Navigator.push(
                      context,
                    MaterialPageRoute(builder: (context) => Home()),
                    );
              }
            ),
            ListTile(
                leading: const Icon(Icons.house),
                title: const Text("Rooms & Labs"),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                }
            ),
            ListTile(
                leading: const Icon(Icons.book_outlined),
                title: const Text("Courses"),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                }
            ),
            ListTile(
                leading: const Icon(Icons.school),
                title: const Text("Faculty"),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                }
            ),
            ListTile(
                leading: const Icon(Icons.group),
                title: const Text("Classes"),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                }
            ),
            ListTile(
                leading: const Icon(Icons.space_dashboard),
                title: const Text("Dashboard"),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                }
            ),
            ListTile(
                leading: const Icon(Icons.space_dashboard),
                title: const Text("Dashboard"),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                }
            ),
            ListTile(
              leading: const Icon(Icons.logout_outlined),
              title: const Text("Sign Out"),
              onTap: () async {
                await _auth.signOut();
              },
            )
          ]),

    );
  }
}