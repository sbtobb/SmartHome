import 'package:flutter/material.dart';
import 'package:smart_home/data/protocol/result_data.dart';
import 'package:smart_home/data/protocol/result_bool.dart';
import 'package:smart_home/data/repository/api_repository.dart';
import 'package:smart_home/data/api/apis.dart';
import 'package:smart_home/model/infrared.dart';
import 'package:smart_home/db/database_helper.dart';

class SensorData with ChangeNotifier {
  String _temperature = "20.0";
  String _humidity = "20.0";
  bool _socketA = false;
  bool _socketB = false;
  bool _socketC = false;
  bool _door = false;
  List<Map<String, dynamic>> _infraredList = [];

  String get temperature => _temperature;
  String get humidity => _humidity;
  bool get socketA => _socketA;
  bool get socketB => _socketB;
  bool get socketC => _socketC;
  bool get door => _door;

  List<Map<String, dynamic>> get infraredList {
    return _infraredList;
  }

  ApiRepository apiRepository = ApiRepository.instance;

  initState() async {
    await refreshTH();
    await refreshSocketA();
    await refreshSocketB();
    await refreshDoor();
    await refreshInfraredList();
  }

  refreshInfraredList() async {
    final dbHelper = DatabaseHelper.instance;
    this._infraredList = await dbHelper.queryAllRows();
    notifyListeners();
  }

  /// 刷新温湿度数据
  refreshTH() async {
    ResultData resultData =
        await apiRepository.getThStatus(SmartApi.temperName);
    print(resultData);
    _temperature = resultData.data['temperature'] ?? "20.0";
    _humidity = resultData.data['humidity'] ?? "20.0";
    print(_temperature);
    notifyListeners();
  }

  /// 刷新插座A
  refreshSocketA() async {
    ResultBool resultBool =
        await apiRepository.getSockStatus(SmartApi.socketAName);
    _socketA = resultBool.status;
    notifyListeners();
  }

  /// 修改插座A
  changeSocketA() async {
    ResultBool resultBool;
    if (socketA) {
      resultBool = await apiRepository.sockCtrl(SmartApi.socketAName, "0");
    } else {
      resultBool = await apiRepository.sockCtrl(SmartApi.socketAName, "1");
    }
    if (resultBool.exeResult) {
      _socketA = !_socketA;
      notifyListeners();
    }
  }

  /// 刷新插座B
  refreshSocketB() async {
    ResultBool resultBool =
        await apiRepository.getSockStatus(SmartApi.socketBName);
    _socketB = resultBool.status;
    notifyListeners();
  }

  /// 修改插座B
  changeSocketB() async {
    ResultBool resultBool;
    if (socketB) {
      resultBool = await apiRepository.sockCtrl(SmartApi.socketBName, "0");
    } else {
      resultBool = await apiRepository.sockCtrl(SmartApi.socketBName, "1");
    }
    if (resultBool.exeResult) {
      _socketB = !_socketB;
      notifyListeners();
    }
  }

  /// 刷新插座B
  refreshSocketC() async {
    ResultBool resultBool =
        await apiRepository.getSockStatus(SmartApi.socketCName);
    _socketC = resultBool.status;
    notifyListeners();
  }

  /// 修改插座C
  changeSocketC() async {
    ResultBool resultBool;
    if (socketC) {
      resultBool = await apiRepository.sockCtrl(SmartApi.socketCName, "0");
    } else {
      resultBool = await apiRepository.sockCtrl(SmartApi.socketCName, "1");
    }
    if (resultBool.exeResult) {
      _socketC = !_socketC;
      notifyListeners();
    }
  }

  ///刷新门磁状态
  refreshDoor() async {
    ResultBool resultBool =
        await apiRepository.getDoorStatus(SmartApi.doorName);
    _door = resultBool.status;
    notifyListeners();
  }
}
