import 'package:college_management_app/Admin/adminpanel.dart';
import 'package:college_management_app/Methods/methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _changepassword = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  Service _service = Service();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.brown,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              fit: StackFit.passthrough,
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: size.width / 1.2,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: TextField(
                          controller: _email,
                          decoration: InputDecoration(hintText: "Username"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: TextField(
                          controller: _password,
                          decoration: InputDecoration(hintText: "Passowrd"),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  // top: -30,
                  right: -20,
                  child: CircleAvatar(
                      radius: 30,
                      child: IconButton(
                          onPressed: () {
                            _service.loginAccount(
                                _email.text.trim(), _password.text, context);
                          },
                          icon: const Icon(
                            Icons.send,
                          ))),
                ),
              ],
            ),
            TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Column(
                            children: [
                              Text("Enter email"),
                              TextField(
                                controller: _changepassword,
                              ),
                              Row(
                                children: [
                                  FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Cancel")),
                                  FlatButton(
                                      onPressed: () async {
                                        await _auth.sendPasswordResetEmail(
                                            email: _changepassword.text.trim());

                                        Navigator.pop(context);
                                      },
                                      child: Text("Submit")),
                                ],
                              )
                            ],
                          ),
                        );
                      });
                },
                child: Text("Forget Password ?")),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
