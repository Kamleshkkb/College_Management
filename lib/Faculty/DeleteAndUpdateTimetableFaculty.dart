import 'package:flutter/material.dart';

class DeleteAndUpdateTimetableFaculty extends StatefulWidget {
  final String change;
  const DeleteAndUpdateTimetableFaculty({Key? key, required this.change})
      : super(key: key);

  @override
  State<DeleteAndUpdateTimetableFaculty> createState() =>
      _DeleteAndUpdateTimetableFacultyState();
}

class _DeleteAndUpdateTimetableFacultyState
    extends State<DeleteAndUpdateTimetableFaculty> {
  TextEditingController _fn = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text(widget.change)),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _fn,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Faculty user name (TM0001)",
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          FlatButton(
              onPressed: () {}, child: Text("Search to ${widget.change}")),
        ],
      ),
    );
  }
}
