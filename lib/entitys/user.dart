


import 'package:flutter/foundation.dart';

// 登录请求
class UserRequestEntity {
  final String userId;
  final String password;

   UserRequestEntity({
    @required this.userId,
    @required this.password,
  });

  factory UserRequestEntity.fromJson(Map<String, dynamic> json) =>
      UserRequestEntity(
        userId: json["userId"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "password": password,
      };
}

// 登录返回
class UserResponseEntity {
  int code;
  String msg;
  Data data;

  UserResponseEntity({this.code, this.msg, this.data});

  UserResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String userID;
  String shcoolName;
  String nickname;
  String headImg;
  String gender;

  Data({this.userID, this.shcoolName, this.nickname,this.headImg});

  Data.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    shcoolName = json['shcoolName'];
    nickname = json['nickname'];
    headImg = json['headImg'];
    gender=json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['shcoolName'] = this.shcoolName;
    data['nickname'] = this.nickname;
    data['headImg'] = this.headImg;
    data['gender'] = this.gender;
    return data;
  }
}
