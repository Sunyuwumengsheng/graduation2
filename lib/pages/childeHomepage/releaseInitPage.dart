import 'package:auto_route/auto_route.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fsuper/fsuper.dart';
import 'package:graduation/api/apis.dart';
import 'package:graduation/entitys/commodity.dart';
import 'package:graduation/entitys/entitys.dart';
import 'package:graduation/global.dart';
import 'package:graduation/pages/detilaspage/commoditydetials.dart';
import 'package:graduation/routes/router.gr.dart';
import 'package:graduation/utils/storage.dart';
import 'package:graduation/values/valuesutils.dart';
import 'package:graduation/widgets/widgetUtils.dart';

class ReleaseInitPage extends StatefulWidget {
  @override
  _ReleaseInitPageState createState() => _ReleaseInitPageState();
}

class _ReleaseInitPageState extends State<ReleaseInitPage> {
  String userId;
  List<CommodityData> _data;
  Map<String, dynamic> _map;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
    _getPersonReleaCommoditys();
  }

  _getPersonReleaCommoditys() async {
    _map = StorageUtil().getJSON(STORAGE_USER_PROFILE_KEY);

    print(_map['data']['userID']);
    CommoditysRequsterEntitys entitys =
        CommoditysRequsterEntitys(userId: _map['data']['userID']);
    CommodityResponsEntitys cre =
        await CommodityAPI.getPersonCommodity(parmas: entitys);
    if (cre.code == 200 && cre.stutas == 1) {
      _data = List();
      setState(() {
        _data = cre.data;
      });
    }
  }
  Future<bool> deleteCommodity(String commodityid) async {
    AddCommodityRequsterEntitys pamars = AddCommodityRequsterEntitys(commodityid: commodityid,userId: userId);
    AddCommodityResponseEntitys entitys = await CommodityAPI.deleteFavorCommodityData(parmas: pamars);
    if(entitys.code==200){
      toastInfo(msg: entitys.msg);
      for(int i=0;i<_data.length;i++){
        if(commodityid==_data[i].commodityid){
          setState(() {
            _data.removeAt(i);
          });
          break;
        }
      }
      return true;
    }
  }
  getUserId(){
    if(Global.userId==null){
      UserResponseEntity profile = UserResponseEntity();
      // 读取离线用户信息
      var _profileJSON = StorageUtil().getJSON(STORAGE_USER_PROFILE_KEY);
      if (_profileJSON != null) {
        profile = UserResponseEntity.fromJson(_profileJSON);
        userId = profile.data.userID;
      }
    }else{
      userId = Global.userId;
    }

  }
  deleteCommodityDialog(String commodityid){
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Center(
                        child: Text("是否删除"),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        bool s = await deleteCommodity(commodityid);
                        if (s==true){
                          Navigator.pop(context);
                        }

                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey,
                                  style: BorderStyle.solid,
                                  width: 1,
                                ),
                                top: BorderSide(
                                  color: Colors.grey,
                                  style: BorderStyle.solid,
                                  width: 1,
                                ))),
                        child: Center(
                          child: Text("删除"),
                        ),
                      ),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey,
                                style: BorderStyle.solid,
                                width: 1,
                              ),
                            )),
                        child: Center(
                          child: Text("取消"),
                        ),
                      ),
                    ),
                    flex: 1,
                  ),

                ],
              ),
            ),
          );
        });
  }

  String _getpictureImg(String s) {
    return s.split(',')[0];
  }

  Widget isshowMsg() {
    return _data==null?Container(
      child: CircularProgressIndicator(
        strokeWidth: 2,
      ),
    ):_data.length == 0
        ? Container(
            width: MediaQuery.of(context).size.width,
            child: Text('未上传商品'),
          )
        : ListView.builder(
            itemBuilder: (context, indext) {
              return GestureDetector(
                
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetialsCommoditysPage(
                          data: _data[indext],
                        )
                    )
                ),
                onLongPress: ()=>deleteCommodityDialog(_data[indext].commodityid),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black12)),
                      color: Colors.white),
                  height: 150,
                  child: Center(
                    child: Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            height: 140,
                            decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(color: Colors.grey[100]))),
                            child: ExtendedImage.network(
                                _getpictureImg(_data[indext].commodityImg)),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            height: 140,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 5,
                                ),
                                Expanded(
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        _data[indext].commodityname,
                                        textAlign: TextAlign.left,
                                      ),
                                    )),
                                SizedBox(
                                  height: 5,
                                ),
                                Expanded(
                                    child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(_data[indext]
                                            .commodityprice
                                            .toString()))),
                                SizedBox(
                                  height: 5,
                                ),
                                Expanded(
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(_data[indext].commoditydescribe),
                                    )),
                                SizedBox(
                                  height: 5,
                                ),
                                Expanded(
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(_data[indext].date),
                                    )),

//                                          Text(formatDate(DateTime.parse(_data[indext].date),  [yyyy, '-', mm, '-', dd]))
                              ],
                            ),
                          ),
                          flex: 3,
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 140,
                            alignment: const Alignment(0, 1),
                            child: Center(
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: _data.length,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                color: Colors.white,
                height: 50,
                child:FSuper(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child1: Text('我的发布',style: TextStyle(fontFamily: 'Avenir',fontSize: 18),),
                  child1Alignment: Alignment.center,
                  child2: Text('上传',style: TextStyle(fontFamily: 'Avenir',fontSize: 18),),
                  child2Alignment: Alignment.centerRight,
                  child2Margin: EdgeInsets.only(right: 15),
                  onChild2Click: () async{
                    var pd = await ExtendedNavigator.rootNavigator.pushNamed(Routes.updatecommodityPage);
                    if (pd=="1"){
                      _getPersonReleaCommoditys();
                    }
                },
                )
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            Expanded(
              child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: _data == null ? Container() : isshowMsg()),
            )
          ],
        ),
      )),
    );
  }
}
