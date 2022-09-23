import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_management_app/Common/home.dart';
import 'package:college_management_app/Faculty/Facultytimetable.dart';
import 'package:college_management_app/Methods/methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// class facultyTimetable extends StatefulWidget {
//   const facultyTimetable({ Key? key }) : super(key: key);

//   @override
//   State<facultyTimetable> createState() => _facultyTimetableState();
// }

// class _facultyTimetableState extends State<facultyTimetable> {

//   Widget timetable(){
//     return   Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(
//                               height: 100,
//                               width: 100,
//                               color: Colors.blueGrey,
//                               child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Text("Staring time"),
//                                   Text("to"),
//                                   Text("Ending time ")
//                                 ],
//                               ),
//                             ),
//                             Container(
//                                 padding: EdgeInsets.all(5.0),
//                                 height: 100,
//                                 width: 258,
//                                 color: Colors.blueGrey,
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Container(
//                                           child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceEvenly,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text("Subject name "),
//                                               SizedBox(
//                                                 height: 5,
//                                               ),
//                                               Text("subject code"),
//                                               SizedBox(
//                                                 height: 5,
//                                               ),
//                                               Text("Room no."),
//                                               SizedBox(
//                                                 height: 5,
//                                               ),
//                                               Text("branch -> semester->all")
//                                             ],
//                                           ),
//                                         ),

//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                                 ),
//                           ],
//                         ),
//                       ],
//                     );
//   }
//   int day=DateTime.now().weekday;
//   int daydate=DateTime.now().day;
//   int daymonth=DateTime.now().month;
//    List selected=[];
//   @override
//   Widget build(BuildContext context) {
//      final size = MediaQuery.of(context).size;
//     return Scaffold(
//         backgroundColor: Colors.brown,
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Expanded(
//                 flex: 1,
//                 child: ListView(
//                   scrollDirection: Axis.horizontal,
//                   children: [
//                     FlatButton(
//                         color: day==1?Colors.cyan:Colors.blue,
//                         onPressed: () {
//                           setState(() {

//                             if(day>1){
//                               int temp=day-1;
//                               daydate=daydate-temp;
//                             }else{
//                               int temp=1-day;
//                               daydate=daydate+temp;
//                             }day=1;
//                           });
//                         },
//                         child: Text("Monday")),
//                          SizedBox(width: 6,),
//                     FlatButton(
//                          color: day==2?Colors.cyan:Colors.blue,
//                         onPressed: () {
//                           setState(() {

//                              if(day>2){
//                               int temp=day-2;
//                               daydate=daydate-temp;
//                             }else{
//                               int temp=2-day;
//                               daydate=daydate+temp;
//                             }day=2;
//                           });
//                         },
//                         child: Text("Tuesday")),
//                          SizedBox(width: 6,),
//                     FlatButton(
//                         color: day==3?Colors.cyan:Colors.blue,
//                         onPressed: () {
//                            setState(() {

//                              if(day>3){
//                               int temp=day-3;
//                               daydate=daydate-temp;
//                             }else{
//                               int temp=3-day;
//                               daydate=daydate+temp;
//                             }
//                              day=3;
//                           });
//                         },
//                         child: Text("Wednesday")),
//                          SizedBox(width: 6,),
//                     FlatButton(
//                         color: day==4?Colors.cyan:Colors.blue,
//                         onPressed: () {
//                            setState(() {

//                             if(day>4){
//                               int temp=day-4;
//                               daydate=daydate-temp;
//                             }else{
//                               int temp=4-day;
//                               daydate=daydate+temp;
//                             }
//                              day=4;
//                           });
//                         },
//                         child: Text("Thursday")),
//                          SizedBox(width: 6,),
//                     FlatButton(
//                         color: day==5?Colors.cyan:Colors.blue,
//                         onPressed: () {
//                            setState(() {

//                             if(day>5){
//                               int temp=day-5;
//                               daydate=daydate-temp;
//                             }else{
//                               int temp=5-day;
//                               daydate=daydate+temp;
//                             }
//                              day=5;
//                           });
//                         },
//                         child: Text("Friday")),
//                          SizedBox(width: 6,),
//                     FlatButton(
//                        color: day==6?Colors.cyan:Colors.blue,
//                         onPressed: () {
//                            setState(() {

//                             if(day>6){
//                               int temp=day-6;
//                               daydate=daydate-temp;
//                             }else{
//                               int temp=6-day;
//                               daydate=daydate+temp;
//                             }
//                             day=6;
//                           });
//                         },
//                         child: Text("Saturday")),
//                          SizedBox(width: 6,),
//                   ],
//                 ),
//               ),

//                Expanded(
//                  flex: 1,
//                  child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text("5 June to 11 June "),
//                           Text("$daydate ${DateTime.now().month}")
//                         ],
//                       ),
//                ),
//               Expanded(
//                 flex: 8,
//                 child: ListView(
//                   children: [
//                     day==1? Container(
//                        child: Column(
//                          children: [
//                            Text("Monday"),
//                             timetable(),
//                      SizedBox(height: 6,),
//                      timetable(),
//                       SizedBox(height: 6,),
//                      timetable(),
//                       SizedBox(height: 6,),
//                      timetable(),
//                       SizedBox(height: 6,),
//                      timetable(),
//                       SizedBox(height: 6,),
//                      timetable(),
//                       SizedBox(height: 6,),
//                      timetable(),
//                       SizedBox(height: 6,),

//                          ],
//                        ),
//                      ):Container(),
//                       day==2? Container(
//                        child: Column(
//                          children: [
//                            Text("Tuesday"),
//                             timetable(),
//                      SizedBox(height: 6,),
//                      timetable(),
//                       SizedBox(height: 6,),
//                      timetable(),
//                       SizedBox(height: 6,),
//                      timetable(),
//                       SizedBox(height: 6,),
//                      timetable(),
//                       SizedBox(height: 6,),
//                      timetable(),
//                       SizedBox(height: 6,),
//                      timetable(),
//                       SizedBox(height: 6,),

//                          ],
//                        ),
//                      ):Container(), day==3? Container(
//                        child: Column(
//                          children: [
//                            Text("wednesday"),
//                             timetable(),
//                      SizedBox(height: 6,),
//                      timetable(),
//                       SizedBox(height: 6,),
//                      timetable(),
//                       SizedBox(height: 6,),
//                      timetable(),
//                       SizedBox(height: 6,),
//                      timetable(),
//                       SizedBox(height: 6,),
//                      timetable(),
//                       SizedBox(height: 6,),
//                      timetable(),
//                       SizedBox(height: 6,),

//                          ],
//                        ),
//                      ):Container(), day==4? Container(
//                        child: Column(
//                          children: [
//                            Text("Thursday"),
//                             timetable(),
//                      SizedBox(height: 6,),
//                      timetable(),
//                       SizedBox(height: 6,),
//                      timetable(),
//                       SizedBox(height: 6,),
//                      timetable(),
//                       SizedBox(height: 6,),
//                      timetable(),
//                       SizedBox(height: 6,),
//                      timetable(),
//                       SizedBox(height: 6,),
//                      timetable(),
//                       SizedBox(height: 6,),

//                          ],
//                        ),
//                      ):Container(), day==5? Container(
//                        child: Column(
//                          children: [
//                            Text("Friday"),
//                             GestureDetector(
//                               onTap: (){
//                                  for(int i=0;i<200;i++){
//                    selected.add("false");
//                       }
//                                 //Navigator.push(context, MaterialPageRoute(builder: (_)=>NameofStudent(branch: "CS", semester: '1', subname: "any ")));
//                               },
//                               child: timetable()),
//                      SizedBox(height: 6,),
//                      timetable(),
//                       SizedBox(height: 6,),
//                      timetable(),
//                       SizedBox(height: 6,),
//                      timetable(),
//                       SizedBox(height: 6,),
//                      timetable(),
//                       SizedBox(height: 6,),
//                      timetable(),
//                       SizedBox(height: 6,),
//                      timetable(),
//                       SizedBox(height: 6,),

//                          ],
//                        ),
//                      ):Container(), day==6? Container(
//                        child: Column(
//                          children: [
//                            Text("saturday"),
//                             timetable(),
//                      SizedBox(height: 6,),
//                      timetable(),
//                       SizedBox(height: 6,),
//                      timetable(),
//                       SizedBox(height: 6,),
//                      timetable(),
//                       SizedBox(height: 6,),
//                      timetable(),
//                       SizedBox(height: 6,),
//                      timetable(),
//                       SizedBox(height: 6,),
//                      timetable(),
//                       SizedBox(height: 6,),

//                          ],
//                        ),
//                      ):Container(), DateTime.now().weekday==6? Container(
//                        child: Column(
//                          children: [
//                            Text("Monday"),
//                             timetable(),
//                      SizedBox(height: 6,),
//                      timetable(),
//                       SizedBox(height: 6,),
//                      timetable(),
//                       SizedBox(height: 6,),
//                      timetable(),
//                       SizedBox(height: 6,),
//                      timetable(),
//                       SizedBox(height: 6,),
//                      timetable(),
//                       SizedBox(height: 6,),
//                      timetable(),
//                       SizedBox(height: 6,),

//                          ],
//                        ),
//                      ):Container(),

//                     ],
//                   ),
//               ),

//             ],
//         ),
//         ),

//         );
//   }
// }

class NameofStudent extends StatefulWidget {
  final String subname;
  final String branch;
  final String semester;
  final String subjectcode;
  const NameofStudent(
      {Key? key,
      required this.branch,
      required this.semester,
      required this.subname,
      required this.subjectcode})
      : super(key: key);

  @override
  State<NameofStudent> createState() => _NameofStudentState();
}

class _NameofStudentState extends State<NameofStudent> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List studentname = [];
  List selected = [];
  List rollno = [];
  List studentstatus = [];
  List color = [];
  Map<String,bool> students=<String,bool>{};
  Map<String,String> studentsn=<String,String>{};
  @override
  void initState() {
    // TODO: implement initState
    for (int i = 0; i < 200; i++) {
      selected.add("false");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("${widget.branch} ${widget.semester}")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Name of Student  "),
                  Text("Enrollemnet No.  "),
                  Text("Status"),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection('Studentdepartment')
                      .doc(widget.branch)
                      .collection(widget.semester)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData != null) {
                      return ListView.builder(
                          
                          itemCount:
                              snapshot.hasData ? snapshot.data!.docs.length : 0,
                          reverse: false,
                          shrinkWrap: true,
                          primary: true,
                          physics: ScrollPhysics(),
                          itemBuilder: (context, i) {
                            QueryDocumentSnapshot x = snapshot.data!.docs[i];
                            return SingleChildScrollView(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(x['Name']),
                                   Text(
                                    x['Username']
                                    
                                  
                                   ),
                                 SizedBox(height: 20,),
                                  Row(
                                  
                                    children: [
                                         Container(
                                    height: 30,
                                    width: 30,
                                    color: students[x['Username']]==true?Colors.green:Colors.blue,
                                    child: FlatButton(
                                      onPressed: (){
                                        setState(() {
                                          students[x['Username']]=true;
                                        });
                                        
                                      },
                                      child: Center(child: Text("P"))),
                                  ),
                                  SizedBox(width: 10,),
                                   Container(
                                    height: 30,
                                    width: 30,
                                    color: students[x['Username']]==false?Colors.red:Colors.blue,
                                    child: FlatButton(
                                      onPressed: (){

                                        setState(() {
                                          students[x['Username']]=false;
                                        });
                                        
                                      },
                                      child: Center(child: Text("A"))),
                                  ),
                                   
                                    ],
                                  ),
                                 
                               
                               
                                ],
                              ),
                              
                            );
                          });
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
              FlatButton(
                  onPressed: () {
                    print(students);
                   
                    Navigator.push(
                        context,
                        
                        MaterialPageRoute(
                            builder: (_) => ShowName(

                                  studentn: studentname,
                                  students: students,
                                  rollno: rollno,
                                  subjectcode: widget.subjectcode,
                                  subjectname: widget.subname,
                                )));
                  },
                  child: Text("Submit"))
            ],
          ),
        ));
  }
}

