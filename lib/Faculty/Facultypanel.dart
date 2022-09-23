import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_management_app/Common/profile.dart';
import 'package:college_management_app/Faculty/Attendance.dart';
import 'package:college_management_app/Common/Message.dart';
import 'package:college_management_app/Common/News.dart';
import 'package:college_management_app/Common/home.dart';
import 'package:college_management_app/Faculty/Facultytimetable.dart';
import 'package:college_management_app/Methods/methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FacultyBottomBar extends StatefulWidget {
  const FacultyBottomBar({Key? key}) : super(key: key);

  @override
  State<FacultyBottomBar> createState() => _FacultyBottomBarState();
}

class _FacultyBottomBarState extends State<FacultyBottomBar> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Service _service = Service();
  int currentindex = 0;
  FirebaseAuth auth = FirebaseAuth.instance;
  final tabs = [Home(), News(), Message(), Timetable()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("College Management"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Profile()));
              },
              icon: Icon(Icons.person)),
        ],
      ),
      body: tabs[currentindex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentindex,
        onTap: (index) {
          setState(() {
            currentindex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              backgroundColor: Colors.blue,
              label: "Home",
              tooltip: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.newspaper),
              backgroundColor: Colors.blue,
              label: 'News',
              tooltip: 'News'),
          BottomNavigationBarItem(
              icon: Icon(Icons.mail_outline_outlined),
              backgroundColor: Colors.blue,
              label: 'Message',
              tooltip: 'Message'),
          BottomNavigationBarItem(
              icon: Icon(Icons.thumb_up),
              backgroundColor: Colors.blue,
              label: 'Attendence',
              tooltip: 'Attendence'),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.brown,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  CircleAvatar(
                    radius: 50,
                    child: Icon(
                      Icons.person,
                      size: 70,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    _service.getUserName(),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Faculty"),
                  TextButton.icon(
                      onPressed: () {
                        _service.logout(context);
                      },
                      icon: Icon(Icons.logout),
                      label: Text("Logout")),
                    ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
