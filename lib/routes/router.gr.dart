// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:graduation/pages/Indexpage.dart';
import 'package:graduation/pages/loginAndregister/sign_in.dart';
import 'package:graduation/pages/loginAndregister/sgin_up.dart';
import 'package:graduation/pages/homepage/start_page.dart';
import 'package:graduation/pages/detilaspage/commoditydetials.dart';
import 'package:graduation/pages/updataCommotityPage/updataComnitypage.dart';
import 'package:graduation/pages/childeHomepage/person_info.dart';
import 'package:graduation/pages/chatPage/chatpage.dart';

abstract class Routes {
  static const indexPageRoute = '/';
  static const sign_inPage = '/sign_in-page';
  static const sign_upPage = '/sign_up-page';
  static const startPage = '/start-page';
  static const detialsCommoditysPage = '/detials-commoditys-page';
  static const updatecommodityPage = '/updatecommodity-page';
  static const personInfoPage = '/person-info-page';
  static const chatPage = '/chat-page';
}

class AppRouter extends RouterBase {
  //This will probably be removed in future versions
  //you should call ExtendedNavigator.ofRouter<Router>() directly
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<AppRouter>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.indexPageRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => IndexPage(),
          settings: settings,
        );
      case Routes.sign_inPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => Sign_inPage(),
          settings: settings,
        );
      case Routes.sign_upPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => Sign_UpPage(),
          settings: settings,
        );
      case Routes.startPage:
        if (hasInvalidArgs<StartPageArguments>(args)) {
          return misTypedArgsRoute<StartPageArguments>(args);
        }
        final typedArgs = args as StartPageArguments ?? StartPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => StartPage(userId: typedArgs.userId),
          settings: settings,
        );
      case Routes.detialsCommoditysPage:
        if (hasInvalidArgs<DetialsCommoditysPageArguments>(args)) {
          return misTypedArgsRoute<DetialsCommoditysPageArguments>(args);
        }
        final typedArgs = args as DetialsCommoditysPageArguments ??
            DetialsCommoditysPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => DetialsCommoditysPage(data: typedArgs.data),
          settings: settings,
        );
      case Routes.updatecommodityPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => UpdatecommodityPage(),
          settings: settings,
        );
      case Routes.personInfoPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => PersonInfoPage(),
          settings: settings,
        );
      case Routes.chatPage:
        if (hasInvalidArgs<ChatPageArguments>(args)) {
          return misTypedArgsRoute<ChatPageArguments>(args);
        }
        final typedArgs = args as ChatPageArguments ?? ChatPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => ChatPage(
              userId: typedArgs.userId,
              to_userId: typedArgs.to_userId,
              headImg: typedArgs.headImg),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

//**************************************************************************
// Arguments holder classes
//***************************************************************************

//StartPage arguments holder class
class StartPageArguments {
  final String userId;
  StartPageArguments({this.userId});
}

//DetialsCommoditysPage arguments holder class
class DetialsCommoditysPageArguments {
  final dynamic data;
  DetialsCommoditysPageArguments({this.data});
}

//ChatPage arguments holder class
class ChatPageArguments {
  final String userId;
  final String to_userId;
  final String headImg;
  ChatPageArguments({this.userId, this.to_userId, this.headImg});
}

//**************************************************************************
// Navigation helper methods extension
//***************************************************************************

extension AppRouterNavigationHelperMethods on ExtendedNavigatorState {
  Future pushIndexPageRoute() => pushNamed(Routes.indexPageRoute);
  Future pushSign_inPage() => pushNamed(Routes.sign_inPage);
  Future pushSign_upPage() => pushNamed(Routes.sign_upPage);
  Future pushStartPage({
    String userId,
  }) =>
      pushNamed(Routes.startPage,
          arguments: StartPageArguments(userId: userId));
  Future pushDetialsCommoditysPage({
    dynamic data,
  }) =>
      pushNamed(Routes.detialsCommoditysPage,
          arguments: DetialsCommoditysPageArguments(data: data));
  Future pushUpdatecommodityPage() => pushNamed(Routes.updatecommodityPage);
  Future pushPersonInfoPage() => pushNamed(Routes.personInfoPage);
  Future pushChatPage({
    String userId,
    String to_userId,
    String headImg,
  }) =>
      pushNamed(Routes.chatPage,
          arguments: ChatPageArguments(
              userId: userId, to_userId: to_userId, headImg: headImg));
}
