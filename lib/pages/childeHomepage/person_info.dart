import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fsuper/fsuper.dart';
import 'package:graduation/api/apis.dart';
import 'package:graduation/entitys/entitys.dart';
import 'package:graduation/entitys/user.dart';
import 'package:graduation/global.dart';
import 'package:graduation/pages/updataCommotityPage/updataComnitypage.dart';
import 'package:graduation/routes/router.gr.dart';
import 'package:graduation/utils/utils.dart';
import 'package:graduation/values/valuesutils.dart';
import 'package:graduation/widgets/toast.dart';

class PersonInfoPage extends StatefulWidget {
  @override
  _PersonInfoPageState createState() => _PersonInfoPageState();
}

class _PersonInfoPageState extends State<PersonInfoPage> {
  bool initialized = false;
  UserResponseEntity _responseEntity;
  String _nickname, _gender, _schoolName, _userId, _headImg;
  bool isCanModigy = false;
  File _image;
  Map<String, dynamic> _map;

  //昵称
  Widget _nicknameWidget() {
    return GestureDetector(
      onTap: () async {
        if (isCanModigy == true) {
          String name = await _getModify(context);
          if (name != null) {
            setState(() {
              _nickname = name;
            });
          }
        }
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
                color: Colors.grey, style: BorderStyle.solid, width: 1),
          ),
        ),
        child: Row(
          children: <Widget>[
            Icon(Icons.person),
            SizedBox(
              width: 10,
            ),
            Text('呢称: '),
            SizedBox(
              width: 10,
            ),
            Text(_nickname == null ? '成果我老婆' : _nickname)
          ],
        ),
      ),
    );
  }

  //性别
  Widget _genderWidget() {
    return GestureDetector(
      onTap: () async {
        if (isCanModigy == true) {
          String gender = await _getModifyGender(context);
          if (gender != null) {
            setState(() {
              _gender = gender;
            });
          }
        }
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
                color: Colors.grey, style: BorderStyle.solid, width: 1),
          ),
        ),
        child: Row(
          children: <Widget>[
            Icon(Icons.accessibility),
            SizedBox(
              width: 10,
            ),
            Text('性别: '),
            SizedBox(
              width: 10,
            ),
            Text(_gender == null ? '未知' : _gender)
          ],
        ),
      ),
    );
  }

  //学校
  Widget _schoolNameWidget() {
    return GestureDetector(
      onTap: () async {
        if (isCanModigy == true) {
          String schoolname = await _getModify(context);
          if (schoolname != null) {
            setState(() {
              _schoolName = schoolname;
            });
          }
        }
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
                color: Colors.grey, style: BorderStyle.solid, width: 1),
          ),
        ),
        child: Row(
          children: <Widget>[
            Icon(Icons.school),
            SizedBox(
              width: 10,
            ),
            Text('学校: '),
            SizedBox(
              width: 10,
            ),
            Text(_schoolName == null ? '未填写' : _schoolName)
          ],
        ),
      ),
    );
  }

  //  //退出登录
  Widget _nameCollectionWidget() {
    return GestureDetector(
      onTap: () {
        _toSignInPage();
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
                color: Colors.grey, style: BorderStyle.solid, width: 1),
          ),
        ),
        child: Row(
          children: <Widget>[
            Icon(Icons.exit_to_app),
            SizedBox(
              width: 10,
            ),
            Text('关闭: '),
            SizedBox(
              width: 10,
            ),
            Text('退出登录')
          ],
        ),
      ),
    );
  }

  //发布
  Widget _voidreleaseinitWidget() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => UpdatecommodityPage()));
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
                color: Colors.grey, style: BorderStyle.solid, width: 1),
          ),
        ),
        child: Row(
          children: <Widget>[
            Icon(Icons.file_upload),
            SizedBox(
              width: 10,
            ),
            Text('发布: '),
            SizedBox(
              width: 10,
            ),
            Text('发布商品')
          ],
        ),
      ),
    );
  }

  Future<String> _getModify(BuildContext context) {
    TextEditingController controller = new TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("请输入修改内容"),
            content: TextField(
              controller: controller,
            ),
            actions: <Widget>[
              MaterialButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  '取消',
                  textAlign: TextAlign.right,
                ),
              ),
              MaterialButton(
                elevation: 5.0,
                onPressed: () => {
                  print(controller.text.toString()),
                  Navigator.of(context).pop(controller.text.toString()),
                },
                child: Text(
                  '修改',
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          );
        });
  }

  Future<String> _getModifyGender(BuildContext context) {
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
                        child: Text("选择性别"),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop('男');
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
                          child: Text("男"),
                        ),
                      ),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop('女');
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
                          child: Text("女"),
                        ),
                      ),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              style: BorderStyle.solid,
                              width: 1,
                            ),
                          ),
                        ),
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

  Future<File> _selectorImage(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text("相机"),
                onTap: () async {
                  File img = await CutImage.cameraImge();

                  if (img != null) {
                    var formimg = await MultipartFile.fromFile(img.path);
                    Map<String, dynamic> map = {
                      'userId': _userId,
                      'headImg': formimg
                    };
                    HeadImgResponseEntity het =
                        await UserAPI.uploadHeadImg(params: map);
                    if (het.code == 200) {
                      StorageUtil().remove(STORAGE_USER_PROFILE_KEY);
                      _responseEntity.data.headImg = het.data;
                      Global.saveProfile(_responseEntity);
                      Navigator.of(context).pop(img);
                    } else {
                      toastInfo(msg: '上传失败，亲重新上传');
                    }
                  }
                },
              ),
              ListTile(
                leading: new Icon(Icons.photo_library),
                title: new Text("相册获取"),
                onTap: () async {
                  File img = await CutImage.pickImage();
                  if (img != null) {
                    var formimg = await MultipartFile.fromFile(img.path);
                    Map<String, dynamic> map = {
                      'userId': _userId,
                      'headImg': formimg
                    };
                    HeadImgResponseEntity het =
                        await UserAPI.uploadHeadImg(params: map);
                    if (het.code == 200) {
                      StorageUtil().remove(STORAGE_USER_PROFILE_KEY);
                      _responseEntity.data.headImg = het.data;
                      Global.saveProfile(_responseEntity);
                      Navigator.of(context).pop(img);
                    } else {
                      toastInfo(msg: '上传失败，亲重新上传');
                    }
                  }
                },
              ),
            ],
          );
        });
  }

  _toSignInPage() {
    StorageUtil().remove(STORAGE_USER_PROFILE_KEY);
    StorageUtil().setLogin('islogin', false);
    ExtendedNavigator.rootNavigator.pushNamedAndRemoveUntil(
        Routes.sign_inPage, (Route<dynamic> route) => false);
  }

  Widget _isImage() {
    if (_image == null) {
      return _headImg == null
          ? ExtendedImage.asset(
              "assets/images/feature-1.png",
              shape: BoxShape.circle,
            )
          : ExtendedImage.network(_headImg, shape: BoxShape.circle);
    } else {
      return ExtendedImage.file(_image, shape: BoxShape.circle);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _map = StorageUtil().getJSON(STORAGE_USER_PROFILE_KEY);
    _responseEntity = UserResponseEntity.fromJson(_map);
    if (_responseEntity != null) {
      _nickname = _responseEntity.data.nickname;
      _schoolName = _responseEntity.data.shcoolName;
      _gender = _responseEntity.data.gender;
      _userId = _responseEntity.data.userID;
      _headImg = _responseEntity.data.headImg;
    }
  }

  _updataInfomsg() async {
    UpdataInfoRequsterEntitys entitys = UpdataInfoRequsterEntitys(
        userId: _userId,
        nickname: _nickname,
        gender: _gender,
        schoolname: _schoolName);
    UpdataInfroResponserEntitys ures =
        await UserAPI.updatainfo(params: entitys);
    if (ures.code == 200) {
      toastInfo(msg: '修改成功');
      StorageUtil().remove(STORAGE_USER_PROFILE_KEY);
      _responseEntity.data.gender = ures.data.gender;
      _responseEntity.data.nickname = ures.data.nickname;
      _responseEntity.data.shcoolName = ures.data.shcoolName;
      Global.saveProfile(_responseEntity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
//      appBar: AppBar(
//        title: Text(
//          "个人信息",
//          style: TextStyle(
//            fontSize: 20,
//          ),
//        ),
//        centerTitle: true,
//        actions: <Widget>[
//          FlatButton(
//            color: Color(0xFF28D8A1),
//            onPressed: () {
//              setState(() {
//                isCanModigy = true;
//              });
//            },
//            child:
//            Text('修改', style: TextStyle(fontSize: 18, color: Colors.white)),
//          )
//        ],
//      ),

        body: SafeArea(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FSuper(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child1: Text(
                      '个人信息',
                      style: TextStyle(fontSize: 18, fontFamily: 'Avenir'),
                    ),
                    child1Alignment: Alignment.center,
                    child2: Text(
                      '修改',
                      style: TextStyle(fontSize: 18, fontFamily: 'Avenir'),
                    ),
                    child2Alignment: Alignment.centerRight,
                    child2Margin: EdgeInsets.only(right: 10),
                    onChild2Click: () {
                      setState(() {
                        isCanModigy = true;
                      });
                    },
                  ),
                  Divider(height: 1,color: Colors.grey,),
                  Expanded(child: Container(
                    color: Colors.grey[100],
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                       Container(
                         height: 200,
                         color: Colors.white,
                         child: Center(
                           child: GestureDetector(
                             onTap: () async {
                               File img = await _selectorImage(context);
                               setState(() {
                                 _image = img;
                               });
                             },
                             child: Center(
                               child: Container(
                                   height: 100, width: 100, child: _isImage()),
                             ),
                           ),
                         )
                       ),
                        SizedBox(
                          height: 20,
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                            color:Colors.white,
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: Center(
                            child: Text(
                              _userId,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                            color:Colors.white,
                          ),
                        ),
                        Expanded(
                          child: Container(
                              color: Colors.white,
                              padding: EdgeInsets.only(left: 20, right: 20),
                              height: double.infinity,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                  _nicknameWidget(),
                                  _genderWidget(),
                                  _schoolNameWidget(),
                                  _voidreleaseinitWidget(),
                                  _nameCollectionWidget(),
                                    SizedBox(
                                      height: 60,
                                    ),
                                    Offstage(
                                        offstage: !isCanModigy,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isCanModigy = false;
                                              _updataInfomsg();
                                            });
                                          },
                                          child: Container(
                                            height: 50,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: Color(0xFF28D8A1),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 6.0,
                                                    offset: Offset(0, 2),
                                                  )
                                                ],
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50))),
                                            child: Center(
                                              child: Text(
                                                "确认修改",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                    fontFamily: "OpenSans"),
                                              ),
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    ),
                  )
                  ),



//                  Container(
//                      decoration: BoxDecoration(color: Colors.white),
//                      child: Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Container(
//                              width: double.infinity,
//                              height: 200,
//                              decoration: BoxDecoration(
//                                borderRadius: BorderRadius.only(
//                                  bottomLeft: Radius.circular(50),
//                                  bottomRight: Radius.circular(50),
//                                ),
//                                color: Color(0xFF28D8A1),
//                              ),
//                              child: Column(
//                                mainAxisAlignment: MainAxisAlignment.center,
//                                crossAxisAlignment: CrossAxisAlignment.start,
//                                children: <Widget>[
//                                  GestureDetector(
//                                    onTap: () async {
//                                      File img = await _selectorImage(context);
//                                      setState(() {
//                                        _image = img;
//                                      });
//                                    },
//                                    child: Center(
//                                      child: Container(
//                                          height: 100, width: 100, child: _isImage()),
//                                    ),
//                                  ),
//                                  SizedBox(
//                                    height: 20,
//                                  ),
//                                  Center(
//                                    child: Text(
//                                      _userId,
//                                      style: TextStyle(
//                                          color: Colors.white, fontSize: 20),
//                                    ),
//                                  )
//                                ],
//                              )),
//                          SizedBox(
//                            height: 20,
//                          ),
//                          Expanded(
//                            child: Container(
//                                padding: EdgeInsets.only(left: 20, right: 20),
//                                height: double.infinity,
//                                child: SingleChildScrollView(
//                                  child: Column(
//                                    mainAxisAlignment: MainAxisAlignment.start,
//                                    children: <Widget>[
////                                _nicknameWidget(),
////                                _genderWidget(),
////                                _schoolNameWidget(),
////                                _voidreleaseinitWidget(),
////                                _nameCollectionWidget(),
//                                      SizedBox(
//                                        height: 60,
//                                      ),
//                                      Offstage(
//                                          offstage: !isCanModigy,
//                                          child: GestureDetector(
//                                            onTap: () {
//                                              setState(() {
//                                                isCanModigy = false;
//                                                _updataInfomsg();
//                                              });
//                                            },
//                                            child: Container(
//                                              height: 50,
//                                              width: double.infinity,
//                                              decoration: BoxDecoration(
//                                                  color: Color(0xFF28D8A1),
//                                                  boxShadow: [
//                                                    BoxShadow(
//                                                      color: Colors.black12,
//                                                      blurRadius: 6.0,
//                                                      offset: Offset(0, 2),
//                                                    )
//                                                  ],
//                                                  borderRadius: BorderRadius.all(
//                                                      Radius.circular(50))),
//                                              child: Center(
//                                                child: Text(
//                                                  "确认修改",
//                                                  style: TextStyle(
//                                                      fontSize: 18,
//                                                      color: Colors.white,
//                                                      fontFamily: "OpenSans"),
//                                                ),
//                                              ),
//                                            ),
//                                          )),
//                                    ],
//                                  ),
//                                )),
//                          ),
//                        ],
//                      )),
                ],
              ),
            )
        ));
  }
}
