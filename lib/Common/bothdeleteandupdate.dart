import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowDetails extends StatefulWidget {
  const ShowDetails({Key? key}) : super(key: key);

  @override
  State<ShowDetails> createState() => _ShowDetailsState();
}

class _ShowDetailsState extends State<ShowDetails> {
  TextEditingController _username=TextEditingController();
  FirebaseFirestore _firestore=FirebaseFirestore.instance;
  bool check = false;
  bool checkstudent=false;
    CheckUser(String name) async {
    await _firestore
        .collection('User')
        .where('Username', isEqualTo: name)
        .get()
        .then((value) {
      setState(() {
        check = true;
      });

    });

     
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("College Managment"),),
      body: SingleChildScrollView(child: Column(
        children: [
          TextField(
            controller: _username,
            decoration: InputDecoration(hintText: "User name"),
          ),
          FlatButton(onPressed: () async{

            print(_username.text.toString().substring(0,1));
            if(_username.text.toString().substring(0,1)=='0'){
              print("hellolllllllll");
              setState(() {
                 checkstudent=true;
              });
            }
           

           
            
             await CheckUser(_username.text);
              if(check==false)
            {
              showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Invalid User name"),
            );
          });}
              setState(() {
                check=false;
              });
          }, child: Text("Search")),

          StreamBuilder<QuerySnapshot>(
                      stream: _firestore
                          .collection('User')
                          .where('Username', isEqualTo: _username.text)
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
                                     Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Address \t'),
                                        Text(x['Address'])
                                      ],
                                    ),
                                     Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Gender \t'),
                                        Text(x['Gender'])
                                      ],
                                    ),
                                     Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Department \t'),
                                        Text(x['Branch'])
                                      ],
                                    ),
                                     Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Mobile no.\t'),
                                        Text(x['Mobileno'])
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Date of Birth \t'),
                                        Text(x['DateofBirth'])
                                      ],
                                    ),
                                   checkstudent==true? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Semester  \t'),
                                        Text(x['Semester'])
                                      ],
                                    ):Container()
                                  ],
                                ));
                              });
                        } else {
                          return CircularProgressIndicator();
                        }
                      }),
        ],
      ),)
    );
    
  }
}