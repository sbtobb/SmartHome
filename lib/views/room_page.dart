import 'package:flutter/material.dart';
import 'package:division/division.dart';
import 'package:smart_home/model/scene_data.dart';
import 'Widget/settings_item.dart';
import 'package:provide/provide.dart';

class Room extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '场景',
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

class _RoomPageState extends State<RoomPage> {
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(50, 200, 200, 200),
        body: Padding(
            padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _title(),
                Provide<SceneData>(builder: (context, child, sceneData) {
                  return SettingsItem(Icons.wb_sunny, hex('#f1c40f'), '夏天模式',
                      '开启后将会自动开启空调', sceneData.summer, (val) {
                        Provide.value<SceneData>(context).changeSummere(val);
                      });
                }),
                Provide<SceneData>(builder: (context, child, sceneData) {
                  return SettingsItem(Icons.wb_cloudy, hex('#2980b9'), '除湿模式',
                      '当湿度大于60%打开除湿器', sceneData.remoiveWet, (val) {
                        Provide.value<SceneData>(context).changeRemoiveWet(val);
                      });
                }),
                Provide<SceneData>(builder: (context, child, sceneData) {
                  return SettingsItem(Icons.flash_on, hex('#27ae60'), '省电模式',
                      '将降低电器功率', sceneData.savePower, (val) {
                        Provide.value<SceneData>(context).changeSavePower(val);
                      });
                }),
                Provide<SceneData>(builder: (context, child, sceneData) {
                  return SettingsItem(Icons.hotel, hex('#34495e'), '睡眠模式',
                      '熟睡时忘记关灯将自动关灯', sceneData.bed, (val) {
                        Provide.value<SceneData>(context).changeBed(val);
                      });
                })
              ],
            )));
  }

  _title() {
    return Text("场景",
        style: TextStyle(fontSize: 32.0, color: Colors.black87),
        textAlign: TextAlign.left);
  }
}

