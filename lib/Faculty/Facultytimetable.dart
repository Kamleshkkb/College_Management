import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_management_app/Faculty/Attendance.dart';
import 'package:college_management_app/Methods/methods.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Timetable extends StatefulWidget {
  const Timetable({Key? key}) : super(key: key);

  @override
  State<Timetable> createState() => _TimetableState();
}

class _TimetableState extends State<Timetable> {
  Widget timetable(String st, String et, String sn, String sc, String rn,
      String br, String sem) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 150,
              width: 100,
              color: Colors.blueGrey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [Text(st), Text("to"), Text(et)],
              ),
            ),
            Container(
                padding: EdgeInsets.all(5.0),
                height: 150,
                width: 258,
                color: Colors.blueGrey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Subject name : $sn"),
                              SizedBox(
                                height: 5,
                              ),
                              Text("subject code : $sc"),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Room no : $rn"),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Branch : $br"),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Semester : $sem"),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                )),
          ],
        )
      ],
    );
  }

  int day = DateTime.now().weekday;
  int daydate = DateTime.now().day;
  int daymonth = DateTime.now().month;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Service _service = Service();



 
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.brown,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  FlatButton(
                      color: day == 1 ? Colors.cyan : Colors.blue,
                      onPressed: () {
                        setState(() {
                          if (day > 1) {
                            int temp = day - 1;
                            daydate = daydate - temp;
                          } else {
                            int temp = 1 - day;
                            daydate = daydate + temp;
                          }
                          day = 1;
                        });
                      },
                      child: Text("Monday")),
                  SizedBox(
                    width: 6,
                  ),
                  FlatButton(
                      color: day == 2 ? Colors.cyan : Colors.blue,
                      onPressed: () {
                        setState(() {
                          if (day > 2) {
                            int temp = day - 2;
                            daydate = daydate - temp;
                          } else {
                            int temp = 2 - day;
                            daydate = daydate + temp;
                          }
                          day = 2;
                        });
                      },
                      child: Text("Tuesday")),
                  SizedBox(
                    width: 6,
                  ),
                  FlatButton(
                      color: day == 3 ? Colors.cyan : Colors.blue,
                      onPressed: () {
                        setState(() {
                          if (day > 3) {
                            int temp = day - 3;
                            daydate = daydate - temp;
                          } else {
                            int temp = 3 - day;
                            daydate = daydate + temp;
                          }
                          day = 3;
                        });
                      },
                      child: Text("Wednesday")),
                  SizedBox(
                    width: 6,
                  ),
                  FlatButton(
                      color: day == 4 ? Colors.cyan : Colors.blue,
                      onPressed: () {
                        setState(() {
                          if (day > 4) {
                            int temp = day - 4;
                            daydate = daydate - temp;
                          } else {
                            int temp = 4 - day;
                            daydate = daydate + temp;
                          }
                          day = 4;
                        });
                      },
                      child: Text("Thursday")),
                  SizedBox(
                    width: 6,
                  ),
                  FlatButton(
                      color: day == 5 ? Colors.cyan : Colors.blue,
                      onPressed: () {
                        setState(() {
                          if (day > 5) {
                            int temp = day - 5;
                            daydate = daydate - temp;
                          } else {
                            int temp = 5 - day;
                            daydate = daydate + temp;
                          }
                          day = 5;
                        });
                      },
                      child: Text("Friday")),
                  SizedBox(
                    width: 6,
                  ),
                  SizedBox(
                    width: 6,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 9,
              child: ListView(
                children: [
                  day == 1
                      ? StreamBuilder<QuerySnapshot>(
                          stream: _firestore
                              .collection('Faculty Time Table')
                              .doc(_service.getusername())
                              .collection('monday')
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData != null) {
                              return ListView.builder(
                                  // itemCount: 1,
                                  itemCount: snapshot.hasData
                                      ? snapshot.data!.docs.length
                                      : 0,
                                  reverse: false,
                                  shrinkWrap: true,
                                  primary: true,
                                  physics: ScrollPhysics(),
                                  itemBuilder: (context, i) {
                                    QueryDocumentSnapshot x =
                                        snapshot.data!.docs[i];
                                    return SingleChildScrollView(
                                        child: GestureDetector(
                                      onTap: () {
                                        print("inside time");
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => NameofStudent(
                                                    branch: x['br'],
                                                    semester: x['sem'],
                                                    subname: x['sn'],
                                                    subjectcode: x['sc'])));
                                      },
                                      child: timetable(
                                          x['st'],
                                          x['et'],
                                          x['sn'],
                                          x['sc'],
                                          x['rn'],
                                          x['sem'],
                                          x['br']),
                                    ));
                                  });
                            } else {
                              return CircularProgressIndicator();
                            }
                          })
                      : Container(),
                  day == 2
                      ? StreamBuilder<QuerySnapshot>(
                          stream: _firestore
                              .collection('Faculty Time Table')
                              .doc(_service.getusername())
                              .collection('tuesday')
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData != null) {
                              return ListView.builder(
                                  // itemCount: 1,
                                  itemCount: snapshot.hasData
                                      ? snapshot.data!.docs.length
                                      : 0,
                                  reverse: false,
                                  shrinkWrap: true,
                                  primary: true,
                                  physics: ScrollPhysics(),
                                  itemBuilder: (context, i) {
                                    QueryDocumentSnapshot x =
                                        snapshot.data!.docs[i];
                                    return SingleChildScrollView(
                                      child: GestureDetector(
                                          onTap: () {


                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        NameofStudent(
                                                            branch: x['br'],
                                                            semester: x['sem'],
                                                            subname: x['sn'],
                                                            subjectcode:
                                                                x['sc'])));
                                          },
                                          child: timetable(
                                              x['st'],
                                              x['et'],
                                              x['sn'],
                                              x['sc'],
                                              x['rn'],
                                              x['sem'],
                                              x['br'])),
                                    );
                                  });
                            } else {
                              return CircularProgressIndicator();
                            }
                          })
                      : Container(),
                  day == 3
                      ? StreamBuilder<QuerySnapshot>(
                          stream: _firestore
                              .collection('Faculty Time Table')
                              .doc(_service.getusername())
                              .collection('wednesday')
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData != null) {
                              return ListView.builder(
                                  // itemCount: 1,
                                  itemCount: snapshot.hasData
                                      ? snapshot.data!.docs.length
                                      : 0,
                                  reverse: false,
                                  shrinkWrap: true,
                                  primary: true,
                                  physics: ScrollPhysics(),
                                  itemBuilder: (context, i) {
                                    QueryDocumentSnapshot x =
                                        snapshot.data!.docs[i];
                                    return SingleChildScrollView(
                                      child: GestureDetector(
                                          onTap: (() {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        NameofStudent(
                                                            branch: x['br'],
                                                            semester: x['sem'],
                                                            subname: x['sn'],
                                                            subjectcode:
                                                                x['sc'])));
                                          }),
                                          child: timetable(
                                              x['st'],
                                              x['et'],
                                              x['sn'],
                                              x['sc'],
                                              x['rn'],
                                              x['sem'],
                                              x['br'])),
                                    );
                                  });
                            } else {
                              return CircularProgressIndicator();
                            }
                          })
                      : Container(),
                  day == 4
                      ? StreamBuilder<QuerySnapshot>(
                          stream: _firestore
                              .collection('Faculty Time Table')
                              .doc(_service.getusername())
                              .collection('thursday')
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData != null) {
                              return ListView.builder(
                                  // itemCount: 1,
                                  itemCount: snapshot.hasData
                                      ? snapshot.data!.docs.length
                                      : 0,
                                  reverse: false,
                                  shrinkWrap: true,
                                  primary: true,
                                  physics: ScrollPhysics(),
                                  itemBuilder: (context, i) {
                                    QueryDocumentSnapshot x =
                                        snapshot.data!.docs[i];
                                    return SingleChildScrollView(
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        NameofStudent(
                                                            branch: x['br'],
                                                            semester: x['sem'],
                                                            subname: x['sn'],
                                                            subjectcode:
                                                                x['sc'])));
                                          },
                                          child: timetable(
                                              x['st'],
                                              x['et'],
                                              x['sn'],
                                              x['sc'],
                                              x['rn'],
                                              x['sem'],
                                              x['br'])),
                                    );
                                  });
                            } else {
                              return CircularProgressIndicator();
                            }
                          })
                      : Container(),
                  day == 5
                      ? StreamBuilder<QuerySnapshot>(
                          stream: _firestore
                              .collection('Faculty Time Table')
                              .doc(_service.getusername())
                              .collection('fridays')
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData != null) {
                              return ListView.builder(
                                  // itemCount: 1,
                                  itemCount: snapshot.hasData
                                      ? snapshot.data!.docs.length
                                      : 0,
                                  reverse: false,
                                  shrinkWrap: true,
                                  primary: true,
                                  physics: ScrollPhysics(),
                                  itemBuilder: (context, i) {
                                    QueryDocumentSnapshot x =
                                        snapshot.data!.docs[i];
                                    return SingleChildScrollView(
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        NameofStudent(
                                                            branch: x['br'],
                                                            semester: x['sem'],
                                                            subname: x['sn'],
                                                            subjectcode:
                                                                x['sc'])));
                                          },
                                          child: timetable(
                                              x['st'],
                                              x['et'],
                                              x['sn'],
                                              x['sc'],
                                              x['rn'],
                                              x['sem'],
                                              x['br'])),
                                    );
                                  });
                            } else {
                              return CircularProgressIndicator();
                            }
                          })
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
