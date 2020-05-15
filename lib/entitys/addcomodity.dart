import 'package:flutter/foundation.dart';

class AddCommodityRequsterEntitys{
  String commodityid;
  String userId;
  AddCommodityRequsterEntitys({@required this.commodityid,@required this.userId});
  Map<String,dynamic> toJson()=>{
    "commodityid":commodityid,
    "userId":userId
  };
}
class AddCommodityResponseEntitys{
  int code;
  String msg;
  Null data;

  AddCommodityResponseEntitys({this.code, this.msg, this.data});

  AddCommodityResponseEntitys.fromJson(Map<String, dynamic> json) {
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