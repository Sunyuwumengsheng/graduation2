
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:graduation/api/apis.dart';
import 'package:graduation/entitys/entitys.dart';
import 'package:graduation/global.dart';
import 'package:graduation/pages/detilaspage/commoditydetials.dart';
import 'package:graduation/utils/utils.dart';
import 'package:graduation/values/valuesutils.dart';
import 'package:graduation/widgets/toast.dart';

class FavoriteItemPage extends StatefulWidget {
  @override
  _FavoriteItemPageState createState() => _FavoriteItemPageState();
}

class _FavoriteItemPageState extends State<FavoriteItemPage > {
  String userId;
  List<FavorCommodityData> _data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
    _data = List();
    getFavorItem();
  }
  void getFavorItem() async {
    FavorCommoditysRequsterEntitys pamars = FavorCommoditysRequsterEntitys(userId: userId);
    FavorCommodityResponsEntitys entitys = await CommodityAPI.getFavorCommodityData(parmas: pamars);
    if(entitys.code==200&&entitys.stutas==1){
     setState(() {
       _data = entitys.data;
     });
    }
  }
  Future<bool> deleteCommodity(String commodityid) async {
    AddCommodityRequsterEntitys pamars = AddCommodityRequsterEntitys(commodityid: commodityid,userId: userId);
    AddCommodityResponseEntitys entitys = await CommodityAPI.deleteCommodityData(parmas: pamars);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                color: Colors.white,
                height: 50,
                child: Center(
                  child: Text('我的收藏',
                    style: TextStyle(fontSize: 18, fontFamily: 'Avenir'),),
                )
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            Expanded(child: Container(color: Colors.grey[100],
              child: _data == null ? Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 3, backgroundColor: Color(0xFF28D8A1),),
                  )
              ) : StaggeredGridView.countBuilder(
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  crossAxisCount: 2,
                  itemCount: _data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        child: _data.length == 0
                            ? Container()
                            : GestureDetector(
                          child: Sing_prod(
                            name: _data[index].commodityname,
                            pictures: _getpictureImg(_data[index].commodityImg),
                          ),
                          onTap: () =>
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetialsCommoditysPage(
                                            data: _data[index],
                                          )
                                  )
                              ),
                          onLongPress: ()=>deleteCommodityDialog(_data[index].commodityid),
                        ),
                      ),
                    );
                  },
                  staggeredTileBuilder: (index) {
                    return StaggeredTile.count(1, index.isEven ? 1.2 : 1.0);
                  }),
            )
            ),
          ],
        ),
      ),),
    );

  }
  String _getpictureImg(String s) {
    return s.split(',')[0];
  }
}

class Sing_prod extends StatelessWidget {
  final name;
  final pictures;
  final price;
  Sing_prod({this.name, this.price, this.pictures});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Card(
      clipBehavior: Clip.antiAlias,
      child: GestureDetector(
        child: GridTile(
          child: ExtendedImage.network(
            pictures,
            fit: BoxFit.cover,
          ),
          footer: Container(
            color: Colors.white70,
            child: ListTile(
              leading: Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}