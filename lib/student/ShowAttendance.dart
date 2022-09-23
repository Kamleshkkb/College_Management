import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_management_app/Methods/methods.dart';
import 'package:flutter/material.dart';

class ShowAttendance extends StatefulWidget {
  const ShowAttendance({Key? key}) : super(key: key);

  @override
  State<ShowAttendance> createState() => _ShowAttendanceState();
}

class _ShowAttendanceState extends State<ShowAttendance> {
  Service _service = Service();
  String date = DateTime.now().day.toString() +
      "-" +
      DateTime.now().month.toString() +
      "-" +
      DateTime.now().year.toString();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      //appBar: AppBar(title: Text("Show Attendance")),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection('Attentance')
                      .doc(date)
                      .collection('Status')
                      .where('Rollno', isEqualTo: _service.getusername())
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData != null) {
                      return ListView.builder(
                          // itemCount: 1,
                          itemCount:
                              snapshot.hasData ? snapshot.data!.docs.length : 0,
                          reverse: false,
                          shrinkWrap: true,
                          primary: true,
                          physics: ScrollPhysics(),
                          itemBuilder: (context, i) {
                            QueryDocumentSnapshot x = snapshot.data!.docs[i];
                            return SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  height: 100,
                                  color: Colors.blueGrey,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text("Subject Name"),
                                          Text(x['Sn'])
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text("Subject Code"),
                                          Text(x['Sc'])
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text("Status"),
                                          CircleAvatar(
                                            backgroundColor:
                                                x['Status'] == 'present'
                                                    ? Colors.green
                                                    : Colors.red,
                                            child: Text(
                                              x['Status'] == 'present'
                                                  ? 'P'
                                                  : 'A',
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    } else {
                      return Text("No attendance");
                    }
                  }))
        ],
      ),
    );
  }
}
