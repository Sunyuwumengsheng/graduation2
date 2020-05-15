import 'package:flutter/material.dart';
import 'package:graduation/entitys/entitys.dart';
import 'package:graduation/pages/childeHomepage/utils.dart';
import 'package:provider/provider.dart';

class StartPage extends StatefulWidget {
  String userId;

  StartPage({this.userId});

  @override
  State<StatefulWidget> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _currentIndex = 0;
  String userId;
  List<Widget> page = [
    HomePage(),
    FavoriteItemPage(),
    ReleaseInitPage(),
    PersonInfoPage()
  ];

  _StartPageState({this.userId});

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(initialIndex: _currentIndex, length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => CommodityResponsEntitys(),
          )
        ],
        child: Scaffold(
          body: page[_currentIndex],
          bottomNavigationBar: _bottom(),
        ));
  }

  Widget _bottom() {
    return Container(
      height: 56,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey[200], offset: Offset(0, -1))
          ],
          border: Border(top: BorderSide(color: Colors.grey))),
      child: TabBar(
        indicatorWeight: 0.00001,
        tabs: <Widget>[
          _item(
              "首页",
              Icon(
                Icons.home,
                color: _currentIndex == 0 ? Color(0xFF28D8A1) : Colors.grey,
              )),
          _item(
              "收藏",
              Icon(
                Icons.star,
                color: _currentIndex == 1 ? Color(0xFF28D8A1) : Colors.grey,
              )),
          _item(
              "发布",
              Icon(
                Icons.add,
                color: _currentIndex == 2 ? Color(0xFF28D8A1) : Colors.grey,
              )),
          _item(
              "我的",
              Icon(
                Icons.person,
                color: _currentIndex == 3 ? Color(0xFF28D8A1) : Colors.grey,
              )),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        controller: _tabController,
      ),
    );
  }

  Widget _item(String text, Icon icon) {
    return Container(
      padding: EdgeInsets.only(top: 5),
      child: Column(
        children: <Widget>[
          icon,
          Text(
            text,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
