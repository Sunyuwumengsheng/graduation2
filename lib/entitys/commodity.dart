import 'package:flutter/foundation.dart';
import 'package:graduation/entitys/user.dart';
import 'package:graduation/utils/storage.dart';
import 'package:graduation/values/storage.dart';

class CommoditysRequsterEntitys{
  String userId;
  CommoditysRequsterEntitys({
    @required this.userId});
  factory CommoditysRequsterEntitys.fromJson(Map<String, dynamic> json)=>
      CommoditysRequsterEntitys(userId: json['userId']);
  Map<String, dynamic> toJson() => {
    "userId": userId,
  };
}

class CommodityResponsEntitys with ChangeNotifier {
  int code;
  List<CommodityData> data;
  List<CommodityData> schoolData = List();
  String msg;
  int stutas;
  String scname;

  CommodityResponsEntitys({this.code, this.data, this.msg, this.stutas}){
    _getSchoolName();
  }

  CommodityResponsEntitys.fromJson(Map<String, dynamic> json) {
    code = json['code,'];
    if (json['data'] != null) {
      data = new List<CommodityData>();
      json['data'].forEach((v) {
        data.add(new CommodityData.fromJson(v));
      });
    }
    msg = json['msg'];
    stutas = json['stutas'];
  }
  void updataCommodity(Map<String, dynamic> json){
    code = json['code,'];
    if (json['data'] != null) {
      data = new List<CommodityData>();
      json['data'].forEach((v) {
        data.add(new CommodityData.fromJson(v));
      });
    }
    msg = json['msg'];
    stutas = json['stutas'];
    notifyListeners();
  }
  void upschoolData(){
    schoolData.clear();
    for(CommodityData d in data){
      if (d.schoolname==scname){
        schoolData.add(d);
      }
    }
    notifyListeners();
  }
  _getSchoolName(){
    UserResponseEntity profile = UserResponseEntity();
    // 读取离线用户信息
    var _profileJSON = StorageUtil().getJSON(STORAGE_USER_PROFILE_KEY);
    if (_profileJSON != null) {
      profile = UserResponseEntity.fromJson(_profileJSON);
      scname = profile.data.shcoolName;
    }
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


class CommodityData {
  String commodityImg;
  String commoditydescribe;
  String commodityid;
  String commodityname;
  int commodityprice;
  String date;
  String schoolname;
  String toUserId;

  CommodityData(
      {this.commodityImg,
        this.commoditydescribe,
        this.commodityid,
        this.commodityname,
        this.commodityprice,
        this.date,
      this.schoolname,
      this.toUserId});

  CommodityData.fromJson(Map<String, dynamic> json) {
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