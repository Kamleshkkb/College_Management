import 'dart:io';

import 'package:college_management_app/Methods/methods.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class Newsinput extends StatefulWidget {
  const Newsinput({Key? key}) : super(key: key);

  @override
  State<Newsinput> createState() => _NewsinputState();
}

class _NewsinputState extends State<Newsinput> {
  Service _service = Service();
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _news = TextEditingController();
  bool director = true;
  bool cdgi = false;
  bool pharmacy = false;
  bool cdips = false;
  bool tp = false;
  bool achieve = false;
  String select = "Director";
  double myheight = 65;

  FilePickerResult? result;

  final image = ImagePicker();
  File file = File('');
  String name = '';
  String url = '';

  int attach = 0;
  List urlname = [];
  List nameoffile = [];

  getfile() async {
    result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'doc']);

    setState(() {
      name = result!.names.toString();
      attach = result!.count;
      print(result!.count);

      for (int i = 0; i < result!.count; i++) {
        nameoffile.add(result!.names[i]);
      }
    });
  }

  after() async {
    if (attach != 0) {
      attach = result!.count;
      for (int i = 0; i < result!.count; i++) {
        File c = File(result!.files[i].path.toString());
        name = nameoffile[i];
        file = c;
        await uploadFile(i);
      }
    }
  }

  uploadFile(int a) async {
    try {
      String nametemp = nameoffile[a];
      var imagefile = FirebaseStorage.instance
          .ref()
          .child("${_service.getusername()}/$nametemp");
      UploadTask task = imagefile.putFile(file);
      TaskSnapshot snapshot = await task;
      url = await snapshot.ref.getDownloadURL();
      urlname.add(url);
      print(url);
      if (url != null && file != null) {
        Fluttertoast.showToast(msg: "Uploaded done", textColor: Colors.red);
      } else {
        Fluttertoast.showToast(
            msg: "Something went wrong ", textColor: Colors.red);
      }
    } on Exception catch (e) {
      Fluttertoast.showToast(msg: e.toString(), textColor: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(title: Text("Ecampus")),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                      color: Color.fromRGBO(33, 150, 243, 1),
                      onPressed: () async {
                        if (_news.text.isNotEmpty) {
                          await after();
                          _service.sendnews(_service.getUserName(), select,
                              _news.text, attach, urlname);
                          Navigator.pop(context);
                        } else {
                          print("News controller is empty");
                        }
                      },
                      child: Row(
                        children: [Text("Post"), Icon(Icons.send)],
                      ))
                ],
              ),
              Text(
                "Choose Moderator",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(10),
                color: Colors.blueGrey,
                child: Column(
                  children: [
                    Container(
                      height: myheight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Director",
                          ),
                          Switch(
                              value: director,
                              onChanged: (value) {
                                setState(() {
                                  select = "Director";
                                  director = value;
                                  cdgi = false;
                                  pharmacy = false;
                                  cdips = false;
                                  tp = false;
                                  achieve = false;
                                });
                              })
                        ],
                      ),
                    ),
                    Container(
                      height: myheight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Principal CDGI",
                          ),
                          Switch(
                              value: cdgi,
                              onChanged: (value) {
                                setState(() {
                                  cdgi = value;
                                  director = false;
                                  select = "Principal CDGI";
                                  pharmacy = false;
                                  cdips = false;
                                  tp = false;
                                  achieve = false;
                                });
                              })
                        ],
                      ),
                    ),
                    Container(
                      height: myheight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Principal Pharmacy",
                          ),
                          Switch(
                              value: pharmacy,
                              onChanged: (value) {
                                setState(() {
                                  pharmacy = value;
                                  director = false;
                                  cdgi = false;
                                  select = "Principal Pharmacy";
                                  cdips = false;
                                  tp = false;
                                  achieve = false;
                                });
                              })
                        ],
                      ),
                    ),
                    Container(
                      height: myheight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Principal CDIPS",
                          ),
                          Switch(
                              value: cdips,
                              onChanged: (value) {
                                setState(() {
                                  cdips = value;
                                  director = false;
                                  cdgi = false;
                                  pharmacy = false;
                                  select = "Principal CDIPS";
                                  tp = false;
                                  achieve = false;
                                });
                              })
                        ],
                      ),
                    ),
                    Container(
                      height: myheight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Dean T&P",
                          ),
                          Switch(
                              value: tp,
                              onChanged: (value) {
                                setState(() {
                                  tp = value;
                                  director = false;
                                  cdgi = false;
                                  pharmacy = false;
                                  cdips = false;
                                  select = "Dean T&P";
                                  achieve = false;
                                });
                              })
                        ],
                      ),
                    ),
                    Container(
                      height: myheight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Achievements",
                          ),
                          Switch(
                              value: achieve,
                              onChanged: (value) {
                                setState(() {
                                  achieve = value;
                                  director = false;
                                  cdgi = false;
                                  pharmacy = false;
                                  cdips = false;
                                  tp = false;
                                  select = "Achievements";
                                });
                              })
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(name),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                child: TextField(
                  controller: _news,
                  // keyboardType: TextInputType.multiline,
                  maxLines: 115,
                  decoration: InputDecoration(hintText: "Enter News Feed"),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getfile();
        },
        child: Icon(Icons.attachment),
      ),
    );
  }
}
