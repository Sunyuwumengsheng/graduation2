import 'package:flutter/foundation.dart';

///更新个人信息
class UpdataInfoRequsterEntitys {
  final String userId;
  final String nickname;
  final String gender;
  final String schoolname;

  UpdataInfoRequsterEntitys ({
    @required this.userId,
    @required this.nickname,
    @required this.gender,
    @required this.schoolname
  });

  factory UpdataInfoRequsterEntitys.fromJson(Map<String, dynamic> json) =>
      UpdataInfoRequsterEntitys(
          userId: json['userId'],
          nickname: json['nickname'],
          gender: json['gender'],
          schoolname: json['schoolname']);

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'nickname': nickname,
        'gender': gender,
        'schoolname': schoolname
      };
}

///更新信息返回
class UpdataInfroResponserEntitys {
  int code;
  String msg;
  UpadtaResonserInfo data;

  UpdataInfroResponserEntitys({this.code, this.msg, this.data});

  UpdataInfroResponserEntitys.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null
        ? new UpadtaResonserInfo.fromJson(json['data'])
        : null;
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

class UpadtaResonserInfo {
  String userID;
  String shcoolName;
  String nickname;
  String gender;

  UpadtaResonserInfo(
      {this.userID, this.shcoolName, this.nickname, this.gender});

  UpadtaResonserInfo.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    shcoolName = json['shcoolName'];
    nickname = json['nickname'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['shcoolName'] = this.shcoolName;
    data['nickname'] = this.nickname;
    data['gender'] = this.gender;
    return data;
  }
}
