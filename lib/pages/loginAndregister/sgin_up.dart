import 'package:flutter/material.dart';
import 'package:fsuper/fsuper.dart';
import 'package:graduation/api/apis.dart';
import 'package:graduation/entitys/entitys.dart';
import 'package:graduation/utils/utils.dart';
import 'package:graduation/widgets/toast.dart';

class Sign_UpPage extends StatefulWidget {
  @override
  _Sign_UpPageState createState() => _Sign_UpPageState();
}

class _Sign_UpPageState extends State<Sign_UpPage> {
  TextEditingController _userController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _schoolNameController = TextEditingController();

  Widget _lableTitle() {
    return FSuper(
      width: duSetWidth(640),
      height: duSetHeight(191),
      child1: FSuper(
        spans: [
          TextSpan(text: '注', style: TextStyle(fontSize: duSetFontSize(140))),
          TextSpan(
              text: '册',
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
          SizedBox(width: duSetWidth(10),),
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

  Widget _schoolName() {
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
          Icon(Icons.school),
          SizedBox(
            width: duSetWidth(10),
          ),
          SizedBox(
              width: duSetWidth(850),
              child: TextField(
                controller: _schoolNameController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: '请输入学校'),
              )),
        ],
      ),
    );
  }

  Widget _registerBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => _toregister(),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Color(0xFF28D8A1),
        child: Text(
          '注册',
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
          onTap: () => Navigator.pop(context),
          child: Text(
            '去登录',
            style: TextStyle(
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  _toregister() async {
    if (_userController.value.text.toString() == null) {
      toastInfo(msg: '账号不能为空');
      return;
    }
    if (_passwordController.value.text.toString() == null) {
      toastInfo(msg: '密码不能为空');
      return;
    }
    if (_schoolNameController.value.text.toString() == null) {
      toastInfo(msg: '学校不能为空');
      return;
    }
    RegisterRequestEntity entity = RegisterRequestEntity(
        userId: _userController.value.text.toString(),
        password: _passwordController.value.text.toString(),
        shcoolName: _schoolNameController.value.text.toString());
    RegisterResponseEntity ers = await UserAPI.register(entity);
    if (ers.code == 200) {
      Navigator.pop(context);
    } else {
      toastInfo(msg: '账号已存在');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: duSetWidth(964),
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
//                _schoolName(),
//                SizedBox(
//                  height: duSetHeight(80),
//                ),
                _registerBtn(),
                SizedBox(
                  height: duSetHeight(50),
                ),
                _buildSignInWithText()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
