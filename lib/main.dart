import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:smart_home/views/navigation_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(new MyApp());

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

  final FocusNode _userNameFocusNode = FocusNode();
  final FocusNode _pwdFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _pwdEditController = TextEditingController();
    _userNameEditController = TextEditingController();
    _pwdEditController.addListener(() => setState(() => {}));
    _userNameEditController.addListener(() => setState(() => {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildAccountLoginTip(),
            _buildAccountLoginTipTo(),
            _buildEditWidget(),
            _buildLoginRegisterButton(),
          ],
        ),
      ),
    );
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

  _buildLoginRegisterButton() {
    return Padding(
      padding: EdgeInsets.fromLTRB(25, 20, 20, 0),
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
                  onPressed: (){
                    _loginButtonAction();
                    String name = _userNameEditController.text;
                    String pwd = _pwdEditController.text;
                    if(name == pwd){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginSuccess()));
                    }
                    else{
                      Fluttertoast.showToast(msg: "登录失败",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIos: 1);
                    }
                  },
                  child: Text(
                    "登录",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ),
          SizedBox(width: 15.0),
          Expanded(
              child: Container(
            height: 44,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(width: 1.0, color: Colors.lightBlue),
                color: Colors.lightBlue),
            child: FlatButton(
                onPressed: () {}, //event processing
                child: Text(
                  "注册",
                  style: TextStyle(color: Colors.white),
                )),
          ))
        ],
      ),
    );
  }

  _loginButtonAction() async {
    Response response;
    Dio dio = new Dio();
    String name = _userNameEditController.text;
    String pass = _pwdEditController.text;
    response = await dio.post("http://192.168.100.1/abox/index.php/abjhsdk/user/login", data: {"username": name, "password": pass});
    print(pass);
    print(response);
  }

  _buildLoginNameTextField() {
    return TextField(
      controller: _userNameEditController,
      focusNode: _userNameFocusNode,
      decoration: InputDecoration(
        hintText: "用户名/手机",
        border: InputBorder.none,
        prefixIcon: Image.asset(
          "assets/login/yonghu.png",
        ),
      ),
    );
  }

  _buildPwdTextField() {
    return TextField(
        controller: _pwdEditController,
        focusNode: _pwdFocusNode,
        obscureText: true,
        decoration: InputDecoration(
          hintText: "密码",
          border: InputBorder.none,
          prefixIcon: Image.asset(
            "assets/login/mima.png",
          ),
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
