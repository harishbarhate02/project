import 'package:flutter/material.dart';
import 'package:untitled/screen/Dashboard/dashboard.dart';

import '../../services/auth.dart';

class NavBar extends StatelessWidget {
  NavBar({super.key});
  final AuthService _auth = new AuthService();
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
                  child:  Image.asset('assets/image/profile.jpeg'),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.space_dashboard),
              title: Text("Dashboard"),
              onTap: (){
                Navigator.push(
                      context,
                    MaterialPageRoute(builder: (context) => Home()),
                    );
              }
            ),
            ListTile(
                leading: Icon(Icons.house),
                title: Text("Rooms & Labs"),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                }
            ),
            ListTile(
                leading: Icon(Icons.book_outlined),
                title: Text("Courses"),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                }
            ),
            ListTile(
                leading: Icon(Icons.school),
                title: Text("Faculty"),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                }
            ),
            ListTile(
                leading: Icon(Icons.group),
                title: Text("Classes"),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                }
            ),
            ListTile(
                leading: Icon(Icons.space_dashboard),
                title: Text("Dashboard"),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                }
            ),
            ListTile(
                leading: Icon(Icons.space_dashboard),
                title: Text("Dashboard"),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                }
            ),
            ListTile(
              leading: Icon(Icons.logout_outlined),
              title: Text("Sign Out"),
              onTap: () async {
                await _auth.signOut();
              },
            )
          ]),

    );
  }
}