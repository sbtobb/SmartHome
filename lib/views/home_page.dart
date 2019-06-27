import 'package:flutter/material.dart';
import 'package:division/division.dart';
import 'package:smart_home/data/protocol/result_bool.dart';
import 'package:smart_home/data/protocol/result_data.dart';
import 'package:smart_home/data/repository/api_repository.dart';
import 'package:provide/provide.dart';
import 'package:smart_home/model/sensor_data.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            style: StyleClass()
              ..width(300)
              ..height(150)
              ..elevation(50.0)
              ..backgroundImage(path: "assets/Home/logo.png", fit: BoxFit.fill)
              ..borderRadius(all: 10.0)
              ..align('top'),
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
        padding: EdgeInsets.fromLTRB(30, 25, 0, 0),
        child: Text("设备",
            style: TextStyle(fontSize: 20.0, color: Colors.black54)));
  }

  _snow() {
    return Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.fromLTRB(25, 8, 25, 0),
          height: 250,
          child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 1.18,
              children: _gridViews()),
        ));
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
      _myDivision(
        <Widget>[
          SvgImage.asset("assets/Home/门磁.svg", Size(48.0, 48.0)),
          Text("智能门磁"),
          Provide<SensorData>(
            builder: (context, child, sensorData) {
              if (sensorData.door) {
                return Text('状态:开');
              }
              return Text('状态:关');
            },
          )
        ],
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
          ..backgroundColor(Color.fromARGB(255, 255, 255, 255))
          ..borderRadius(all: 10.0),
        child: Padding(
            padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: Column(children: children)));
  }
}
