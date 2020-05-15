import 'dart:convert';
import 'dart:math';


import 'package:shared_preferences/shared_preferences.dart';


/// 本地存储
class StorageUtil {
  static StorageUtil _instance = new StorageUtil._();
  factory StorageUtil() => _instance;
  static SharedPreferences _prefs;

  StorageUtil._();

  static Future<void> init() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  /// 设置 json 对象
  Future<bool> setJSON(String key, dynamic jsonVal) {
    String jsonString = jsonEncode(jsonVal);
    return _prefs.setString(key, jsonString);
  }

  /// 获取 json 对象
  dynamic getJSON(String key) {
    String jsonString = _prefs.getString(key);
    return jsonString == null ? null : jsonDecode(jsonString);
  }

  /// 删除 json 对象
  Future<bool> remove(String key) {
    return _prefs.remove(key);
  }
  Future setLogin(String key,bool s){
    return _prefs.setBool(key, s);
  }
  dynamic getIslogin(String key){
    bool s =_prefs.getBool(key);
    return s==null?false:s;
  }
  Future setpermission(String permission,bool s){
    return _prefs.setBool(permission, s);
  }
  dynamic getIspermission(String permission){
    bool s = _prefs.getBool(permission);
    return s==null?false:s;
  }
  Future<bool> setBool(String key, bool val) {
    return _prefs.setBool(key, val);
  }

  bool getBool(String key) {
    bool val = _prefs.getBool(key);
    return val == null ? false : val;
  }

}