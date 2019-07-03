import 'package:flutter/material.dart';
import 'home_page.dart';
import 'room_page.dart';
import 'my_page.dart';
import 'package:smart_home/model/sensor_data.dart';
import 'package:provide/provide.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_home/model/scene_data.dart';
import 'package:smart_home/data/repository/api_repository.dart';
import 'package:smart_home/data/api/apis.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';

class NavigationBar extends StatelessWidget {
  final String username;

  NavigationBar({this.username});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartHome',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
          //AppFuncBrowse(),
          NavigationBarPage(username: username,),
    );
  }
}

class NavigationBarPage extends StatefulWidget {
  final String username;

  NavigationBarPage({this.username});
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
  final bodyList = [Home(), Room()];
  final pageController = PageController();
  int currrntIndex = 0;
  Timer _timer;
  int _count = 0;
  bool _airCondition = false;
  bool _savePower = false;
  ApiRepository apiRepository = ApiRepository.instance;

  void onTap(int index) {
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      currrntIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    bodyList.add(My(username: widget.username));
    _initData();
  }

  _initData() async {
    await Future.delayed(const Duration(seconds: 1), () {
      Provide.value<SensorData>(context).initState();
      Provide.value<SceneData>(context).initState();
      _startTask();
    });
  }

  _startTask(){
    const oneSec = const Duration(seconds: 5);

    var callback = (timer){
      ///TaskCallback
      ///定时刷新器 60s 刷新一次数据
      _count += 1;
      if(_count > 12){
        Provide.value<SensorData>(context).initState();
        _count = 0;
      }

      // 获取情景状态
      final sceneData = Provide.value<SceneData>(context);
      final sensorData =  Provide.value<SensorData>(context);
      // 夏天模式
      if(sceneData.summer){
        // 判断空调是否打开
        if(!_airCondition){
          //获取温度
          double tem = double.parse(sensorData.temperature);
          bool door = sensorData.door;
          if(tem > 25.0 && door){
            print("夏天模式开启");
            apiRepository.sendIr(SmartApi.redName, "100");
            _toast("夏天模式开启");
            _airCondition = true;
          }
        }
      }
      if(sceneData.remoiveWet){
        //除湿模式
        int hum = int.parse(sensorData.humidity);
        bool socketB = sensorData.socketB;
        //如果湿度大于50
        if(hum > 50 && !socketB){
          Provide.value<SensorData>(context).changeSocketB();
          _toast("除湿模式开启");
        }
      }
      if(sceneData.savePower){
        // 省电模式开启
        DateTime now = new DateTime.now();
        if (now.hour >= 10 && now.hour < 18 ){
          if(sensorData.socketA && _savePower){
            Provide.value<SensorData>(context).changeSocketA();
            _toast("省电模式开启");
            _savePower = true;
          }
        }
      }
      if(sceneData.bed){
        // 睡眠模式开启
        DateTime now = new DateTime.now();
        if (now.hour > 1 && now.hour < 6 ){
          if(sensorData.socketA && _savePower){
            Provide.value<SensorData>(context).changeSocketA();
            _toast("睡眠模式开启");
            _savePower = true;
          }
        }
      }

    };
    ///启动任务
    _timer = Timer.periodic(oneSec, callback);
  }

  _toast(String val){
    Fluttertoast.showToast(
        msg: val,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 2);
  }
  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
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
