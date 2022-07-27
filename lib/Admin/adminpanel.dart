import 'package:college_management_app/Admin/Edit.dart';
import 'package:college_management_app/Common/Message.dart';
import 'package:college_management_app/Common/News.dart';
import 'package:college_management_app/Common/home.dart';
import 'package:college_management_app/Common/profile.dart';
import 'package:college_management_app/Methods/methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({Key? key}) : super(key: key);

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  int currentindex = 0;
  FirebaseAuth auth = FirebaseAuth.instance;
  Service _service = Service();
  final tabs = [Home(), News(), Message(), Edit()];
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
              icon: Icon(Icons.edit),
              backgroundColor: Colors.blue,
              label: 'Edit',
              tooltip: 'Edit'),
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
                  Text('Admin'),
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
            ],
          ),
        ),
      ),
    );
  }
}
