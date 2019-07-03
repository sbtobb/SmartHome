import 'dart:convert';
import '../net/http_utils.dart';
import '../api/apis.dart';
import '../protocol/result_data.dart';
import '../protocol/result_bool.dart';
import 'package:smart_home/utils/encrypt_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ApiRepository {
  /// 工厂模式
  factory ApiRepository() =>_getInstance();
  static ApiRepository get instance => _getInstance();
  static ApiRepository _instance;
  ApiRepository._internal() {
    /// 初始化
  }
  static ApiRepository _getInstance() {
    if (_instance == null) {
      _instance = new ApiRepository._internal();
    }
    return _instance;
  }
  String token;
  final String error_str = "{\"code\":\"00002\",\"msg\":\"网络连接错误\"}";

  /// 登陆
  ///
  /// 输入用户名[username] 密码[password]用于登陆系统
  Future<ResultBool> login(String username,String password) async{
    var result = await HttpUtils.request(
        SmartApi.user_login,
        method: HttpUtils.POST,
        data: {
          'username':username,
          'password':EncryptUtils.generateMd5(password)
        });

    final jsonMap = json.decode(result ?? this.error_str);
    ResultData resultData = ResultData.fromJson(jsonMap);

    if(resultData.code == "00000"){
      //登陆成功
      //解析token
      this.token = resultData.data['token'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("token", this.token);
    }
    return ResultBool.fromResultData(resultData);
  }

  /// 验证Token是否有效
  ///
  /// 输入可选参数[token]
  /// 若[token]为空,则使用预存的token
  /// 将会返回是否成功
  Future<bool> isValidateToken([String token]) async {
    if ((token ?? this.token) == null){
      return false;
    }
    var result = await HttpUtils.request(
        SmartApi.is_validate_token,
        method: HttpUtils.POST,
        data: {
          'token':token ?? this.token
        });
    final jsonMap = json.decode(result ?? this.error_str);
    ResultData resultData = ResultData.fromJson(jsonMap);
    if(resultData.code != "00000"){
      return false;
    }
    if(resultData.data["status"] == "1"){
      this.token = token ?? this.token;
      return true;
    }
    return false;
  }

  ///红外学习
  ///
  /// 设备[irDevName]将会学习红外资料并保存到[irKey]中
  Future<ResultBool> studyIrByIrDevName(String irDevName, String irKey) async{
    var result = await HttpUtils.request(
        SmartApi.study_ir,
        method: HttpUtils.POST,
        data: {
          'devName':irDevName,
          'irKey' : irKey,
          'system[token]':this.token
        });
    final jsonMap = json.decode(result ?? this.error_str);
    ResultData resultData = ResultData.fromJson(jsonMap);
    return ResultBool.fromResultData(resultData);
  }

  /// 发送红外
  ///
  /// 会向设备名称:[irDevName] 发送[irKey]预留保存的红外数据
  /// 将会返回是否成功
  Future<ResultBool> sendIr(String irDevName,String irKey) async {
    var result = await HttpUtils.request(
        SmartApi.send_ir,
        method: HttpUtils.POST,
        data: {
          'devName':irDevName,
          'irKey' : irKey,
          'system[token]':this.token
        });
    final jsonMap = json.decode(result ?? this.error_str);
    ResultData resultData = ResultData.fromJson(jsonMap);
    return ResultBool.fromResultData(resultData);
  }

  /// 插座控制
  ///
  /// 待控制的设备名称:[soDevName] 状态:[status] 1: 0:
  /// 将会返回是否成功
  Future<ResultBool> sockCtrl(String soDevName, String status) async {
    var result = await HttpUtils.request(
        SmartApi.sock_ctrl,
        method: HttpUtils.POST,
        data: {
          'devName':soDevName,
          'status' : status,
          'system[token]':this.token
        });
    final jsonMap = json.decode(result ?? this.error_str);
    ResultData resultData = ResultData.fromJson(jsonMap);
    return ResultBool.fromResultData(resultData);
  }

  /// 取得插座状态
  ///
  /// 待控制的设备名称:[soDevName]
  /// 将会返回是否成功
  Future<ResultBool> getSockStatus(String soDevName) async {
    var result = await HttpUtils.request(
        SmartApi.get_sock_status,
        method: HttpUtils.POST,
        data: {
          'name':soDevName,
          'system[token]':this.token
        });
    final jsonMap = json.decode(result ?? this.error_str);
    ResultData resultData = ResultData.fromJson(jsonMap);
    return ResultBool.fromResultData(resultData);
  }

  /// 取得门磁状态
  ///
  /// 待控制的设备名称:[doorDevName]
  /// 将会返回是否成功
  Future<ResultBool> getDoorStatus(String doorDevName) async{
    var result = await HttpUtils.request(
        SmartApi.get_door_status,
        method: HttpUtils.POST,
        data: {
          'name':doorDevName,
          'system[token]':this.token
        });
    final jsonMap = json.decode(result ?? this.error_str);
    ResultData resultData = ResultData.fromJson(jsonMap);
    return ResultBool.fromResultData(resultData);

  }
  /// 取得温湿度情报
  ///
  /// 待取的设备名称[thDevName]
  /// 返回数据 data: temperature 温度 humidity  湿度
  Future<ResultData> getThStatus(String thDevName) async {
    var result = await HttpUtils.request(
        SmartApi.get_th_status,
        method: HttpUtils.POST,
        data: {
          'name':thDevName,
          'system[token]':this.token
        });

    final jsonMap = json.decode(result ?? this.error_str);
    ResultData resultData = ResultData.fromJson(jsonMap);
    return resultData;
  }

}