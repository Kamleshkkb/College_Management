import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_management_app/Common/Document.dart';

import 'package:college_management_app/Common/openmessage.dart';
import 'package:college_management_app/Methods/methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Service _service = Service();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  int f = 0;
  int len = 0;

  first() async {
    await _firestore
        .collection('message')
        .doc(_service.getusername())
        .collection('chats')
        .get()
        .then((value) {
      setState(() {
        len = value.docs.length;
      });
    });
  }

  @override
  void initState() {
    first();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.brown,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                alignment: Alignment.topLeft,
                height: 40,
                child: Text(
                  "LATEST MESSAGE",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.deepOrange),
                ),
              ),
            ),
            len > 0
                ? StreamBuilder<QuerySnapshot>(
                    stream: _firestore
                        .collection('message')
                        .doc(_service.getusername())
                        .collection('chats')
                        .orderBy('time', descending: true)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData != null) {
                        return ListView.builder(
                            itemCount: snapshot.hasData ? 1 : 0,
                            reverse: false,
                            shrinkWrap: true,
                            primary: true,
                            physics: ScrollPhysics(),
                            itemBuilder: (context, i) {
                              QueryDocumentSnapshot x =
                                  snapshot.data!.docs.first;
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
                                                  Urlname: x['Url'],
                                                )));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
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
                                                          child: Text(x['time']
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
                                                                          attachsize: x[
                                                                              'Attachment'],
                                                                          urlname:
                                                                              x['Url'])));
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
                                                          const EdgeInsets.only(
                                                              left: 35.0,
                                                              right: 8),
                                                      child: Text(
                                                        x['Subject'],
                                                        textAlign:
                                                            TextAlign.start,
                                                      ),
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
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      } else
                        return Container(
                          child: Text("no data"),
                        );
                    })
                : Container(
                    child: Text("No data"),
                  ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                alignment: Alignment.topLeft,
                height: 40,
                child: Text(
                  "LATEST NEWS",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.deepOrange),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('Notice')
                    .doc('All')
                    .collection('News')
                    .orderBy('time', descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData != null) {
                    return ListView.builder(
                        itemCount: snapshot.hasData ? 1 : 0,
                        reverse: false,
                        shrinkWrap: true,
                        primary: true,
                        physics: ScrollPhysics(),
                        itemBuilder: (context, i) {
                          QueryDocumentSnapshot x = snapshot.data!.docs.first;
                          return SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
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
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 35, right: 8),
                                                    child: Text(x['time']
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
                                                            "${x['time'].toString().substring(14, 16)}")),
                                                  ),
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (_) => ViewDocument(
                                                                    attachsize: x[
                                                                        'Attachment'],
                                                                    urlname: x[
                                                                        'Url'])));
                                                      },
                                                      child: x['Attachment'] ==
                                                              0
                                                          ? Container()
                                                          : Text(
                                                              "${x['Attachment']} Attachment"))
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 35, right: 8),
                                                child: Text(
                                                  x['News'],
                                                  textAlign: TextAlign.start,
                                                ),
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
                                            x['Name'],
                                            style:
                                                TextStyle(color: Colors.white),
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
                                    height: 40,
                                  ),
                                ],
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
    );
  }
}
