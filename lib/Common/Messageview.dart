import 'package:flutter/material.dart';

class Messageview extends StatefulWidget {
  const Messageview({Key? key}) : super(key: key);

  @override
  State<Messageview> createState() => _MessageviewState();
}

class _MessageviewState extends State<Messageview> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        title: Text("Ecampus"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.person)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "sub: title of subject",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Stack(
                fit: StackFit.passthrough,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: size.height,
                    width: size.width / 1.2,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("             09/06/2022 3:40 pm"),
                            TextButton(
                                onPressed: () {}, child: Text('1 attachment'))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("             data of message")
                      ],
                    ),
                  ),
                  Positioned(
                    top: -30,
                    left: 40,
                    child: Text(
                      "Name of person",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Positioned(
                    top: -30,
                    left: -20,
                    child: CircleAvatar(
                        radius: 25,
                        child: IconButton(
                            onPressed: () {}, icon: const Icon(Icons.person))),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
