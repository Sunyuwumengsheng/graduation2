import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fsuper/fsuper.dart';
import 'package:graduation/api/apis.dart';
import 'package:graduation/entitys/entitys.dart';
import 'package:graduation/global.dart';
import 'package:graduation/routes/router.gr.dart';
import 'package:graduation/utils/screen.dart';
import 'package:graduation/widgets/toast.dart';

class Sign_inPage extends StatefulWidget {
  @override
  _Sign_inPageState createState() => _Sign_inPageState();
}

class _Sign_inPageState extends State<Sign_inPage> {
  bool _rememberMe = false;
  TextEditingController _userController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Widget _lableTitle() {
    return FSuper(
      width: duSetWidth(640),
      height: duSetHeight(191),
      child1: FSuper(
        spans: [
          TextSpan(text: '登', style: TextStyle(fontSize: duSetFontSize(140))),
          TextSpan(
              text: '录',
              style: TextStyle(
                  fontSize: duSetFontSize(140), color: Color(0xFF28D8A1)))
        ],
      ),
      child1Alignment: Alignment.center,
    );
  }

  Widget _userNameWidget() {
    return Container(
      height: duSetHeight(132),
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[100]),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.person),
          SizedBox(
            width: duSetWidth(10),
          ),
          SizedBox(
            width: duSetWidth(850),
            child: TextField(
              controller: _userController,
              keyboardType: TextInputType.number,
              decoration:
                  InputDecoration(border: InputBorder.none, hintText: '请输入账号'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _passwordWidget() {
    return Container(
      height: duSetHeight(132),
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[100]),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.lock),
          SizedBox(
            width: duSetWidth(10),
          ),
          SizedBox(
              width: duSetWidth(850),
              child: TextField(
                controller: _passwordController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: '请输入密码'),
              )),
        ],
      ),
    );
  }

  Widget _rememberAndForgetPassWord() {
    return FSuper(
      width: duSetWidth(963),
      height: duSetHeight(65),
      child1: FSuper(
        height: duSetHeight(65),
        width: duSetWidth(447),
        child1: Theme(
          data: ThemeData(unselectedWidgetColor: Color(0xFF28D8A1)),
          child: Checkbox(
            value: _rememberMe,
            checkColor: Colors.green,
            activeColor: Colors.white,
            onChanged: (value) {
              setState(() {
                _rememberMe = value;
              });
            },
          ),
        ),
        child1Alignment: Alignment.centerLeft,
        child2: Text(
          '记住密码',
          style: TextStyle(fontSize: duSetFontSize(50), fontFamily: 'Avenir'),
        ),
        child2Margin: EdgeInsets.only(left: duSetWidth(3.6)),
        child2Alignment: Alignment.center,
      ),
      child1Alignment: Alignment.centerLeft,
      child2: Text(
        '',
        style: TextStyle(fontSize: duSetFontSize(50), fontFamily: 'Avenir'),
      ),
      child2Alignment: Alignment.centerRight,
      child2Margin: EdgeInsets.only(left: duSetWidth(3.6)),
    );
  }

  Widget _loginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => _signindata(),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Color(0xFF28D8A1),
        child: Text(
          '登录',
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

// 跳转 注册界面
  _handleNavSignUp() {
    ExtendedNavigator.rootNavigator.pushNamed(Routes.sign_upPage);
  }

  Widget _buildSignInWithText() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '- OR -',
          style: TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 20.0),
        GestureDetector(
          onTap: () => _handleNavSignUp(),
          child: Text(
            '去注册',
            style: TextStyle(
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  _signindata() async {
    if (_userController.value.text.toString() == null) {
      toastInfo(msg: '账号不能为空');
      return;
    }
    if (_passwordController.value.text.toString() == null) {
      toastInfo(msg: '密码不能为空');
      return;
    }
    UserRequestEntity entity = UserRequestEntity(
      userId: _userController.value.text.toString(),
      password: _passwordController.value.text.toString(),
    );
    UserResponseEntity ers = await UserAPI.login(params: entity);
    if (ers.code == 200) {
      Global.saveProfile(ers);
      ExtendedNavigator.rootNavigator.pushNamedAndRemoveUntil(
          Routes.startPage, (Route<dynamic> route) => false,
          arguments: StartPageArguments(
              userId: _userController.value.text.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
//            height: duSetHeight(1217),
            width: duSetWidth(964),
//          color: Colors.red,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _lableTitle(),
                  SizedBox(
                    height: duSetHeight(150),
                  ),
                  _userNameWidget(),
                  SizedBox(
                    height: duSetHeight(80),
                  ),
                  _passwordWidget(),
                  SizedBox(
                    height: duSetHeight(80),
                  ),
                  _rememberAndForgetPassWord(),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    height: 1.0,
                    indent: 0,
                    color: Colors.grey[200],
                  ),
                  SizedBox(
                    height: duSetHeight(80),
                  ),
                  _loginBtn(),
                  SizedBox(
                    height: duSetHeight(50),
                  ),
                  _buildSignInWithText()
                ],
              ),
            ),
          ),
        ));
  }
}
