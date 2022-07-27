import 'package:college_management_app/Common/bothdeleteandupdate.dart';
import 'package:college_management_app/Faculty/CreateFacultyTimeTable.dart';
import 'package:college_management_app/student/CreateTimeTable.dart';
import 'package:college_management_app/Common/Createstudentaccount.dart';
import 'package:college_management_app/student/updateanddeletetimetable.dart';
import 'package:flutter/material.dart';

class Edit extends StatefulWidget {
  const Edit({Key? key}) : super(key: key);

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
               FlatButton(
                  color: Colors.blue,
                  onPressed: () {
                    
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => ShowDetails()));
                  },
                  child: Text("Show Details of User")),
              FlatButton(
                  color: Colors.blue,
                  onPressed: () {

                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => ChangeFaculty()));
                  },
                  child: Text("Faculty")),
              FlatButton(
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => ChangeStudent()));
                  },
                  child: Text("Student"))
            ],
          ),
        ),
      ),
    );
  }
}

class ChangeStudent extends StatefulWidget {
  const ChangeStudent({Key? key}) : super(key: key);

  @override
  State<ChangeStudent> createState() => _ChangeStudentState();
}

class _ChangeStudentState extends State<ChangeStudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Student")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => studentAccountCreate(
                                identitfy: "Student",
                              )));
                },
                child: Text("student account Create")),
            FlatButton(
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => CreateTimeTable()));
                },
                child: Text("student Time table Create")),
           
          ],
        ),
      ),
    );
  }
}

class ChangeFaculty extends StatefulWidget {
  const ChangeFaculty({Key? key}) : super(key: key);

  @override
  State<ChangeFaculty> createState() => _ChangeFacultyState();
}

class _ChangeFacultyState extends State<ChangeFaculty> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Faculty")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => studentAccountCreate(
                                identitfy: "Faculty",
                              )));
                },
                child: Text("Faculty account Create")),
            FlatButton(
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => CreateTimeTableFaculty()));
                },
                child: Text("Faculty Time table Create")),
          ],
        ),
      ),
    );
  }
}
