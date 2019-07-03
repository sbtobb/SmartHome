import 'package:flutter/material.dart';
import 'package:division/division.dart';
import 'Widget/settings_item.dart';
import 'package:smart_home/model/scene_data.dart';
import 'package:provide/provide.dart';
class My extends StatelessWidget {
  final String username;

  My({this.username});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartHome',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
          //AppFuncBrowse(),
          MyPage(username: username,),
    );
  }
}

class MyPage extends StatefulWidget {
  final String username;

  MyPage({this.username});
  @override
  _MyPageState createState() {
    // TODO: implement createState
    return _MyPageState();
  }
}

class _MyPageState extends State<MyPage> {
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(50, 200, 200, 200),
        body: Padding(
            padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _title(),
                SizedBox(height: 10),
                UserCard(name: widget.username),
                SizedBox(height: 15),
                _setting(),
                SizedBox(height: 10),
                Provide<SceneData>(builder: (context, child, sceneData) {
                  return SettingsItem(Icons.settings, hex('#2c3e50'), '自动登陆',
                      '开启时将会自动登陆', sceneData.autoLogin, (val) {
                        Provide.value<SceneData>(context).changeAutoLogin(val);
                      });
                })
              ],
            )));
  }

  Widget _title() {
    return Text("关于我",
        style: TextStyle(fontSize: 32.0, color: Colors.black87),
        textAlign: TextAlign.left);
  }

  Widget _setting() {
    return Text("设置",
        style: TextStyle(fontSize: 28.0, color: Colors.black87),
        textAlign: TextAlign.left);
  }
}

class UserCard extends StatelessWidget {
  final String name;

  UserCard({this.name});

  Widget _buildUserRow() {
    return Row(
      children: <Widget>[
        Division(
          style: userImageStyle,
          child: Icon(Icons.account_circle),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              name ?? "Customer",
              style: nameTextStyle,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '智慧改变生活',
              style: nameDescriptionTextStyle,
            )
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Division(
      style: userCardStyle,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[_buildUserRow()],
      ),
    );
  }

  //Styling

  final StyleClass userCardStyle = StyleClass()
    ..height(100)
    ..padding(horizontal: 20.0, vertical: 10)
    ..alignment.center()
    ..background.hex('#2ecc71')
    ..borderRadius(all: 20.0)
    ..elevation(10, color: hex('#2ecc71'));

  final StyleClass userImageStyle = StyleClass()
    ..height(50)
    ..width(50)
    ..margin(right: 10.0)
    ..borderRadius(all: 30)
    ..background.hex('ffffff');

  final StyleClass userStatsStyle = StyleClass()..margin(vertical: 10.0);

  final TextStyle nameTextStyle = TextStyle(
      color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600);

  final TextStyle nameDescriptionTextStyle =
      TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12.0);
}
