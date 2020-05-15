import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class UploadCommodityInfo {
  String userId;
  List<MultipartFile> commodityImg;
  String commoditydescribe;
  String commodityname;
  String commodityprice;
  String schoolname;

  UploadCommodityInfo(
      {@required this.userId,
      @required this.commodityImg,
      @required this.commoditydescribe,
      @required this.commodityname,
      @required this.commodityprice,
      @required this.schoolname});

  UploadCommodityInfo.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    commodityImg = json['commodityImg'];
    commoditydescribe = json['commoditydescribe'];
    commodityname = json['commodityname'];
    commodityprice = json['commodityprice'];
    schoolname=json[schoolname];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['commodityImg'] = this.commodityImg;
    data['commoditydescribe'] = this.commoditydescribe;
    data['commodityname'] = this.commodityname;
    data['commodityprice'] = this.commodityprice;
    data['schoolname'] = this.schoolname;
    return data;
  }
}

class UploadCommodityInfoResponse {
  int code;
  String msg;
  String data;
  UploadCommodityInfoResponse({this.code, this.msg, this.data});

  UploadCommodityInfoResponse.fromJson(Map<String, dynamic> json) {
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
