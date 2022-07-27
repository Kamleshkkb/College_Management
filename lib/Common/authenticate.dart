// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:college_management_app/Admin/adminpanel.dart';
import 'package:college_management_app/Faculty/Facultypanel.dart';
import 'package:college_management_app/student/studentpanel.dart';
import 'package:college_management_app/Common/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    //print(_auth.currentUser!.displayName);
    if (_auth.currentUser != null &&
        _auth.currentUser!.displayName!.isNotEmpty) {
      if (_auth.currentUser!.displayName.toString().substring(0, 1) == '0')
        return BottomBar();
      else if (_auth.currentUser!.displayName.toString().substring(0, 1) == 'A')
        return AdminPanel();
      else
        return FacultyBottomBar();
    } else {
      return LoginScreen();
    }
  }
}
