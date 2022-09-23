import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_management_app/Admin/adminpanel.dart';
import 'package:college_management_app/Common/Message.dart';
import 'package:college_management_app/Common/login.dart';
import 'package:college_management_app/Faculty/Facultypanel.dart';
import 'package:college_management_app/student/studentpanel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Service {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future loginAccount(
      String email, String password, BuildContext context) async {
    Map<String, dynamic> name = {};
    String newname;
    Service service = Service();
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      print("login success");

      await _firestore
          .collection('User')
          .where('Email', isEqualTo: email)
          .get()
          .then(
            (value) => name = value.docs.first.data(),
          );
      print(name);
      if (name['identity'] == 'Student') {
        newname = name['Username'] +
            " " +
            name['Branch'] +
            " " +
            name['Semester'] +
            " " +
            name['Name'];

        auth.currentUser!.updateDisplayName(newname);
      } else if (name['identity'] == 'Admin') {
        newname = name['Username'] + " " + name['Name'];
        print("${name['Username'] + " " + name['Name']}");
        auth.currentUser!.updateDisplayName(newname);
      } else if (name['identity'] == 'Faculty') {
        newname = name['Username'] + " " + name['Name'];
        print("${name['Username'] + " " + name['Name']}");
        auth.currentUser!.updateDisplayName(newname);
      }

      if (name['identity'] == 'Student')
        Navigator.push(context, MaterialPageRoute(builder: (_) => BottomBar()));
      if (name['identity'] == 'Admin')
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => AdminPanel()));
      if (name['identity'] == 'Faculty')
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => FacultyBottomBar()));
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("$e"),
            );
          });
      print(e);
    }
  }

  logout(BuildContext context) async {
    await auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => LoginScreen()));
  }

  String getUserName() {
    String newname = '';
    int nn = auth.currentUser!.displayName.toString().length;
    String nnn = auth.currentUser!.displayName.toString().substring(0, 1);
    if (nnn == '0')
      newname = auth.currentUser!.displayName.toString().substring(18, nn);
    else
      newname = auth.currentUser!.displayName.toString().substring(7, nn);
    return newname;
  }

  getusersem() {
    String newname = '';
    int nn = auth.currentUser!.displayName.toString().length;
    newname = auth.currentUser!.displayName.toString().substring(16, 17);

    return newname;
  }

  getuserbranch() {
    String newname = '';
    int nn = auth.currentUser!.displayName.toString().length;

    newname = auth.currentUser!.displayName.toString().substring(13, 15);

    return newname;
  }

  getusername() {
    String newname = '';
    int nn = auth.currentUser!.displayName.toString().length;
    String nnn = auth.currentUser!.displayName.toString().substring(0, 1);
    if (nnn == '0')
      newname = auth.currentUser!.displayName.toString().substring(0, 12);
    else
      newname = auth.currentUser!.displayName.toString().substring(0, 6);

    return newname;
  }

  sendnews(String name, String moderetor, String news, int attach,
      List urlname) async {
    try {
      if (moderetor == 'Dean T&P') {
        await _firestore
            .collection('Notice')
            .doc('T&P')
            .collection('News')
            .add({
          'Name': name,
          'Moderetor': moderetor,
          'News': news,
          'Attachment': attach,
          'Url': urlname,
          'time': DateTime.now().toString(),
        });
      } else {
        await _firestore
            .collection('Notice')
            .doc('Others')
            .collection('News')
            .add({
          'Name': name,
          'Moderetor': moderetor,
          'News': news,
          'Attachment': attach,
          'Url': urlname,
          'time': DateTime.now().toString(),
        });
      }

      await _firestore.collection('Notice').doc('All').collection('News').add({
        'Name': name,
        'Moderetor': moderetor,
        'News': news,
        'Attachment': attach,
        'Url': urlname,
        'time': DateTime.now().toString(),
      });

      print("News send successfully");
    } catch (e) {
      print(e);
    }
  }

  sendmessage(String sendto, String sendby, String subject, String message,
      List urlname, int attach) async {
    Map<String, dynamic> name = {};
    try {
      await _firestore
          .collection('User')
          .where('Username', isEqualTo: sendto)
          .get()
          .then(
            (value) => name = value.docs.first.data(),
          );
      await _firestore
          .collection('message')
          .doc(sendto)
          .collection('chats')
          .add({
        'Sendto': name['Name'],
        'Sendby': sendby,
        'Subject': subject,
        'Attachment': attach,
        'Url': urlname,
        'Message': message,
        'time': DateTime.now().toString(),
      });
      await _firestore
          .collection('message')
          .doc(getusername())
          .collection('chats')
          .add({
        'Sendto': sendby,
        'Sendby': name['Name'],
        'Subject': subject,
        'Message': message,
        'Attachment': attach,
        'Url': urlname,
        'time': DateTime.now().toString(),
      });
      await _firestore
          .collection('sent')
          .doc(getusername())
          .collection('chats')
          .add({
        'Sendto': name['Name'],
        'Sendby': sendby,
        'Subject': subject,
        'Message': message,
        'Attachment': attach,
        'Url': urlname,
        'time': DateTime.now().toString(),
      });
      print("message send successfully");
    } catch (e) {
      print(e);
    }
  }

  CreateStudent(
      String name,
      String email,
      String password,
      String username,
      String dof,
      String semester,
      String mobileno,
      String address,
      String gender,
      String branch,
      String department,
      String identity,
      BuildContext context
      
      ) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print("Student acccount created successfully");
      await _firestore.collection('Student').add({
        'Name': name,
        'Email': email,
        'Username': username,
        'DateofBirth': dof,
        'Semester': semester,
        'Branch': branch,
        'Department': department,
        'Mobileno': mobileno,
        'Address': address,
        'Gender': gender
      });

      await _firestore
          .collection('Studentdepartment')
          .doc(branch)
          .collection(semester)
          .add({
        'Name': name,
        'Email': email,
        'Username': username,
        'DateofBirth': dof,
        'Semester': semester,
        'Branch': branch,
        'Department': department,
        'Mobileno': mobileno,
        'Address': address,
        'Gender': gender
      });
      await _firestore.collection('User').add({
        'identity': identity,
        'Name': name,
        'Email': email,
        'Username': username,
        'DateofBirth': dof,
        'Semester': semester,
        'Branch': branch,
        'Department': department,
        'Mobileno': mobileno,
        'Address': address,
        'Gender': gender
      });
      print("Student information added successfully");
      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Account created successfully"),
                          );
                        });
    } catch (e) {
      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Error $e"),
                          );
                        });
      print("Error occured inside create student account $e");
    }
  }

  amtopm(String a, String d) {
    int b = int.parse(a);
    int min = int.parse(d);
    if (b > 12) {
      int c = b - 12;
      if (c < 10 && min < 10)
        return '0$c:0$min pm';
      else
        return '$c:$min pm';
    } else {
      return '$b:$min am';
    }
  }

  CreateTimeTable(Map monday, Map tuesday, Map wednesday, Map thursday,
      Map firday, String sem, String branch) async {
    for (int i = 0; i < monday.length; i++) {
      await _firestore
          .collection('TimeTable')
          .doc(branch)
          .collection('Time table details')
          .doc(sem)
          .collection('monday')
          .add({
        'st': monday[i][0],
        'et': monday[i][1],
        'sn': monday[i][2],
        'sc': monday[i][3],
        'rn': monday[i][4],
        'fn': monday[i][5],
      });
    }
    for (int i = 0; i < tuesday.length; i++) {
      await _firestore
          .collection('TimeTable')
          .doc(branch)
          .collection('Time table details')
          .doc(sem)
          .collection('tuesday')
          .add({
        'st': tuesday[i][0],
        'et': tuesday[i][1],
        'sn': tuesday[i][2],
        'sc': tuesday[i][3],
        'rn': tuesday[i][4],
        'fn': tuesday[i][5],
      });
    }
    for (int i = 0; i < wednesday.length; i++) {
      await _firestore
          .collection('TimeTable')
          .doc(branch)
          .collection('Time table details')
          .doc(sem)
          .collection('wednesday')
          .add({
        'st': wednesday[i][0],
        'et': wednesday[i][1],
        'sn': wednesday[i][2],
        'sc': wednesday[i][3],
        'rn': wednesday[i][4],
        'fn': wednesday[i][5],
      });
    }
    for (int i = 0; i < thursday.length; i++) {
      await _firestore
          .collection('TimeTable')
          .doc(branch)
          .collection('Time table details')
          .doc(sem)
          .collection('thursday')
          .add({
        'st': thursday[i][0],
        'et': thursday[i][1],
        'sn': thursday[i][2],
        'sc': thursday[i][3],
        'rn': thursday[i][4],
        'fn': thursday[i][5],
      });
    }
    for (int i = 0; i < firday.length; i++) {
      await _firestore
          .collection('TimeTable')
          .doc(branch)
          .collection('Time table details')
          .doc(sem)
          .collection('firday')
          .add({
        'st': firday[i][0],
        'et': firday[i][1],
        'sn': firday[i][2],
        'sc': firday[i][3],
        'rn': firday[i][4],
        'fn': firday[i][5],
      });
    }
  }

  CreateFaculty(
      String name,
      String email,
      String password,
      String username,
      String dof,
      String mobileno,
      String address,
      String gender,
      String department,
      String identity,
      BuildContext context
      ) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print("Student acccount created successfully");
      await _firestore.collection('Faculty').add({
        'Name': name,
        'Email': email,
        'Username': username,
        'DateofBirth': dof,
        'Department': department,
        'Mobileno': mobileno,
        'Address': address,
        'Gender': gender
      });

      await _firestore
          .collection('Facultydepartment')
          .doc(department)
          .collection('Information')
          .add({
        'Name': name,
        'Email': email,
        'Username': username,
        'DateofBirth': dof,
        'Department': department,
        'Mobileno': mobileno,
        'Address': address,
        'Gender': gender
      });
      await _firestore.collection('User').add({
        'identity': identity,
        'Name': name,
        'Email': email,
        'Username': username,
        'DateofBirth': dof,
        'Department': department,
        'Mobileno': mobileno,
        'Address': address,
        'Gender': gender
      });
      print("Student information added successfully");

      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Account created successfully"),
                          );
                        });
    } catch (e) {

      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Error $e"),
                          );
                        });
      print("Error occured inside create student account $e");
    }
  }

  CreateFacultyTimeTable(Map monday, Map tuesday, Map wednesday, Map thursday,
      Map firday, String username) async {
    for (int i = 0; i < monday.length; i++) {
      await _firestore
          .collection('Faculty Time Table')
          .doc(username)
          .collection('monday')
          .add({
        'st': monday[i][0],
        'et': monday[i][1],
        'sn': monday[i][2],
        'sc': monday[i][3],
        'rn': monday[i][4],
        'br': monday[i][5],
        'sem': monday[i][6],
      });
    }
    for (int i = 0; i < tuesday.length; i++) {
      await _firestore
          .collection('Faculty Time Table')
          .doc(username)
          .collection('tuesday')
          .add({
        'st': tuesday[i][0],
        'et': tuesday[i][1],
        'sn': tuesday[i][2],
        'sc': tuesday[i][3],
        'rn': tuesday[i][4],
        'br': tuesday[i][5],
        'sem': tuesday[i][6],
      });
    }
    for (int i = 0; i < wednesday.length; i++) {
      await _firestore
          .collection('Faculty Time Table')
          .doc(username)
          .collection('wednesday')
          .add({
        'st': wednesday[i][0],
        'et': wednesday[i][1],
        'sn': wednesday[i][2],
        'sc': wednesday[i][3],
        'rn': wednesday[i][4],
        'br': wednesday[i][5],
        'sem': wednesday[i][6],
      });
    }
    for (int i = 0; i < thursday.length; i++) {
      await _firestore
          .collection('Faculty Time Table')
          .doc(username)
          .collection('thursday')
          .add({
        'st': thursday[i][0],
        'et': thursday[i][1],
        'sn': thursday[i][2],
        'sc': thursday[i][3],
        'rn': thursday[i][4],
        'br': thursday[i][5],
        'sem': thursday[i][6],
      });
    }
    for (int i = 0; i < firday.length; i++) {
      await _firestore
          .collection('Faculty Time Table')
          .doc(username)
          .collection('firdays')
          .add({
        'st': firday[i][0],
        'et': firday[i][1],
        'sn': firday[i][2],
        'sc': firday[i][3],
        'rn': firday[i][4],
        'br': firday[i][5],
        'sem': firday[i][6],
      });
    }
  }

  attentance(Map students, String sn, String sc,BuildContext context) async {

    try {
       String date = DateTime.now().day.toString() +
        "-" +
        DateTime.now().month.toString() +
        "-" +
        DateTime.now().year.toString();

    for (int i = 0; i < students.length; i++) {
      await _firestore
          .collection('Attentance')
          .doc(date)
          .collection('Status')
          .add({
        'Rollno': students.keys.elementAt(i),
        'Status': students.values.elementAt(i)==true?"Present":"Absent",
        'Sn': sn,
        'Sc': sc,
      });
    }

    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Attendance done successfully "),
                          );
                        });
          print("Attendance done successfully");
    } catch (e) {
       showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("$e"),
                          );
                        });
                         print("Attendance done error");

                        
    }
   
  }
}
