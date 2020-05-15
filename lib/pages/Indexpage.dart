import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:graduation/global.dart';
import 'package:graduation/pages/loginAndregister/sign_in.dart';
import 'package:graduation/pages/welcomed/welcomePage.dart';

import 'homepage/start_page.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 1125, height: 2436, allowFontScaling: true);
    return Scaffold(
        body: Global.isFirstOpen == true?WelcomePage():Global.isOfflineLogin == true ? StartPage() : Sign_inPage()
    );
  }
}