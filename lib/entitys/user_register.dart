
import 'package:flutter/foundation.dart';
///注册
class RegisterRequestEntity {
  final String userId;
  final String password;
  final String shcoolName;

  RegisterRequestEntity({
    @required this.userId,
    @required this.password,
    @required this.shcoolName
  });

  factory RegisterRequestEntity.fromJson(Map<String, dynamic> json) =>
      RegisterRequestEntity(
        userId: json["userId"],
        password: json["password"],
          shcoolName: json["shcoolName"]
      );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "password": password,
    "shcoolName":shcoolName
  };
}
///注册返回

class RegisterResponseEntity {
  int code;
  String msg;
  String data;

  RegisterResponseEntity({this.code, this.msg, this.data});

  RegisterResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    data['data'] = this.data;
    return data;
  }
}
