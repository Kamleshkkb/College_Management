import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

class ViewDocument extends StatefulWidget {
  final int attachsize;
  final List urlname;
  const ViewDocument(
      {Key? key, required this.attachsize, required this.urlname})
      : super(key: key);

  @override
  State<ViewDocument> createState() => _ViewDocumentState();
}

class _ViewDocumentState extends State<ViewDocument> {
  int progress = 0;

  ReceivePort _receivePort = ReceivePort();

  static downloadingCallback(id, status, progress) {
    SendPort? sendPort = IsolateNameServer.lookupPortByName("downloading");

    sendPort?.send([id, status, progress]);
  }

  @override
  void initState() {
    super.initState();
    myfun();

    IsolateNameServer.registerPortWithName(
        _receivePort.sendPort, "downloading");

    _receivePort.listen((message) {
      setState(() {
        progress = message[2];
      });
    });

    FlutterDownloader.registerCallback(downloadingCallback);
  }

  var name;
  List exten = [];

  Widget myicon(int a) {
    if (exten[a] == '.pdf')
      return Icon(Icons.picture_as_pdf_outlined);
    else if (exten[a] == '.jpg')
      return Icon(Icons.image);
    else if (exten[a] == '.mp3')
      return Icon(Icons.music_note_outlined);
    else if (exten[a] == '.doc')
      return Icon(Icons.file_open);
    else if (exten[a] == '.mp4')
      return Icon(Icons.video_camera_front);
    else if (exten[a] == '.jpeg')
      return Icon(Icons.image);
    else if (exten[a] == '.xlsx')
      return Icon(Icons.file_open);
    else
      return Icon(Icons.image_not_supported_outlined);
  }

  myfun() {
    for (var index = 0; index < widget.urlname.length; index++) {
      if (widget.urlname[index].toString().contains('.pdf')) {
        exten.add('.pdf');
      } else if (widget.urlname[index].toString().contains('.jpg')) {
        exten.add('.jpg');
      } else if (widget.urlname[index].toString().contains('.jpeg')) {
        exten.add('.jpeg');
        exten[index] = '.jpg';
      } else if (widget.urlname[index].toString().contains('.mp4')) {
        exten.add('.mp4');
      } else if (widget.urlname[index].toString().contains('.mp3')) {
        exten.add('.mp3');
      } else if (widget.urlname[index].toString().contains('.doc')) {
        exten.add('.doc');
      } else if (widget.urlname[index].toString().contains('.xlsx')) {
        exten.add('.xlsx');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Ecampus"),
        ),
        body: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: widget.urlname.length,
            itemBuilder: (context, index) {
              return IconButton(
                  iconSize: 100,
                  onPressed: () async {
                    print('Index === $index');
                    setState(() {
                      var start = '2F';
                      var end = '.';
                      var startindex =
                          widget.urlname[index].toString().indexOf(start);
                      var endindex = widget.urlname[index]
                          .toString()
                          .indexOf(end, startindex + start.length);

                      name = widget.urlname[index]
                          .toString()
                          .substring(startindex + start.length, endindex);
                      print(name);
                    });

                    if (true) {
                      final externalDir = await getExternalStorageDirectory();
                      print("${externalDir!.path}");
                      final id = await FlutterDownloader.enqueue(
                        url: widget.urlname[index],
                        savedDir: externalDir.path,
                        fileName: name + exten[index],
                        showNotification: true,
                        openFileFromNotification: true,
                      );
                      print("is granded");
                    } else {
                      print("Permission deined");
                    }
                  },
                  icon: myicon(index));
            }));
  }
}
