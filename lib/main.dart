import 'package:flutter/material.dart';
import 'package:smart_home/data/protocol/result_bool.dart';
import 'package:smart_home/views/navigation_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_home/data/repository/api_repository.dart';
import 'package:provide/provide.dart';
import 'package:smart_home/model/sensor_data.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home/db/database_helper.dart';
import 'package:smart_home/model/infrared.dart';

void main() {
  var sensorData = SensorData();
  Providers providers = Providers();

//将counter对象添加进providers
  providers.provide(Provider<SensorData>.value(sensorData));

  runApp(
    ProviderNode(child: MyApp(), providers: providers),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartHome',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
          //AppFuncBrowse(),
          LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() {
    // TODO: implement createState
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _pwdEditController;
  TextEditingController _userNameEditController;
  ApiRepository apiRepository = ApiRepository.instance;
  bool _loading = false;
  bool _autoLogin = false;
  String token = "";

  final FocusNode _userNameFocusNode = FocusNode();
  final FocusNode _pwdFocusNode = FocusNode();

  final dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    _pwdEditController = TextEditingController();
    _userNameEditController = TextEditingController();
    _pwdEditController.addListener(() => setState(() => {}));
    _userNameEditController.addListener(() => setState(() => {}));
    _loadConfig();
  }

  _loadConfig() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _autoLogin = prefs.getBool("autoLogin") ?? false;
    if (!_autoLogin) {
      return;
    }
    _userNameEditController.text = prefs.getString("username") ?? "";
    _pwdEditController.text = prefs.getString("password") ?? "";
    token = prefs.getString("token") ?? "";
    if (token != "") {
      print("自动登陆token:${token}");
      _autoLoginAction();
    }
  }

  _autoLoginAction() async {
    setState(() {
      _loading = true;
    });
    bool result = await apiRepository.isValidateToken(this.token);
    setState(() {
      _loading = false;
    });
    if (result) {
      Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(builder: (context) => new NavigationBar()),
          (route) => route == null);
    } else {
      Fluttertoast.showToast(
          msg: "登录失败,Token已失效",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 3);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ModalProgressHUD(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildAccountLoginTip(),
                  _buildAccountLoginTipTo(),
                  _buildEditWidget(),
                  _buildAutoCheckBox(),
                  _buildLoginRegisterButton(),
                ],
              ),
            ),
            inAsyncCall: _loading));
  }

  _buildAccountLoginTip() {
    return Padding(
      padding: EdgeInsets.fromLTRB(40, 50, 15, 0),
      child: Text(
        "Welcome " "Home",
        textAlign: TextAlign.start,
        style: TextStyle(
            fontFamily: 'Regular', fontSize: 48.0, fontWeight: FontWeight.w700),
      ),
    );
  }

  _buildAccountLoginTipTo() {
    return Padding(
      padding: EdgeInsets.fromLTRB(40, 0, 15, 0),
      child: Text(
        "Please Login First",
        maxLines: 1,
        textAlign: TextAlign.start,
        style: TextStyle(fontFamily: 'Regular', fontSize: 20.0),
      ),
    );
  }

  _buildAutoCheckBox() {
    return Padding(
        padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Checkbox(
                activeColor: Color(0xFF3498DB),
                value: _autoLogin,
                onChanged: (bool val) {
                  setState(() {
                    _autoLogin = val;
                  });
                },
              ),
              Text("自动登陆")
            ]));
  }

  _buildLoginRegisterButton() {
    return Padding(
      padding: EdgeInsets.fromLTRB(25, 8, 20, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(width: 1.0, color: Colors.lightBlue),
                  color: Colors.lightBlue),
              child: FlatButton(
                  onPressed: () {
                    _loginButtonAction();
                  },
                  child: Text(
                    "登录",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          )
        ],
      ),
    );
  }

  _loginButtonAction() async {
    setState(() {
      _loading = true;
    });
    String username = _userNameEditController.text;
    String password = _pwdEditController.text;
    ResultBool result = await apiRepository.login(username, password);
    setState(() {
      _loading = false;
    });
    if (result.exeResult) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("autoLogin", this._autoLogin);
      if (this._autoLogin) {
        prefs.setString("username", username);
        prefs.setString("password", password);
      }
      Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(builder: (context) => new NavigationBar()),
          (route) => route == null);
    } else {
      Fluttertoast.showToast(
          msg: "登录失败",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 3);
    }
  }

  _buildLoginNameTextField() {
    return TextField(
      controller: _userNameEditController,
      focusNode: _userNameFocusNode,
      decoration: InputDecoration(
        labelText: "用户名",
        border: InputBorder.none,
        icon: SvgImage.asset("assets/navigation/用户.svg", Size(30.0, 30.0)),
      ),
    );
  }

  _buildPwdTextField() {
    return TextField(
        controller: _pwdEditController,
        focusNode: _pwdFocusNode,
        obscureText: true,
        decoration: InputDecoration(
          labelText: "密码",
          border: InputBorder.none,
          icon: SvgImage.asset("assets/login/密码.svg", Size(30.0, 30.0)),
        ));
  }

  _buildEditWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(30, 50, 30, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Column(
        children: <Widget>[
          _buildLoginNameTextField(),
          Divider(height: 1.0, color: Colors.black87),
          _buildPwdTextField(),
          Divider(height: 1.0, color: Colors.black87),
        ],
      ),
    );
  }
}
