import 'package:flutter/foundation.dart';

class Chatmsg{
  String to_user;
  String msg;
  String headImg;
  Chatmsg({@required this.to_user,@required this.msg,this.headImg});
  Chatmsg.fromJson(Map<String, dynamic> json) {
    to_user = json['to_user'];
    msg = json['msg'];
    headImg = json['headImg'];
  }
  Map<String,dynamic> toJosn()=>{
    'to_user' :to_user,
    'msg':msg,
    'headImg':headImg,
  };
}