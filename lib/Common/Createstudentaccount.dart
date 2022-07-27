import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_management_app/Methods/methods.dart';
import 'package:flutter/material.dart';

class studentAccountCreate extends StatefulWidget {
  final String identitfy;
  const studentAccountCreate({Key? key, required this.identitfy})
      : super(key: key);

  @override
  State<studentAccountCreate> createState() => _studentAccountCreateState();
}

class _studentAccountCreateState extends State<studentAccountCreate> {
  Service _service = Service();

  Widget field(
      Size size, String hintText, IconData icon, TextEditingController cont) {
    return Container(
      height: size.height / 14,
      width: size.width / 1.1,
      child: TextField(
        controller: cont,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  final TextEditingController _name = TextEditingController();
  final TextEditingController _department = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _dof = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  final TextEditingController _semester = TextEditingController();
  final TextEditingController _branch = TextEditingController();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final formGlobalkey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isexits = false;
  Service service = Service();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Create student Account "),
        ),
        body: ListView(
          padding: EdgeInsets.all(10),
          children: [
            Container(
              width: size.width / 1.1,
              child: Text(
                "Welcome",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: size.width / 1.1,
              child: Text(
                "Create Account to Contiue!",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: size.height / 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Container(
                width: size.width,
                alignment: Alignment.center,
                child: field(
                    size, "User name (enrollement no)", Icons.abc, _username),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Container(
                width: size.width,
                alignment: Alignment.center,
                child: field(
                    size, "${widget.identitfy} Full Name", Icons.person, _name),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Container(
                width: size.width,
                alignment: Alignment.center,
                child: field(size, " ${widget.identitfy} Email id ",
                    Icons.email, _email),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Container(
                width: size.width,
                alignment: Alignment.center,
                child: field(size, "${widget.identitfy} Mobile no.",
                    Icons.mobile_friendly, _mobile),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Container(
                width: size.width,
                alignment: Alignment.center,
                child: field(
                    size, "${widget.identitfy} Date of Birth", Icons.abc, _dof),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Container(
                width: size.width,
                alignment: Alignment.center,
                child: field(size, "Permanent Address", Icons.abc, _address),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Container(
                width: size.width,
                alignment: Alignment.center,
                child: field(size, "Gender", Icons.abc, _gender),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Container(
                width: size.width,
                alignment: Alignment.center,
                child: field(
                    size,
                    widget.identitfy == 'Student' ? "Branch" : "Department",
                    Icons.abc,
                    _branch),
              ),
            ),
            widget.identitfy == 'Student'
                ? Container(
                    width: size.width,
                    alignment: Alignment.center,
                    child: field(size, "Semester", Icons.numbers, _semester),
                  )
                : Container(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Container(
                width: size.width,
                alignment: Alignment.center,
                child: field(size, "password", Icons.lock, _password),
              ),
            ),
            SizedBox(
              height: size.height / 20,
            ),
            Container(
              width: size.width / 2,
              color: Colors.blueGrey,
              child: TextButton(
                  onPressed: (() {
                    if (widget.identitfy == 'Student') {
                      if (_semester.text.isNotEmpty &&
                          _address.text.isNotEmpty &&
                          _branch.text.isNotEmpty &&
                          _dof.text.isNotEmpty &&
                          _email.text.isNotEmpty &&
                          _gender.text.isNotEmpty &&
                          _mobile.text.isNotEmpty &&
                          _name.text.isNotEmpty &&
                          _password.text.isNotEmpty &&
                          _username.text.isNotEmpty) {
                        service.CreateStudent(
                            _name.text,
                            _email.text,
                            _password.text,
                            _username.text,
                            _dof.text,
                            _semester.text,
                            _mobile.text,
                            _address.text,
                            _gender.text,
                            _branch.text,
                            _branch.text,
                            widget.identitfy);
                        _address.clear();
                        _branch.clear();
                        _department.clear();
                        _dof.clear();
                        _email.clear();
                        _gender.clear();
                        _mobile.clear();
                        _name.clear();
                        _password.clear();
                        _semester.clear();
                        _username.clear();
                      } else {
                        print("fill all field nessary");
                      }
                    } else {
                      if (_address.text.isNotEmpty &&
                          _branch.text.isNotEmpty &&
                          _dof.text.isNotEmpty &&
                          _email.text.isNotEmpty &&
                          _gender.text.isNotEmpty &&
                          _mobile.text.isNotEmpty &&
                          _name.text.isNotEmpty &&
                          _password.text.isNotEmpty &&
                          _username.text.isNotEmpty) {
                        _service.CreateFaculty(
                            _name.text,
                            _email.text,
                            _password.text,
                            _username.text,
                            _dof.text,
                            _mobile.text,
                            _address.text,
                            _gender.text,
                            _branch.text,
                            widget.identitfy);
                        _address.clear();
                        _branch.clear();
                        _dof.clear();
                        _email.clear();
                        _gender.clear();
                        _mobile.clear();
                        _name.clear();
                        _password.clear();
                        _username.clear();
                      } else {
                        print("fill all field nessary");
                      }
                    }

                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Account created successfully"),
                          );
                        });
                  }),
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.black),
                  )),
            ),
          ],
        ));
  }
}
