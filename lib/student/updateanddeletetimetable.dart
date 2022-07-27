import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class DeleteAndUpdateTimetable extends StatefulWidget {
  final String change;
  const DeleteAndUpdateTimetable({Key? key, required this.change})
      : super(key: key);

  @override
  State<DeleteAndUpdateTimetable> createState() =>
      _DeleteAndUpdateTimetableState();
}

class _DeleteAndUpdateTimetableState extends State<DeleteAndUpdateTimetable> {
  String dropdownvalue = 'CS';
  String dropdownvalue1 = '1';
  int f = 0;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  timetable(String st, String et, String sn, String sc, String fn, String rn,
      String day) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(day),
          Row(
            children: [Text("Starting time " + st)],
          ),
          Row(
            children: [Text("Ending time  " + et)],
          ),
          Row(
            children: [Text("Subject name  " + sn)],
          ),
          Row(
            children: [Text("Subject code  " + sc)],
          ),
          Row(
            children: [Text("Faculty name  " + fn)],
          ),
          Row(
            children: [Text("Room no  " + rn)],
          ),
          Divider(
            height: 10,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.change),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Select branch"),
                DropdownButton<String>(
                    value: dropdownvalue,
                    items: <String>['CS', 'IT', 'EC', 'CE', 'ME']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem(
                          value: value, child: Text("$value"));
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    })
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Select Semster"),
                DropdownButton<String>(
                    value: dropdownvalue1,
                    items: <String>['1', '2', '3', '4', '5', '6', '7', '8']
                        .map<DropdownMenuItem<String>>((String value1) {
                      return DropdownMenuItem(
                          value: value1, child: Text("$value1"));
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue1 = newValue!;
                      });
                    })
              ],
            ),
            f > 0
                ? Container(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: _firestore
                            .collection('TimeTable')
                            .doc(dropdownvalue)
                            .collection('Time table details')
                            .doc(dropdownvalue1)
                            .collection('monday')
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData != null) {
                            return ListView.builder(
                                itemCount: snapshot.hasData ? 1 : 0,
                                reverse: false,
                                shrinkWrap: true,
                                primary: true,
                                physics: ScrollPhysics(),
                                itemBuilder: (context, i) {
                                  QueryDocumentSnapshot x =
                                      snapshot.data!.docs[i];
                                  return SingleChildScrollView(
                                    child: timetable(x['st'], x['et'], x['sn'],
                                        x['sc'], x['fn'], x['rn'], 'monday'),
                                  );
                                });
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                  )
                : Text("no time table "),
            f > 0
                ? Container(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: _firestore
                            .collection('TimeTable')
                            .doc(dropdownvalue)
                            .collection('Time table details')
                            .doc(dropdownvalue1)
                            .collection('tuesday')
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData != null) {
                            return ListView.builder(
                                itemCount: snapshot.hasData ? 1 : 0,
                                reverse: false,
                                shrinkWrap: true,
                                primary: true,
                                physics: ScrollPhysics(),
                                itemBuilder: (context, i) {
                                  QueryDocumentSnapshot x =
                                      snapshot.data!.docs[i];
                                  return SingleChildScrollView(
                                    child: timetable(x['st'], x['et'], x['sn'],
                                        x['sc'], x['fn'], x['rn'], 'tuesday'),
                                  );
                                });
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                  )
                : Text("no time table "),
            f > 0
                ? Container(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: _firestore
                            .collection('TimeTable')
                            .doc(dropdownvalue)
                            .collection('Time table details')
                            .doc(dropdownvalue1)
                            .collection('wednesday')
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData != null) {
                            return ListView.builder(
                                itemCount: snapshot.hasData ? 1 : 0,
                                reverse: false,
                                shrinkWrap: true,
                                primary: true,
                                physics: ScrollPhysics(),
                                itemBuilder: (context, i) {
                                  QueryDocumentSnapshot x =
                                      snapshot.data!.docs[i];
                                  return SingleChildScrollView(
                                    child: timetable(x['st'], x['et'], x['sn'],
                                        x['sc'], x['fn'], x['rn'], 'wednesday'),
                                  );
                                });
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                  )
                : Text("no time table "),
            f > 0
                ? Container(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: _firestore
                            .collection('TimeTable')
                            .doc(dropdownvalue)
                            .collection('Time table details')
                            .doc(dropdownvalue1)
                            .collection('thursday')
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData != null) {
                            return ListView.builder(
                                itemCount: snapshot.hasData ? 1 : 0,
                                reverse: false,
                                shrinkWrap: true,
                                primary: true,
                                physics: ScrollPhysics(),
                                itemBuilder: (context, i) {
                                  QueryDocumentSnapshot x =
                                      snapshot.data!.docs[i];
                                  return SingleChildScrollView(
                                    child: timetable(x['st'], x['et'], x['sn'],
                                        x['sc'], x['fn'], x['rn'], 'thursday'),
                                  );
                                });
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                  )
                : Text("no time table "),
            //  f>0? Container(
            //     child:  StreamBuilder<QuerySnapshot>(
            //   stream: _firestore.collection('TimeTable')
            //         .doc(dropdownvalue)
            //        .collection('Time table details')
            //        .doc(dropdownvalue1)
            //         .collection('friday')
            //         .snapshots(),
            //         builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
            //    if (snapshot.hasData!=null) {

            //       return ListView.builder(

            //       itemCount: snapshot.hasData?
            //       1:0,
            //       reverse: false,
            //       shrinkWrap: true,
            //       primary: true,
            //       physics: ScrollPhysics(),
            //       itemBuilder: (context, i) {

            //         QueryDocumentSnapshot x = snapshot.data!.docs[i];
            //         return SingleChildScrollView(

            //                   child:timetable(x['st'],x['et'], x['sn'], x['sc'], x['fn'], x['rn'],'friday'),
            //     );

            //       }
            //     );
            //     } else {
            //       return CircularProgressIndicator();
            //     }
            //       }
            //     ),
            //   ):Text("no time table "),

            FlatButton(
                onPressed: () async {
                  await _firestore
                      .collection('TimeTable')
                      .doc(dropdownvalue)
                      .collection('Time table details')
                      .doc(dropdownvalue1)
                      .get()
                      .then((value) {
                    setState(() {
                      f = 1;
                      print(value);
                    });
                  });
                },
                child: Text("Search"))
          ],
        ),
      ),
    );
  }
}
