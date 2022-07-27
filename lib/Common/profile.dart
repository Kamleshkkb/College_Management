import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_management_app/Methods/methods.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Service _service = Service();
  String identity = '';

  inistate() {
    super.initState();
    getidentity();
  }

  getidentity() {
    setState(() {
      var tempname = _service.getusername();
      if (tempname.toString().substring(0, 1) == '0')
        identity = 'Student';
      else if (tempname.toString().substring(0, 1) == 'A')
        identity = 'Admin';
      else
        identity = 'Faculty';
    });
  }

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
      ),
      body: Center(
          child: Column(
        children: [
          identity == 'Student'
              ? StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection('Student')
                      .where('Username', isEqualTo: _service.getusername())
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData != null) {
                      return ListView.builder(
                          itemCount:
                              snapshot.hasData ? snapshot.data!.docs.length : 0,
                          reverse: false,
                          shrinkWrap: true,
                          primary: true,
                          physics: ScrollPhysics(),
                          itemBuilder: (context, i) {
                            QueryDocumentSnapshot x = snapshot.data!.docs[i];
                            return SingleChildScrollView(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.person),
                                  iconSize: 70,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [Text('Name\t'), Text(x['Name'])],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('User name\t'),
                                    Text(x['Username'])
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Branch\t'),
                                    Text(x['Branch'])
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Semester\t'),
                                    Text(x['Semester'])
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Address\t'),
                                    Text(x['Address'])
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Date of Birth\t'),
                                    Text(x['DateofBirth'])
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Mobile no\t'),
                                    Text(x['Mobileno'])
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Email id\t'),
                                    Text(x['Email'])
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Gender\t',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(),
                                    ),
                                    Text(x['Gender'])
                                  ],
                                )
                              ],
                            ));
                          });
                    } else {
                      return CircularProgressIndicator();
                    }
                  })
              : identity == 'Faculty'
                  ? StreamBuilder<QuerySnapshot>(
                      stream: _firestore
                          .collection('Faculty')
                          .where('Username', isEqualTo: _service.getusername())
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
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.person),
                                      iconSize: 70,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Name\t'),
                                        Text(x['Name'])
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('User name\t'),
                                        Text(x['Username'])
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Department\t'),
                                        Text(x['Department'])
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Semester\t'),
                                        Text(x['Semester'])
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Address\t'),
                                        Text(x['Address'])
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Date of Birth\t'),
                                        Text(x['DateofBirth'])
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Mobile no\t'),
                                        Text(x['Mobileno'])
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Email id\t'),
                                        Text(x['Email'])
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Gender\t',
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(),
                                        ),
                                        Text(x['Gender'])
                                      ],
                                    )
                                  ],
                                ));
                              });
                        } else {
                          return CircularProgressIndicator();
                        }
                      })
                  : StreamBuilder<QuerySnapshot>(
                      stream: _firestore
                          .collection('User')
                          .where('Username', isEqualTo: _service.getusername())
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
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.person),
                                      iconSize: 70,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Name\t'),
                                        Text(x['Name'])
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('User name\t'),
                                        Text(x['Username'])
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Email id\t'),
                                        Text(x['Email'])
                                      ],
                                    ),
                                  ],
                                ));
                              });
                        } else {
                          return CircularProgressIndicator();
                        }
                      }),
        ],
      )),
    );
  }
}
