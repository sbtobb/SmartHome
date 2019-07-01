import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_home/db/database_helper.dart';
import 'package:smart_home/model/infrared.dart';
import 'package:smart_home/data/repository/api_repository.dart';
import 'package:smart_home/data/protocol/result_bool.dart';
class InfraredLearn extends StatefulWidget {
  @override
  InfraredLearnState createState() => new InfraredLearnState();
}

class InfraredLearnState extends State<InfraredLearn> {
  TextEditingController _keyEditController;
  TextEditingController _nameEditController;
  final dbHelper = DatabaseHelper.instance;
  ApiRepository apiRepository = ApiRepository.instance;

  final FocusNode _nameNameFocusNode = FocusNode();
  final FocusNode _keyFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _keyEditController = TextEditingController();
    _nameEditController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(InfraredLearn oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _title(),
            _buildEditWidget(),
            _buildLoginRegisterButton()
          ],
        ),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  _title() {
    return Padding(
        padding: EdgeInsets.fromLTRB(30, 20, 0, 0),
        child: Row(
          children: <Widget>[
            Text("红外学习",
                style: TextStyle(fontSize: 32.0, color: Colors.black87)),
          ],
        ));
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
                  onPressed:_learn,
                  child: Text(
                    "学习",
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
                    onPressed: _addInfrared, //event processing
                    child: Text(
                      "添加",
                      style: TextStyle(color: Colors.white),
                    )),
              ))
        ],
      ),
    );
  }

  _learn(){
    _infraredStudy(true);
  }

  _addInfrared(){
    _infraredStudy(false);
  }

  _infraredStudy(bool _study) async {
    String name =_nameEditController.text;
    String key = _keyEditController.text;
    if (name == "" || key == ""){
      Fluttertoast.showToast(
          msg: "设备名或密码不能为空",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 3);
      return;
    }
    if(_study){
       ResultBool resultBool = await apiRepository.studyIrByIrDevName("red", key);
       if(!resultBool.exeResult){
         Fluttertoast.showToast(
             msg: "红外学习失败!消息:${resultBool.msg}",
             toastLength: Toast.LENGTH_SHORT,
             gravity: ToastGravity.BOTTOM,
             timeInSecForIos: 3);
         return;
       }
    }
    Infrared infrared = Infrared(name:name,key:key);
    await dbHelper.insert(infrared.toMap());
    Fluttertoast.showToast(
        msg: "红外学习成功！",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 3);
  }

  _buildLoginNameTextField() {
    return Container(
      child: TextField(
        controller: _nameEditController,
        focusNode: _nameNameFocusNode,
        decoration: InputDecoration(
            labelText: "device",
            border: InputBorder.none,
            icon: Icon(Icons.settings_remote)),
      ),
    );
  }

  _buildPwdTextField() {
    return TextField(
        controller: _keyEditController,
        focusNode: _keyFocusNode,
        decoration: InputDecoration(
            labelText: "key(1-255)",
            border: InputBorder.none,
            icon: Icon(Icons.keyboard_hide)));
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
        ));
  }
}