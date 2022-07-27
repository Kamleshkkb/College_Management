
import 'package:college_management_app/Common/Message.dart';
import 'package:college_management_app/Common/News.dart';
import 'package:college_management_app/Common/profile.dart';
import 'package:college_management_app/Methods/methods.dart';
import 'package:college_management_app/student/ShowAttendance.dart';
import 'package:college_management_app/student/Timetable.dart';
import 'package:college_management_app/Common/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int currentindex = 0;
  FirebaseAuth auth = FirebaseAuth.instance;
  Service _service = Service();

  final tabs = [Home(), News(), Message(), Timetable(), ShowAttendance()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("College Managment"),
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
              icon: Icon(Icons.calendar_month),
              backgroundColor: Colors.blue,
              label: 'Timetable',
              tooltip: 'Timetable'),
          BottomNavigationBarItem(
              icon: Icon(Icons.thumb_up_outlined),
              backgroundColor: Colors.blue,
              label: 'Attendance',
              tooltip: 'Attendace'),
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
                  Text("Student"),
                  TextButton.icon(
                      onPressed: () {
                        _service.logout(context);
                      },
                      icon: Icon(Icons.logout),
                      label: Text("Logout")),
                  Text(
                      "We definitely that a |n good health is a biggest asset |n all can build in their lives. |n This application put a small effort to you |n doing that, though that data may not 100%|n accurate. ")
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Copyright@2018, CDGI IT Service : Qualswebs",
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
