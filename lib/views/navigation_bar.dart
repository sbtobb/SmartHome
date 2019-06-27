import 'package:flutter/material.dart';
import 'home_page.dart';
import 'room_page.dart';
import 'my_page.dart';
import 'package:smart_home/model/sensor_data.dart';
import 'package:provide/provide.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartHome',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
          //AppFuncBrowse(),
      NavigationBarPage(),
    );
  }
}

class NavigationBarPage extends StatefulWidget {
  @override
  _NavigationBarPageState createState() {
    // TODO: implement createState
    return _NavigationBarPageState();
  }
}

class _NavigationBarPageState extends State<NavigationBarPage> {
  final items = [
    BottomNavigationBarItem(
        icon: SvgImage.asset("assets/navigation/home.svg", Size(30.0, 30.0)),
        title: Text('家庭')),
    BottomNavigationBarItem(
        icon: SvgImage.asset("assets/navigation/场景管理.svg", Size(30.0, 30.0)),
        title: Text('场景')),
    BottomNavigationBarItem(
        icon: SvgImage.asset("assets/navigation/用户.svg", Size(30.0, 30.0)),
        title: Text('我的'))
  ];
  final bodyList = [Home(), Room(), MyPage()];
  final pageController = PageController();
  int currrntIndex = 0;

  void onTap(int index) {
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      currrntIndex = index;
    });
  }

  void initState() {
    super.initState();

    _initData();
  }

  _initData() async {
    await Future.delayed(const Duration(seconds: 1),
        () => Provide.value<SensorData>(context).initState());
  }

  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            items: items, currentIndex: currrntIndex, onTap: onTap),
        body: PageView(
            controller: pageController,
            onPageChanged: onPageChanged,
            children: bodyList));
  }
}
