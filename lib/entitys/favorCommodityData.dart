import 'package:flutter/foundation.dart';

class FavorCommoditysRequsterEntitys{
  String userId;
  FavorCommoditysRequsterEntitys({
    @required this.userId});
  factory FavorCommoditysRequsterEntitys.fromJson(Map<String, dynamic> json)=>
      FavorCommoditysRequsterEntitys(userId: json['userId']);
  Map<String, dynamic> toJson() => {
    "userId": userId,
  };
}
class FavorCommodityResponsEntitys {
  int code;
  List<FavorCommodityData> data;
  String msg;
  int stutas;

  FavorCommodityResponsEntitys({this.code, this.data, this.msg, this.stutas});

  FavorCommodityResponsEntitys.fromJson(Map<String, dynamic> json) {
    code = json['code,'];
    if (json['data'] != null) {
      data = new List<FavorCommodityData>();
      json['data'].forEach((v) {
        data.add(new FavorCommodityData.fromJson(v));
      });
    }
    msg = json['msg'];
    stutas = json['stutas'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code,'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['msg'] = this.msg;
    data['stutas'] = this.stutas;
    return data;
  }
}
class FavorCommodityData {
  String commodityImg;
  String commoditydescribe;
  String commodityid;
  String commodityname;
  int commodityprice;
  String date;
  String schoolname;
  String toUserId;

  FavorCommodityData(
      {this.commodityImg,
        this.commoditydescribe,
        this.commodityid,
        this.commodityname,
        this.commodityprice,
        this.date,
        this.schoolname,
      this.toUserId});

  FavorCommodityData.fromJson(Map<String, dynamic> json) {
    commodityImg = json['commodityImg'];
    commoditydescribe = json['commoditydescribe'];
    commodityid = json['commodityid'];
    commodityname = json['commodityname'];
    commodityprice = json['commodityprice'];
    date = json['date'];
    schoolname =json['schoolname'];
    toUserId = json['toUserId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commodityImg'] = this.commodityImg;
    data['commoditydescribe'] = this.commoditydescribe;
    data['commodityid'] = this.commodityid;
    data['commodityname'] = this.commodityname;
    data['commodityprice'] = this.commodityprice;
    data['date'] = this.date;
    data['schoolname'] = this.schoolname;
    data['toUserId'] = this.toUserId;
    return data;
  }
}