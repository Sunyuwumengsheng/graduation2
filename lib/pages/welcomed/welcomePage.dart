import 'package:auto_route/auto_route.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fsuper/fsuper.dart';
import 'package:graduation/routes/router.gr.dart';
import 'package:graduation/utils/screen.dart';
import 'package:graduation/utils/utils.dart';
import 'package:graduation/values/valuesutils.dart';

class WelcomePage extends StatelessWidget {
  Widget _lableTitle() {
    return FSuper(
      width: duSetWidth(640.6),
      height: duSetHeight(191),
      child1: FSuper(
        spans: [
          TextSpan(
              text: '欢迎来到校易', style: TextStyle(fontSize: duSetFontSize(100))),
//          TextSpan(
//              text: '录',
//              style: TextStyle(
//                  fontSize: duSetFontSize(140), color: Color(0xFF28D8A1)))
        ],
      ),
      child1Alignment: Alignment.center,
    );
  }

  Widget _toLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: duSetWidth(400),
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          StorageUtil().setBool(STORAGE_DEVICE_ALREADY_OPEN_KEY, true);
          ExtendedNavigator.rootNavigator.pushNamedAndRemoveUntil(
              Routes.sign_inPage, (Route<dynamic> route) => false);
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Color(0xFF28D8A1),
        child: Text(
          '开始使用',
          style: TextStyle(
            color: Colors.white,
//          color: Colors.grey,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: duSetWidth(1046.0),
          height: duSetHeight(1446.8),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: duSetWidth(765.46),
                height: duSetHeight(549),
                child: ExtendedImage.asset(
                  'assets/images/Slice.png',
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: duSetHeight(65),
              ),
              _lableTitle(),
              Spacer(),
              _toLoginBtn()
            ],
          ),
        ),
      ),
    );
  }
}
