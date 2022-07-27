import 'package:college_management_app/Methods/methods.dart';
import 'package:flutter/material.dart';

class CreateTimeTable extends StatefulWidget {
  const CreateTimeTable({Key? key}) : super(key: key);

  @override
  State<CreateTimeTable> createState() => _CreateTimeTableState();
}

class _CreateTimeTableState extends State<CreateTimeTable> {
  Service _service = Service();
  String dropdownvalue = 'CS';
  String dropdownvalue1 = '1';
  String dropdownvalue2 = 'am';
  String dropdownvalue3 = 'am';
  TextEditingController _st = TextEditingController();
  TextEditingController _et = TextEditingController();
  TextEditingController _sn = TextEditingController();
  TextEditingController _fn = TextEditingController();
  TextEditingController _rn = TextEditingController();
  TextEditingController _sc = TextEditingController();

  List branch = [
    'CS',
    'IT',
    'EC',
    'CE',
    'ME',
  ];
  List semester = [1, 2, 3, 4, 5, 6, 7, 8];
  int a = 0;
  int i = 0;
  int b = 0;
  int c = 0;
  int d = 0;
  int e = 0;

  show(String dayname) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Add timetable details"),
              scrollable: true,
              actions: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        controller: _st,
                        decoration: InputDecoration(
                            hintText: "Starting time ",
                            prefix: DropdownButton<String>(
                                value: dropdownvalue2,
                                items: <String>['am', 'pm']
                                    .map<DropdownMenuItem<String>>(
                                        (String value3) {
                                  return DropdownMenuItem(
                                      value: value3, child: Text("$value3"));
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownvalue2 = newValue!;
                                  });
                                })),
                      ),
                      TextField(
                        controller: _et,
                        decoration: InputDecoration(
                            hintText: "Ending time ",
                            prefix: DropdownButton<String>(
                                value: dropdownvalue3,
                                items: <String>['am', 'pm']
                                    .map<DropdownMenuItem<String>>(
                                        (String value4) {
                                  return DropdownMenuItem(
                                      value: value4, child: Text("$value4"));
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownvalue3 = newValue!;
                                  });
                                })),
                      ),
                      TextField(
                        controller: _sn,
                        decoration: InputDecoration(hintText: "Subject name"),
                      ),
                      TextField(
                        controller: _sc,
                        decoration: InputDecoration(hintText: "Subject code"),
                      ),
                      TextField(
                        controller: _rn,
                        decoration: InputDecoration(hintText: "Room no."),
                      ),
                      TextField(
                        controller: _fn,
                        decoration:
                            InputDecoration(hintText: "Name of faculty"),
                      ),
                      FlatButton(
                          color: Color.fromRGBO(33, 150, 243, 1),
                          onPressed: () {
                            setState(() {
                              List all = [];
                              _st.text = _st.text + " " + dropdownvalue2;
                              _et.text =
                                  (_et.text + " " + dropdownvalue3).toString();
                              all.add(_st.text);
                              all.add(_et.text);
                              all.add(_sn.text);
                              all.add(_sc.text);
                              all.add(_rn.text);
                              all.add(_fn.text);
                              if (dayname == "Monday") {
                                monday[i] = all;
                                i++;
                              } else if (dayname == "Tuesday") {
                                tuesday[a] = all;
                                a++;
                              } else if (dayname == "Wednesday") {
                                Wednesday[b] = all;
                                b++;
                              } else if (dayname == "Thursday") {
                                Thursday[c] = all;
                                c++;
                              } else if (dayname == "Firdays") {
                                firdays[d] = all;
                                d++;
                                print(firdays);
                              } else if (dayname == "Saturday") {
                                Saturday[e] = all;
                                e++;
                              }

                              _et.clear();
                              _st.clear();
                              _sn.clear();
                              _fn.clear();
                              _rn.clear();
                              _sc.clear();

                              print(monday);
                            });
                            Navigator.pop(context);
                          },
                          child: Text("Submit"))
                    ],
                  ),
                ),
              ]);
        });
  }

  add(String st, String et, String sn, String sc, String rn, String fn) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: monday.length >= 1 ? monday.length : 0,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              color: Colors.blueGrey,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Starting time"),
                      Text("$st"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Ending time"),
                      Text("$et"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Subject name"),
                      Text("$sn"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Subject code"),
                      Text("$sc"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Room no."),
                      Text("$rn"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Faculty name"),
                      Text("$fn"),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  Map monday = {};
  Map tuesday = {};
  Map Wednesday = {};
  Map Thursday = {};
  Map firdays = {};
  Map Saturday = {};
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Time Table"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Select branch"),
                DropdownButton<String>(
                    value: dropdownvalue,
                    items: <String>['CS', 'IT', 'EC', 'CE', 'ME']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem(
                          value: value, child: Text("$value"));
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    })
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Select Semster"),
                DropdownButton<String>(
                    value: dropdownvalue1,
                    items: <String>['1', '2', '3', '4', '5', '6', '7', '8']
                        .map<DropdownMenuItem<String>>((String value1) {
                      return DropdownMenuItem(
                          value: value1, child: Text("$value1"));
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue1 = newValue!;
                      });
                    })
              ],
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Text("Monday"),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: monday.length >= 1 ? monday.length : 0,
                      itemBuilder: (BuildContext context, int index) {
                        return add(
                            monday[index][0],
                            monday[index][1],
                            monday[index][2],
                            monday[index][3],
                            monday[index][4],
                            monday[index][5]);
                      }),
                  FlatButton(
                      color: Colors.blue,
                      onPressed: () {
                        show("Monday");
                      },
                      child: Text("Add More subject")),
                ],
              ),
            ),
            Column(
              children: [
                Text("Tuesday"),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: tuesday.length >= 1 ? tuesday.length : 0,
                    itemBuilder: (BuildContext context, int index) {
                      return add(
                          tuesday[index][0],
                          tuesday[index][1],
                          tuesday[index][2],
                          tuesday[index][3],
                          tuesday[index][4],
                          tuesday[index][5]);
                    }),
                FlatButton(
                    color: Colors.blue,
                    onPressed: () {
                      show("Tuesday");
                    },
                    child: Text("Add More subject")),
              ],
            ),
            Column(
              children: [
                Text("Wednesday"),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: Wednesday.length >= 1 ? Wednesday.length : 0,
                    itemBuilder: (BuildContext context, int index) {
                      return add(
                          Wednesday[index][0],
                          Wednesday[index][1],
                          Wednesday[index][2],
                          Wednesday[index][3],
                          Wednesday[index][4],
                          Wednesday[index][5]);
                    }),
                FlatButton(
                    color: Colors.blue,
                    onPressed: () {
                      show("Wednesday");
                    },
                    child: Text("Add More subject")),
              ],
            ),
            Column(
              children: [
                Text("Thursday"),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: Thursday.length >= 1 ? Thursday.length : 0,
                    itemBuilder: (BuildContext context, int index) {
                      return add(
                          Thursday[index][0],
                          Thursday[index][1],
                          Thursday[index][2],
                          Thursday[index][3],
                          Thursday[index][4],
                          Thursday[index][5]);
                    }),
                FlatButton(
                    color: Colors.blue,
                    onPressed: () {
                      show("Thursday");
                    },
                    child: Text("Add More subject")),
              ],
            ),
            Column(
              children: [
                Text("Friday"),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: firdays.length >= 1 ? firdays.length : 0,
                    itemBuilder: (BuildContext context, int index) {
                      return add(
                          firdays[index][0],
                          firdays[index][1],
                          firdays[index][2],
                          firdays[index][3],
                          firdays[index][4],
                          firdays[index][5]);
                    }),
                FlatButton(
                    color: Colors.blue,
                    onPressed: () {
                      show("Firdays");
                    },
                    child: Text("Add More subject")),
              ],
            ),
            Column(
              children: [
                Text("Saturday"),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: Saturday.length >= 1 ? Saturday.length : 0,
                    itemBuilder: (BuildContext context, int index) {
                      return add(
                          Saturday[index][0],
                          Saturday[index][1],
                          Saturday[index][2],
                          Saturday[index][3],
                          Saturday[index][4],
                          Saturday[index][5]);
                    }),
                FlatButton(
                    color: Colors.blue,
                    onPressed: () {
                      show("Saturday");
                    },
                    child: Text("Add More subject")),
                FlatButton(
                    color: Colors.blue,
                    onPressed: () {
                      _service.CreateTimeTable(monday, tuesday, Wednesday,
                          Thursday, firdays, dropdownvalue1, dropdownvalue);
                      Navigator.pop(context);
                    },
                    child: Text("Submit")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
