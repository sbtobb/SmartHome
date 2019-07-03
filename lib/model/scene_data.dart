import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SceneData with ChangeNotifier {
  bool _summer = false;
  bool _remoiveWet = false;
  bool _savePower = false;
  bool _bed = false;
  bool _autoLogin = false;

  bool get summer => _summer;
  bool get remoiveWet => _remoiveWet;
  bool get savePower => _savePower;
  bool get bed => _bed;
  bool get autoLogin => _autoLogin;

  initState() async {
    await refreshSummer();
    await refreshRemoiveWet();
    await refreshSavePower();
    await refreshBed();
    await refreshAutoLogin();
  }

  refreshSummer() async {
    this._summer = await _getState("summer");
    notifyListeners();
  }

  changeSummere(bool _state) async {
    await _saveState("summer", _state);
    this._summer = _state;
    notifyListeners();
  }

  refreshRemoiveWet() async {
    this._remoiveWet = await _getState("remoiveWet");
    notifyListeners();
  }

  changeRemoiveWet(bool _state) async {
    await _saveState("remoiveWet", _state);
    this._remoiveWet = _state;
    notifyListeners();
  }

  refreshSavePower() async {
    this._savePower = await _getState("savePower");
    notifyListeners();
  }

  changeSavePower(bool _state) async {
    await _saveState("savePower", _state);
    this._savePower = _state;
    notifyListeners();
  }

  refreshBed() async {
    this._bed = await _getState("bed");
    notifyListeners();
  }

  changeBed(bool _state) async {
    await _saveState("bed", _state);
    this._bed = _state;
    notifyListeners();
  }

  refreshAutoLogin() async {
    this._autoLogin = await _getState("autoLogin");
    notifyListeners();
  }

  changeAutoLogin(bool _state) async {
    await _saveState("autoLogin", _state);
    this._autoLogin = _state;
    notifyListeners();
  }

  _saveState(String _key, bool _v) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, _v);
  }

  Future<bool> _getState(String _key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key) ?? false;
  }
}
