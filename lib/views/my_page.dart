import 'package:flutter/material.dart';

class My extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartHome',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
      //AppFuncBrowse(),
      MyPage(),
    );
  }
}

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() {
    // TODO: implement createState
    return _MyPageState();
  }
}


class _MyPageState extends State<MyPage>{
  Widget build(BuildContext context){
    return Scaffold(
      appBar: new AppBar(title: new Text('我的')),
      body: new Center(child: new Text('这里我的')));
  }
}