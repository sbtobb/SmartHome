import 'package:flutter/material.dart';
import 'home_page.dart';
import 'room_page.dart';
import 'my_page.dart';
class LoginSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartHome',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
      //AppFuncBrowse(),
      LoginSuccessPage(),
    );
  }
}

class LoginSuccessPage extends StatefulWidget{
  @override
  _LoginSuccessPage createState() {
    // TODO: implement createState
    return _LoginSuccessPage();
  }
}

class _LoginSuccessPage extends State<LoginSuccessPage>{
  final items = [
    BottomNavigationBarItem(icon: Image.asset("assets/loginSuccess/home.png"), title: Text('家庭')),
    BottomNavigationBarItem(icon: Image.asset("assets/loginSuccess/room.png"), title: Text('房间')),
    BottomNavigationBarItem(icon: Image.asset("assets/loginSuccess/my.png"), title: Text('我的'))
  ];
  final bodyList = [Home(), Room(), MyPage()];
  final pageController = PageController();
  int currrntIndex = 0;

  void onTap(int index){
    pageController.jumpToPage(index);
  }
  void onPageChanged(int index) {
    setState(() {
      currrntIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(items: items, currentIndex: currrntIndex, onTap: onTap),
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: bodyList
      )
    );
  }
}