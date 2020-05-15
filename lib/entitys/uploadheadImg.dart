import 'dart:io';

import 'package:flutter/foundation.dart';

class UpLodaHeadImgRequestEntity {
  final String userId;
  final File headImg;

  UpLodaHeadImgRequestEntity({@required this.userId, @required this.headImg});
  factory UpLodaHeadImgRequestEntity .fromJson(Map<String, dynamic> json) =>
      UpLodaHeadImgRequestEntity (
        userId: json["userId"],
        headImg: json["headImg"],
      );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "headImg": headImg,
  };

}
class HeadImgResponseEntity{
  int code;
  String msg;
  String data;

  HeadImgResponseEntity({this.code, this.msg, this.data});

  HeadImgResponseEntity.fromJson(Map<String, dynamic> json) {
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