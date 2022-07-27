import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_management_app/Common/Document.dart';
import 'package:college_management_app/Common/Newsinput.dart';
import 'package:college_management_app/Methods/methods.dart';

import 'package:flutter/material.dart';

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  Service _service = Service();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool all = true;
  bool tp = false;
  bool other = false;

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
                      color: all == true ? Colors.cyan : Colors.blue,
                      child: FlatButton(
                          onPressed: () {
                            setState(() {
                              all = true;
                              tp = false;
                              other = false;
                            });
                          },
                          child: Text("ALL"))),
                  Container(
                      height: 50,
                      width: 100,
                      child: FlatButton(
                          color: tp == true ? Colors.cyan : Colors.blue,
                          onPressed: () {
                            setState(() {
                              all = false;
                              tp = true;
                              other = false;
                            });
                          },
                          child: Text("T&P"))),
                  Container(
                      height: 50,
                      width: 100,
                      color: other == true ? Colors.cyan : Colors.blue,
                      child: FlatButton(
                          onPressed: () {
                            setState(() {
                              all = false;
                              tp = false;
                              other = true;
                            });
                          },
                          child: Text("OTHERS")))
                ],
              ),
              SizedBox(
                height: 40,
              ),
              all == true
                  ? StreamBuilder<QuerySnapshot>(
                      stream: _firestore
                          .collection('Notice')
                          .doc('All')
                          .collection('News')
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
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(18),
                                          child: Stack(
                                            fit: StackFit.passthrough,
                                            clipBehavior: Clip.none,
                                            //  overflow: Overflow.visible,
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
                                                        TextButton(
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
                                                            child: x['Attachment'] ==
                                                                    0
                                                                ? Container()
                                                                : Text(
                                                                    "${x['Attachment']} Attachment"))
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 35,
                                                              right: 8),
                                                      child: Text(x['News']),
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
                                );
                              });
                        } else {
                          return CircularProgressIndicator();
                        }
                      })
                  : tp == true
                      ? StreamBuilder<QuerySnapshot>(
                          stream: _firestore
                              .collection('Notice')
                              .doc('T&P')
                              .collection('News')
                              .orderBy('time', descending: true)
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
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
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(12),
                                              child: Stack(
                                                fit: StackFit.passthrough,
                                                clipBehavior: Clip.none,
                                                //  overflow: Overflow.visible,
                                                children: [
                                                  Container(
                                                    color: Colors.white,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
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
                                                                          8,
                                                                          10) +
                                                                  "/" +
                                                                  x['time']
                                                                      .toString()
                                                                      .substring(
                                                                          5,
                                                                          7) +
                                                                  "/" +
                                                                  x['time']
                                                                      .toString()
                                                                      .substring(
                                                                          0,
                                                                          4) +
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
                                                                              attachsize: x['Attachment'],
                                                                              urlname: x['Url'])));
                                                                },
                                                                child: x['Attachment'] ==
                                                                        0
                                                                    ? Container()
                                                                    : Text(
                                                                        "${x['Attachment']} Attachment"))
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 35,
                                                                  right: 8),
                                                          child:
                                                              Text(x['News']),
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
                                              height: 40,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            } else {
                              return Container();
                            }
                          })
                      : StreamBuilder<QuerySnapshot>(
                          stream: _firestore
                              .collection('Notice')
                              .doc('Others')
                              .collection('News')
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
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(12),
                                              child: Stack(
                                                fit: StackFit.passthrough,
                                                clipBehavior: Clip.none,
                                                // overflow: Overflow.visible,
                                                children: [
                                                  Container(
                                                    color: Colors.white,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
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
                                                                          8,
                                                                          10) +
                                                                  "/" +
                                                                  x['time']
                                                                      .toString()
                                                                      .substring(
                                                                          5,
                                                                          7) +
                                                                  "/" +
                                                                  x['time']
                                                                      .toString()
                                                                      .substring(
                                                                          0,
                                                                          4) +
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
                                                                              attachsize: x['Attachment'],
                                                                              urlname: x['Url'])));
                                                                },
                                                                child: x['Attachment'] ==
                                                                        0
                                                                    ? Container()
                                                                    : Text(
                                                                        "${x['Attachment']} Attachment"))
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 35,
                                                                  right: 8),
                                                          child:
                                                              Text(x['News']),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => Newsinput()));
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
