import 'package:college_management_app/Common/Document.dart';
import 'package:flutter/material.dart';

class OpenMessage extends StatefulWidget {
  final String subject;
  final String name;
  final String message;
  final String date;
  final int size;
  final List Urlname;
  const OpenMessage(
      {Key? key,
      required this.subject,
      required this.name,
      required this.message,
      required this.date,
      required this.size,
      required this.Urlname})
      : super(key: key);

  @override
  State<OpenMessage> createState() => _OpenMessageState();
}

class _OpenMessageState extends State<OpenMessage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ecampus')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Sub : " + widget.subject,
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              color: Colors.brown,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Stack(
                  fit: StackFit.passthrough,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 35, right: 8),
                                child: Text(widget.date),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => ViewDocument(
                                                attachsize: widget.size,
                                                urlname: widget.Urlname)));
                                  },
                                  icon: widget.size == 0
                                      ? Container()
                                      : Icon(Icons.attachment))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 35.0, right: 8),
                            child: Text(
                              widget.message,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: -30,
                      left: 40,
                      child: Text(
                        widget.name,
                        // x['Sendby'],
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Positioned(
                      top: -30,
                      left: -20,
                      child: CircleAvatar(
                          radius: 25,
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.person))),
                    ),
                  ],
                ),
              ),
            ),
            //  SizedBox(height: 40,),
          ],
        ),
      ),
    );
  }
}