class ShowName extends StatefulWidget {
  final Map students;
  final List rollno;
  final List studentn;
  final String subjectname;
  final String subjectcode;
  const ShowName(
      {Key? key,
    
      required this.studentn,
      required this.rollno,
      required this.subjectname,
      required this.subjectcode, required this.students})
      : super(key: key);

  @override
  State<ShowName> createState() => _ShowNameState();
}

class _ShowNameState extends State<ShowName> {
  Service _service = Service();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Name and status of student")),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: widget.students.length,
                  itemBuilder: ((context, index) {
                    return Container(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                            //  Text("${widget.studentn[index]}"),
                              Text("${widget.students.keys.elementAt(index)}"),
                              CircleAvatar(
                                backgroundColor:
                                    widget.students.values.elementAt(index) == true
                                        ? Colors.green
                                        : Colors.red,
                                child: Text(widget.students.values.elementAt(index) == true
                                    ? "P"
                                    : "A"),
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  })),
            ),
            FlatButton(
                onPressed: ()async {
                  List statuss=[];
                 
                await  _service.attentance(widget.students, widget.subjectname, widget.subjectcode,context);
                      

                       Navigator.push(context, MaterialPageRoute(builder: (_)=>Home()));
                       Navigator.pop(context);
                       
                },
                child: Text("Final submission"))
          ],
        ));
  }
}
