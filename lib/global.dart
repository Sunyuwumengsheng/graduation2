import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduation/values/valuesutils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'entitys/entitys.dart';
import 'utils/http.dart';
import 'utils/storage.dart';


/// 全局配置
class Global {
  /// 用户配置
  static UserResponseEntity profile = UserResponseEntity();
  static String userId="";

  /// 是否 release
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");
  /// 是否第一次打开
  static bool isFirstOpen = false;

  /// 是否离线登录
  static bool isOfflineLogin = false;
  /// init
  static Future init() async {
    // 运行初始
    WidgetsFlutterBinding.ensureInitialized();
//    SharedPreferences.setMockInitialValues({});
    // 工具初始
    await StorageUtil.init();
    HttpUtil();
    // 读取设备第一次打开
    isFirstOpen = !StorageUtil().getBool(STORAGE_DEVICE_ALREADY_OPEN_KEY);
    print(isFirstOpen.toString());
    if (isFirstOpen) {
      StorageUtil().setBool(STORAGE_DEVICE_ALREADY_OPEN_KEY, true);
    }
    // 读取离线用户信息
    var _profileJSON = StorageUtil().getJSON(STORAGE_USER_PROFILE_KEY);
    if (_profileJSON != null) {
      profile = UserResponseEntity.fromJson(_profileJSON);
      isOfflineLogin = true;
      userId = profile.data.userID;
    }

    // http 缓存

    // android 状态栏为透明的沉浸
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle =
          SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }

  }
//   持久化 用户信息
  static Future<bool> saveProfile(UserResponseEntity userResponse) {
    profile = userResponse;
    return StorageUtil()
        .setJSON(STORAGE_USER_PROFILE_KEY, userResponse.toJson());
  }

}
