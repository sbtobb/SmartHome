import 'package:flutter/material.dart';
import 'package:division/division.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_home/data/repository/api_repository.dart';
import 'package:provide/provide.dart';
import 'package:smart_home/model/sensor_data.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_home/views/infrared_learn.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartHome',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home:
          //AppFuncBrowse(),
          HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  ApiRepository apiRepository = ApiRepository.instance;
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    this._context = context;
    Provide.value<SensorData>(context).refreshInfraredList();
    return Scaffold(
        backgroundColor: Color.fromARGB(50, 200, 200, 200),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[_title(), _homeTop(), _equipment(), _snow()],
        ));
  }

  _title() {
    return Padding(
        padding: EdgeInsets.fromLTRB(30, 20, 0, 0),
        child: Text("家庭",
            style: TextStyle(fontSize: 32.0, color: Colors.black87)));
  }

  _homeTop() {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Division(
            gesture: GestureClass()
              ..onDoubleTap(
                  () => Provide.value<SensorData>(_context).refreshTH()),
            style: StyleClass()
              ..width(300)
              ..height(150)
              ..elevation(50.0)
              ..background.image(path: "assets/Home/logo.png", fit: BoxFit.fill)
              ..borderRadius(all: 10.0)
              ..elevation(10, color: rgb(150, 150, 150))
              ..alignment.topCenter(),
            child: Row(children: <Widget>[_weather(), _temperature()])));
  }

  _weather() {
    return Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
        child: Column(children: <Widget>[
          Row(
            children: <Widget>[
              Division(
                  child:
                      Icon(Icons.wb_sunny, size: 32, color: Color(0xFF42526F))),
              Text("晴", style: TextStyle(fontSize: 32.0, color: Colors.black54))
            ],
          ),
          Text("室内湿度", style: TextStyle(fontSize: 10.0, color: Colors.black54)),
          Provide<SensorData>(
            builder: (context, child, sensorData) {
              return Text("${sensorData.humidity}%",
                  style: TextStyle(fontSize: 18.0, color: Colors.lightGreen));
            },
          )
        ]));
  }

  _temperature() {
    return Padding(
        padding: EdgeInsets.fromLTRB(120, 20, 0, 0),
        child: Column(
          children: <Widget>[
            Text("室内温度",
                style: TextStyle(fontSize: 10.0, color: Colors.black54)),
            Provide<SensorData>(
              builder: (context, child, sensorData) {
                return Text("${sensorData.temperature}℃",
                    style: TextStyle(fontSize: 24.0, color: Colors.lightGreen));
              },
            ),
          ],
        ));
  }

  _equipment() {
    return Container(
        padding: EdgeInsets.fromLTRB(30, 25, 35, 0),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Text("设备",
                    style:
                        TextStyle(fontSize: 20.0, color: Color(0xFF515151)))),
            Division(
              style: StyleClass()
                ..background.hex("#EEEEEE")
                ..borderRadius(all: 50),
              gesture: GestureClass()
                ..onTap(() {
                  Navigator.of(_context).push(
                      new MaterialPageRoute(builder: (context) => new InfraredLearn()));
                  print("123123123");
                }),
              child: SvgImage.asset("assets/Home/添加.svg", Size(30.0, 30.0)),
            )
          ],
        ));
  }

  _snow() {
    return Expanded(
        flex: 1,
        child: Container(
            padding: EdgeInsets.fromLTRB(25, 8, 25, 0),
            child: Provide<SensorData>(builder: (context, child, sensorData) {
              List<Widget> subWidgetList = _gridViews();
              subWidgetList.addAll(_infraredDivision(sensorData.infraredList));
              return GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 1.18,
                  children: subWidgetList);
            })));
  }

  _gridViews() {
    return <Widget>[
      _myDivision(
        <Widget>[
          SvgImage.asset("assets/Home/台灯.svg", Size(48.0, 48.0)),
          Text("台灯"),
          Provide<SensorData>(
            builder: (context, child, sensorData) {
              return Switch(
                value: sensorData.socketA,
                onChanged: (bool val) {
                  sensorData.changeSocketA();
                },
              );
            },
          )
        ],
      ),
      _myDivision(
        <Widget>[
          SvgImage.asset("assets/Home/插座.svg", Size(48.0, 48.0)),
          Text("插座"),
          Provide<SensorData>(
            builder: (context, child, sensorData) {
              return Switch(
                value: sensorData.socketB,
                onChanged: (bool val) {
                  sensorData.changeSocketB();
                },
              );
            },
          )
        ],
      ),
      Division(
        gesture: GestureClass()
          ..onDoubleTap(
              () => Provide.value<SensorData>(_context).refreshDoor()),
        style: StyleClass()
          ..background.hex("#FFFFFF")
          ..ripple(true)
          ..elevation(10, color: rgb(150, 150, 150))
          ..borderRadius(all: 10.0),
        child: Padding(
            padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: Column(children: <Widget>[
              SvgImage.asset("assets/Home/门磁.svg", Size(48.0, 48.0)),
              Text("智能门磁\n"),
              Provide<SensorData>(
                builder: (context, child, sensorData) {
                  if (sensorData.door) {
                    return Text('状态:开');
                  }
                  return Text('状态:关');
                },
              )
            ])),
      ),
      _myDivision(
        <Widget>[
          SvgImage.asset("assets/Home/电视.svg", Size(48.0, 48.0)),
          Text("电视"),
          Provide<SensorData>(
            builder: (context, child, sensorData) {
              return Switch(
                value: sensorData.socketC,
                onChanged: (bool val) {
                  sensorData.changeSocketC();
                },
              );
            },
          )
        ],
      ),
    ];
  }

  _myDivision(List<Widget> children) {
    return Division(
        style: StyleClass()
          ..background.hex("#FFFFFF")
          ..borderRadius(all: 10.0)
          ..elevation(10, color: rgb(150, 150, 150)),
        child: Padding(
            padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: Column(children: children)));
  }

  List<Widget> _infraredDivision(List<Map<String, dynamic>> gridList) {
    return List<Widget>.generate(gridList.length, (index) {
      return _infraredItem(gridList[index]['name'], gridList[index]['key']);
    });
  }

  Widget _infraredItem(String name, String key) {
    return Division(
        gesture: GestureClass()
          ..onTap(() {
            apiRepository.sendIr("red", key);
            Fluttertoast.showToast(
                msg: "发送红外成功",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 3);
          }),
        style: StyleClass()
          ..background.hex("#FFFFFF")
          ..elevation(10, color: rgb(150, 150, 150))
          ..borderRadius(all: 10.0),
        child: Padding(
            padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: Column(children: [
              SvgImage.asset("assets/Home/遥控.svg", Size(48.0, 48.0)),
              Text("\n$name"),
            ])));
  }
}
