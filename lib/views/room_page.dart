import 'package:flutter/material.dart';

class Room extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartHome',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
      //AppFuncBrowse(),
      RoomPage(),
    );
  }
}

class RoomPage extends StatefulWidget {
  @override
  _RoomPageState createState() {
    // TODO: implement createState
    return _RoomPageState();
  }
}


class _RoomPageState extends State<RoomPage>{
  Widget build(BuildContext context){
    return Scaffold(
        body: _title()
    );
  }

  _title() {
    return Padding(
        padding: EdgeInsets.fromLTRB(30, 20, 0, 0),
        child: Row(
          children: <Widget>[
            Text("房间",
            style: TextStyle(fontSize: 32.0, color: Colors.black87)),
            IconButton(icon: Icon(Icons.add, size: 40,), onPressed: null)
          ],
        )
    );
  }
}