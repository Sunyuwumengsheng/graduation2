import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation/api/apis.dart';
import 'package:graduation/entitys/entitys.dart';
import 'package:graduation/utils/utils.dart';
import 'package:graduation/values/valuesutils.dart';
import 'package:graduation/widgets/toast.dart';



class UpdatecommodityPage extends StatefulWidget {
  @override
  _UpdatecommodityPageState createState() => _UpdatecommodityPageState();
}

class _UpdatecommodityPageState extends State<UpdatecommodityPage> {
  TextEditingController controller = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  String _userId;
  String _schoolname;
  String pd;
  SvgPicture addImg = SvgPicture.asset(
    "assets/svgs/add.svg",
    color: Colors.grey,
    width: 70,
    height: 70,
  );
  List<File> files;
  List<MultipartFile> mufiles = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    file.add(Image.asset('assets/images/feature-1.png'));
    pd = "0";
    files = List();
    Map<String, dynamic> map = StorageUtil().getJSON(STORAGE_USER_PROFILE_KEY);
    _userId = map['data']['userID'];
    _schoolname = map['data']['shcoolName'];
  }

  //获取图片
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
                  File img =
                  await CutImage.cameraImge();
                  if (img != null) {
                    Navigator.of(context).pop(img);
                  }
                },
              ),
              ListTile(
                leading: new Icon(Icons.photo_library),
                title: new Text("相册获取"),
                onTap: () async {
                  File img = await CutImage.pickImage();
                  if (img != null) {
                    Navigator.of(context).pop(img);
                  }
                },
              ),
            ],
          );
        });
  }
  _updImg()async{
    if (files.length != 0) {
      for (File file in files) {
        var mufile = await MultipartFile.fromFile(
            file.path);
        mufiles.add(mufile);
      }
      if(mufiles.length==files.length){
        UploadCommodityInfo entity = UploadCommodityInfo(
            userId: _userId,
            commodityImg: mufiles,
            commoditydescribe: controller.value.text.toString(),
            commodityname: titleController.value.text.toString(),
            commodityprice: priceController.value.text.toString(),
            schoolname: _schoolname);
        UploadCommodityInfoResponse urs = await CommodityAPI.UploadComodity(params: entity.toJson());
        if(urs.code==200){
          toastInfo(msg: '上传成功');
          pd="1";
          setState(() {
            files.clear();
          });
          mufiles.clear();
          controller.clear();
          titleController.clear();
          priceController.clear();
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
            height: double.infinity,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      height: 50,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () => ExtendedNavigator.rootNavigator.pop(pd),
                              child: Icon(Icons.arrow_back_ios,
                              ),
                            ),
                            Text('修改',style: TextStyle(fontSize: 18),)
                          ],
                        ),
                      )
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20,),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SizedBox(width: 10,),
                            Text(
                              '请输入商品标题 :',
                              style: TextStyle(
                                  fontSize: 18, fontStyle: FontStyle.normal),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        Container(
                          height: 50,
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            border: Border(top: BorderSide(
                                color: Colors.grey[100]),
                              bottom: BorderSide(color: Colors.grey[100]
                              ),
                            ),
                          ),
                          child: TextField(
                            controller: titleController,
                            decoration: InputDecoration(
                                border: InputBorder.none
                            ),
                            maxLength: 20,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Text('请输入价格：', style: TextStyle(
                                fontSize: 18
                            ),),
                          ),
                        ),
                        Container(
                          height: 50,
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            border: Border(top: BorderSide(
                                color: Colors.grey[100]),
                              bottom: BorderSide(color: Colors.grey[100]
                              ),
                            ),
                          ),
                          child: TextField(
                            controller: priceController,
                            decoration: InputDecoration(
                                border: InputBorder.none
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '请输入商品描述内容 :',
                            style: TextStyle(
                                fontSize: 18, fontStyle: FontStyle.normal),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 180,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(color: Colors.grey[100]),
                          bottom: BorderSide(color: Colors.grey[100]),
                        )),
                    child: TextField(
                      controller: controller,
                      maxLength: 200,
                      maxLines: 10,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  Container(
                    height: 200,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4),
                      itemCount: files.length + 1,
                      itemBuilder: (BuildContext context, index) {
                        return files.length == 0 ? GestureDetector(
                          child: Container(
                            padding: EdgeInsets.only(right: 5),
                            height: 80,
                            child: addImg,
                          ),
                          onTap: () async {
                            File img = await _selectorImage(context);
                            if (img != null) {
                              setState(() {
                                files.add(img);
                              });
                            }
                          },
                        )
                            : index == files.length ? GestureDetector(
                          child: Container(
                            padding: EdgeInsets.only(right: 5),
                            height: 80,
                            color: Colors.grey[100],
                            child: addImg,
                          ),
                          onTap: () async {
                            if (files.length < 7) {
                              File img = await _selectorImage(context);
                              if (img != null) {
                                setState(() {
                                  files.add(img);
                                });
                              }
                            } else {
                              toastInfo(msg: '最多七张照片');
                            }
                          },
                        ) : GestureDetector(
                          child: Container(
                            height: 80,
                            padding: EdgeInsets.only(right: 5),
                            child: ExtendedImage.file(files[index]),
                          ),
                          onTap: () {
                            //FadeRoute是自定义的切换过度动画（渐隐渐现） 如果不需要 可以使用默认的MaterialPageRoute
                            Navigator.of(context).push(
                                FadeRoute(page: PhotoViewGalleryScreen(
                                  images: files, //传入图片list
                                  index: index, //传入当前点击的图片的index
                                  heroTag: files[index], //传入当前点击的图片的hero tag （可选）
                                )));
                          },
                        );
                      },),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.only(left: 40, right: 40),
                    child: GestureDetector(
                      onTap: ()  {
                        _updImg();
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color(0xFF73AEF5),
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
                            '发布商品',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
        ),
      ),
    ), onWillPop: (){
      ExtendedNavigator.rootNavigator.pop(pd);
    });
  }
}
class FadeRoute extends PageRouteBuilder {
  final Widget page;

  FadeRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        FadeTransition(
          opacity: animation,
          child: child,
        ),
  );
}
