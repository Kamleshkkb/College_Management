import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_management_app/Common/Document.dart';
import 'package:college_management_app/Common/Messageinput.dart';
import 'package:college_management_app/Common/openmessage.dart';
import 'package:college_management_app/Methods/methods.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class Message extends StatefulWidget {
  const Message({Key? key}) : super(key: key);

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  Service _service = Service();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool inbox = true;
  bool sent = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.brown,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      height: 50,
                      width: 100,
                      color: inbox == true ? Colors.cyan : Colors.blue,
                      child: FlatButton(
                          onPressed: () {
                            setState(() {
                              inbox = true;
                              sent = false;
                            });
                          },
                          child: Text("Inbox"))),
                  Container(
                      height: 50,
                      width: 100,
                      child: FlatButton(
                          color: sent == true ? Colors.cyan : Colors.blue,
                          onPressed: () {
                            setState(() {
                              sent = true;
                              inbox = false;
                            });
                          },
                          child: Text("Sent"))),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              inbox == true
                  ? StreamBuilder<QuerySnapshot>(
                      stream: _firestore
                          .collection('message')
                          .doc(_service.getusername())
                          .collection('chats')
                          .orderBy('time', descending: true)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData != null) {
                          return ListView.builder(
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
                                              builder: (_) => OpenMessage(
                                                  subject: x['Subject'],
                                                  name: x['Sendby'],
                                                  message: x['Message'],
                                                  date: x['time']
                                                          .toString()
                                                          .substring(8, 10) +
                                                      "/" +
                                                      x['time']
                                                          .toString()
                                                          .substring(5, 7) +
                                                      "/" +
                                                      x['time']
                                                          .toString()
                                                          .substring(0, 4) +
                                                      " " +
                                                      _service.amtopm(
                                                          "${x['time'].toString().substring(11, 13)}",
                                                          "${x['time'].toString().substring(14, 16)}"),
                                                  size: x['Attachment'],
                                                  Urlname: x['Url'])));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(12),
                                            child: Stack(
                                              fit: StackFit.passthrough,
                                              clipBehavior: Clip.none,
                                              children: [
                                                Container(
                                                  color: Colors.white,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 35,
                                                                    right: 8),
                                                            child: Text(x[
                                                                        'time']
                                                                    .toString()
                                                                    .substring(
                                                                        8, 10) +
                                                                "/" +
                                                                x['time']
                                                                    .toString()
                                                                    .substring(
                                                                        5, 7) +
                                                                "/" +
                                                                x['time']
                                                                    .toString()
                                                                    .substring(
                                                                        0, 4) +
                                                                " " +
                                                                _service.amtopm(
                                                                    "${x['time'].toString().substring(11, 13)}",
                                                                    "${x['time'].toString().substring(14, 16)}")),
                                                          ),
                                                          IconButton(
                                                              onPressed: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (_) => ViewDocument(
                                                                            attachsize:
                                                                                x['Attachment'],
                                                                            urlname: x['Url'])));
                                                              },
                                                              icon: x['Attachment'] ==
                                                                      0
                                                                  ? Container()
                                                                  : Icon(Icons
                                                                      .attachment))
                                                        ],
                                                      ),

                                                      // SizedBox(height: 10,),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 35,
                                                                right: 8),
                                                        child:
                                                            Text(x['Subject']),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Positioned(
                                                  top: -30,
                                                  left: 40,
                                                  child: Text(
                                                    x['Sendby'],
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: -30,
                                                  left: -20,
                                                  child: CircleAvatar(
                                                      radius: 25,
                                                      child: IconButton(
                                                          onPressed: () {},
                                                          icon: const Icon(
                                                              Icons.person))),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        } else {
                          return CircularProgressIndicator();
                        }
                      })
                  : StreamBuilder<QuerySnapshot>(
                      stream: _firestore
                          .collection('sent')
                          .doc(_service.getusername())
                          .collection('chats')
                          .orderBy('time', descending: true)
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
                                              builder: (_) => OpenMessage(
                                                  subject: x['Subject'],
                                                  name: x['Sendto'],
                                                  message: x['Message'],
                                                  date: x['time']
                                                          .toString()
                                                          .substring(8, 10) +
                                                      "/" +
                                                      x['time']
                                                          .toString()
                                                          .substring(5, 7) +
                                                      "/" +
                                                      x['time']
                                                          .toString()
                                                          .substring(0, 4) +
                                                      " " +
                                                      _service.amtopm(
                                                          "${x['time'].toString().substring(11, 13)}",
                                                          "${x['time'].toString().substring(14, 16)}"),
                                                  size: x['Attachment'],
                                                  Urlname: x['Url'])));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(12),
                                            child: Stack(
                                              fit: StackFit.passthrough,
                                              clipBehavior: Clip.none,
                                              children: [
                                                Container(
                                                  color: Colors.white,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 35,
                                                                    right: 8),
                                                            child: Text(x[
                                                                        'time']
                                                                    .toString()
                                                                    .substring(
                                                                        8, 10) +
                                                                "/" +
                                                                x['time']
                                                                    .toString()
                                                                    .substring(
                                                                        5, 7) +
                                                                "/" +
                                                                x['time']
                                                                    .toString()
                                                                    .substring(
                                                                        0, 4) +
                                                                " " +
                                                                _service.amtopm(
                                                                    "${x['time'].toString().substring(11, 13)}",
                                                                    "${x['time'].toString().substring(14, 16)}")),
                                                          ),
                                                          IconButton(
                                                              onPressed: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (_) => ViewDocument(
                                                                            attachsize:
                                                                                x['Attachment'],
                                                                            urlname: x['Url'])));
                                                              },
                                                              icon: x['Attachment'] ==
                                                                      0
                                                                  ? Container()
                                                                  : Icon(Icons
                                                                      .attachment))
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 35,
                                                                right: 8),
                                                        child:
                                                            Text(x['Subject']),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Positioned(
                                                  top: -30,
                                                  left: 40,
                                                  child: Text(
                                                    x['Sendto'],
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: -30,
                                                  left: -20,
                                                  child: CircleAvatar(
                                                      radius: 25,
                                                      child: IconButton(
                                                          onPressed: () {},
                                                          icon: const Icon(
                                                              Icons.person))),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        } else {
                          return CircularProgressIndicator();
                        }
                      })
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => Messageinput()));
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
