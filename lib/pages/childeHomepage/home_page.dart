import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation/api/apis.dart';
import 'package:graduation/entitys/entitys.dart';
import 'package:graduation/pages/childeHomepage/childePages/utils.dart';
import 'package:graduation/routes/router.gr.dart';
import 'package:graduation/utils/screen.dart';
import 'package:graduation/utils/storage.dart';
import 'package:graduation/values/storage.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  String userId;

  HomePage({this.userId});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool issearch = false;
  bool canindex = true;
  TabController _topTabController;
  int _tabCurrentIndex = 0;
  TextEditingController controller = TextEditingController();
  List<Widget> _list = [
    AllSchoolPage(),
    MySchoolNamePage(),
  ];
  String schoolName;

  @override
  void initState() {
    super.initState();
    _getSchoolName();
    _topTabController =
        TabController(initialIndex: _tabCurrentIndex, length: 2, vsync: this);
  }

  _getAllcommoditys() async {
    Map<String, dynamic> map = {'commodityname': controller.value.text.toString()};
    CommodityResponsEntitys crt =
    await CommodityAPI.getSelectCommoditys(parmas: map);
    if (crt.code == 200) {
      controller.clear();
      Provider.of<CommodityResponsEntitys>(context, listen: false)
        ..updataCommodity(crt.toJson())
        ..upschoolData();
    }
  }

  _getSchoolName() {
    UserResponseEntity profile = UserResponseEntity();
    // 读取离线用户信息
    var _profileJSON = StorageUtil().getJSON(STORAGE_USER_PROFILE_KEY);
    if (_profileJSON != null) {
      profile = UserResponseEntity.fromJson(_profileJSON);
      schoolName = profile.data.shcoolName;
    }
  }

  Widget _searchWIdget() {
    return Container(
      height: 40,
      width: duSetWidth(700),
      padding: EdgeInsets.only(left: 50, right: 50),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.grey[300])),
      child: Center(
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: TextField(
                  controller: controller,
                  maxLength: 10,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      counterText: '',
                      contentPadding: EdgeInsets.only(bottom: 5)),
                  onSubmitted:(text){
                    print(text);
                    _getAllcommoditys();
                  },
                ))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Color(0xFF28D8A1),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 60,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.person),
                          onPressed: () =>
                              ExtendedNavigator.rootNavigator
                                  .pushNamed(Routes.personInfoPage)),
                      Spacer(),
                      Offstage(
                        offstage: issearch,
                        child: Text('首页'),
                      ),
                      Offstage(
                        offstage: !issearch,
                        child: _searchWIdget(),
                      ),
                      Spacer(),
                      IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            if (canindex == true) {
                              setState(() {
                                issearch = true;
                                canindex = false;
                              });
                            } else {
                              setState(() {
                                issearch = false;
                                canindex = true;
                              });
                            }
                          })
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                  color: Colors.grey,
                ),
                Container(
                  color: Colors.white,
                  child: TabBar(
                    indicatorWeight: 0.00001,
                    tabs: <Widget>[
                      Tab(
                        text: '全部',
                      ),
                      Tab(
                        text: '本校',
                      ),
                    ],
                    controller: _topTabController,
                    onTap: (index) {
                      setState(() {
                        _tabCurrentIndex = index;
                      });
                    },
                  ),
                ),
                Expanded(
                    child: Container(
                      color: Colors.grey[200],
                      child: _list[_tabCurrentIndex],
                    ))
              ],
            ),
          )),
    );
  }
}
