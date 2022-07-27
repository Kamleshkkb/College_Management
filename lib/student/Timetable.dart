import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_management_app/Methods/methods.dart';
import 'package:flutter/material.dart';

class Timetable extends StatefulWidget {
  const Timetable({Key? key}) : super(key: key);

  @override
  State<Timetable> createState() => _TimetableState();
}

class _TimetableState extends State<Timetable> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Service _service = Service();
  Widget timetable(
      String st, String et, String sn, String sc, String rn, String fn) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 100,
              width: 100,
              color: Colors.blueGrey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [Text(st), Text("to"), Text(et)],
              ),
            ),
            Container(
                padding: EdgeInsets.all(5.0),
                height: 100,
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
                              Text(sn),
                              SizedBox(
                                height: 5,
                              ),
                              Text(sc),
                              SizedBox(
                                height: 5,
                              ),
                              Text(rn),
                              SizedBox(
                                height: 5,
                              ),
                              Text(fn)
                            ],
                          ),
                        ),
                        // Container(
                        //   child: CircleAvatar(
                        //     backgroundColor: Colors.red,
                        //             child: Text("A"),
                        //   ),
                        // )
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
                  FlatButton(
                      color: day == 6 ? Colors.cyan : Colors.blue,
                      onPressed: () {
                        setState(() {
                          if (day > 6) {
                            int temp = day - 6;
                            daydate = daydate - temp;
                          } else {
                            int temp = 6 - day;
                            daydate = daydate + temp;
                          }
                          day = 6;
                        });
                      },
                      child: Text("Saturday")),
                  SizedBox(
                    width: 6,
                  ),
                ],
              ),
            ),

            //  Expanded(
            //    flex: 1,
            //    child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Text("5 June to 11 June "),
            //             Text("$daydate ${DateTime.now().month}")
            //           ],
            //         ),
            //  ),
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
                              .collection('TimeTable')
                              .doc(_service.getuserbranch())
                              .collection('Time table details')
                              .doc(_service.getusersem())
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
                                      child: timetable(x['st'], x['et'],
                                          x['sn'], x['sc'], x['rn'], x['fn']),
                                    );
                                  });
                            } else {
                              return CircularProgressIndicator();
                            }
                          })
                      : Container(),
                  day == 2
                      ? StreamBuilder<QuerySnapshot>(
                          stream: _firestore
                              .collection('TimeTable')
                              .doc(_service.getuserbranch())
                              .collection('Time table details')
                              .doc(_service.getusersem())
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
                                      child: timetable(x['st'], x['et'],
                                          x['sn'], x['sc'], x['rn'], x['fn']),
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
                              .collection('TimeTable')
                              .doc(_service.getuserbranch())
                              .collection('Time table details')
                              .doc(_service.getusersem())
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
                                      child: timetable(x['st'], x['et'],
                                          x['sn'], x['sc'], x['rn'], x['fn']),
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
                              .collection('TimeTable')
                              .doc(_service.getuserbranch())
                              .collection('Time table details')
                              .doc(_service.getusersem())
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
                                      child: timetable(x['st'], x['et'],
                                          x['sn'], x['sc'], x['rn'], x['fn']),
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
                              .collection('TimeTable')
                              .doc(_service.getuserbranch())
                              .collection('Time table details')
                              .doc(_service.getusersem())
                              .collection('friday')
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
                                      child: timetable(x['st'], x['et'],
                                          x['sn'], x['sc'], x['rn'], x['fn']),
                                    );
                                  });
                            } else {
                              return CircularProgressIndicator();
                            }
                          })
                      : Container(),

                  day == 6
                      ? StreamBuilder<QuerySnapshot>(
                          stream: _firestore
                              .collection('TimeTable')
                              .doc(_service.getuserbranch())
                              .collection('Time table details')
                              .doc(_service.getusersem())
                              .collection('saturday')
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
                                      child: timetable(x['st'], x['et'],
                                          x['sn'], x['sc'], x['rn'], x['fn']),
                                    );
                                  });
                            } else {
                              return CircularProgressIndicator();
                            }
                          })
                      : Container(),
                  // DateTime.now().weekday==6? Container(
                  //    child: Column(
                  //      children: [
                  //        Text("Monday"),

                  //      ],
                  //    ),
                  //  ):Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
