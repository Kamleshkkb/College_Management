import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_management_app/Methods/methods.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class Messageinput extends StatefulWidget {
  const Messageinput({Key? key}) : super(key: key);

  @override
  State<Messageinput> createState() => _MessageinputState();
}

class _MessageinputState extends State<Messageinput> {
  TextEditingController _name = TextEditingController();
  TextEditingController _subject = TextEditingController();

  Service _service = Service();
  TextEditingController _message = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

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

  bool check = false;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(title: const Text("Ecampus")),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                      color: Colors.blue,
                      onPressed: () async {
                        await CheckUser(_name.text);
                        if (check == true) {
                          if (_message.text.isNotEmpty &&
                              _name.text.isNotEmpty &&
                              _subject.text.isNotEmpty) {
                            var name = _auth.currentUser!.displayName;
                            await after();
                            _service.sendmessage(
                                _name.text,
                                _service.getUserName(),
                                _subject.text,
                                _message.text,
                                urlname,
                                attach);

                            Navigator.pop(context);
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("fill all field"),
                                  );
                                });
                          }
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("User name invalid"),
                                );
                              });
                        }
                      },
                      child: Row(
                        children: [const Text("Send"), const Icon(Icons.send)],
                      ))
                ],
              ),
              Container(
                color: Colors.white,
                child: TextField(
                  controller: _name,
                  decoration: const InputDecoration(
                    hintText: "Type Name Here ",
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                child: TextField(
                  controller: _subject,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(hintText: "Subject "),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                child: TextField(
                  controller: _message,
                  // keyboardType: TextInputType.multiline,
                  maxLines: 115,
                  minLines: 5,
                  decoration:
                      const InputDecoration(hintText: "Kamlesh Kumar Bhardwaj"),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(name),
              )
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
