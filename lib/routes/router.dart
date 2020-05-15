import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter/material.dart';
import 'package:graduation/pages/Indexpage.dart';
import 'package:graduation/pages/chatPage/chatpage.dart';
import 'package:graduation/pages/childeHomepage/utils.dart';
import 'package:graduation/pages/detilaspage/commoditydetials.dart';
import 'package:graduation/pages/homepage/start_page.dart';
import 'package:graduation/pages/loginAndregister/sgin_up.dart';
import 'package:graduation/pages/loginAndregister/sign_in.dart';
import 'package:graduation/pages/updataCommotityPage/updataComnitypage.dart';


Widget zoomInTransition(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  // you get an animation object and a widget
  // make your own transition
  return ScaleTransition(scale: animation, child: child);
}
@MaterialAutoRouter(generateNavigationHelperExtension: true)
class $AppRouter{
  @initial
  IndexPage indexPageRoute;

  Sign_inPage sign_inPage;

  Sign_UpPage sign_upPage;

  StartPage startPage;

  DetialsCommoditysPage detialsCommoditysPage;

  UpdatecommodityPage updatecommodityPage;

  PersonInfoPage personInfoPage;

  ChatPage chatPage;

}