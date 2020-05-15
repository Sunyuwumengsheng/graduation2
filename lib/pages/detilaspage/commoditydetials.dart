import 'package:auto_route/auto_route.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fsuper/fsuper.dart';
import 'package:graduation/api/apis.dart';
import 'package:graduation/entitys/addcomodity.dart';
import 'package:graduation/entitys/entitys.dart';
import 'package:graduation/global.dart';
import 'package:graduation/routes/router.gr.dart';
import 'package:graduation/utils/utils.dart';
import 'package:graduation/values/valuesutils.dart';
import 'package:graduation/widgets/toast.dart';

class DetialsCommoditysPage extends StatefulWidget {
  dynamic data;
  List<String> img = List();

  DetialsCommoditysPage({this.data}) {
    this.img = data.commodityImg.split(',');
    print(data.commodityprice.toString());
  }

  @override
  _DetialsCommoditysPageState createState() => _DetialsCommoditysPageState();
}

class _DetialsCommoditysPageState extends State<DetialsCommoditysPage> {
  String userId;
  String _headImg;
  addComodity() async{
    AddCommodityRequsterEntitys parmas  = AddCommodityRequsterEntitys(commodityid: widget.data.commodityid,userId: Global.userId==null?getUserId():Global.userId);
    AddCommodityResponseEntitys entitys = await CommodityAPI.addCommodityData(parmas: parmas);
    if(entitys.code==200){
      toastInfo(msg: entitys.msg);
    }else{
      toastInfo(msg: entitys.msg);
    }

  }

  getUserId(){
    UserResponseEntity profile = UserResponseEntity();
    // 读取离线用户信息
    var _profileJSON = StorageUtil().getJSON(STORAGE_USER_PROFILE_KEY);
    if (_profileJSON != null) {
      profile = UserResponseEntity.fromJson(_profileJSON);
      userId = profile.data.userID;
      _headImg = profile.data.headImg;
      print(userId);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            FSuper(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child1: GestureDetector(
                child: Icon(
                  Icons.arrow_back_ios,
                ),
                onTap: ()=>Navigator.pop(context),
              ),
              child1Alignment: Alignment.centerLeft,
              child1Margin: EdgeInsets.only(left: 10),
              child2: Text('商品详情',style: TextStyle(fontSize: 18),),
              child2Alignment: Alignment.center,
              child2Margin: EdgeInsets.only(right: 15),
            ),
            FSuper(
                height: 400,
                width: MediaQuery.of(context).size.width,
                backgroundColor: Colors.white,
                child1: widget.img.length == 0
                    ? Container()
                    : Swiper(
                        itemCount: widget.img.length,
                        itemBuilder: (context, index) {
                          return ExtendedImage.network(
                            widget.img[index],
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                child1Margin: EdgeInsets.only(left: 10, right: 10)),
            Expanded(
                child: Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  Expanded(
                      flex: 2,
                      child: Container(
                        height: double.infinity,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.grey[100]))),
                        child: Row(
                          children: <Widget>[
                            Text('价格：'),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.data.commodityprice.toString(),
                              style: TextStyle(color: Colors.red, fontSize: 18),
                            )
                          ],
                        ),
                      )),
                  Expanded(
                      flex: 2,
                      child: Container(
                        height: double.infinity,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.grey[100]))),
                        child: Row(
                          children: <Widget>[
                            Text('名称：'),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.data.commodityname,
                            )
                          ],
                        ),
                      )),
                  Expanded(
                      flex: 4,
                      child: Container(
                        padding: EdgeInsets.only(top: 15),
                        height: double.infinity,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.grey[100]))),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('描述：'),
                            SizedBox(
                              width: 10,
                            ),
                            Text(widget.data.commoditydescribe)
                          ],
                        ),
                      )),
                  Expanded(
                      flex: 2,
                      child: Container(
                        height: double.infinity,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.grey[100]))),
                        child: Row(
                          children: <Widget>[
                            Text('地址：'),
                            SizedBox(
                              width: 10,
                            ),
                            Text(widget.data.schoolname)
                          ],
                        ),
                      )),
                  Expanded(
                      flex: 3,
                      child: Container(
                          height: double.infinity,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey[100]))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.star_border),
                                color: Colors.grey,
                                onPressed: ()=>addComodity(),
                              ),
                              FSuper(
                                height: 50,
                                width: 20,
                                child1: IconButton(
                                  icon: Icon(Icons.message),
                                  color: Colors.grey,
                                  onPressed: ()=>ExtendedNavigator.rootNavigator.pushChatPage(userId: userId,to_userId: widget.data.toUserId,headImg: _headImg),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                child: Container(
                                  color: Colors.yellow,
                                  width: 80,
                                  child: Center(
                                    child: Text('购买'),
                                  ),
                                ),
                              )
                            ],
                          ))),
                ],
              ),
            )),
          ],
        ),
      )),
    );
  }
}
