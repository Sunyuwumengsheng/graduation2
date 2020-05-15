import 'package:graduation/entitys/entitys.dart';
import 'package:graduation/utils/http.dart';

/// 用户
class UserAPI {
  /// 登录
  static Future<UserResponseEntity> login({UserRequestEntity params}) async {
    var response = await HttpUtil().post('/login/', params: params);
    return UserResponseEntity.fromJson(response);
  }
  ///注册
  static Future register(RegisterRequestEntity params) async{
    var response =await HttpUtil().post('/register/',params: params);
    return RegisterResponseEntity.fromJson(response);
  }
  ///更新头像
  static Future<HeadImgResponseEntity> uploadHeadImg({Map<String,dynamic> params}) async {
    var response = await HttpUtil().postForm('/UplodaImg/', params: params);
    return HeadImgResponseEntity.fromJson(response);
  }
  ///个人信息修改
 static Future<UpdataInfroResponserEntitys> updatainfo({UpdataInfoRequsterEntitys params}) async{
    var responser = await HttpUtil().post('/UpdataInfo/',params: params);
    return UpdataInfroResponserEntitys.fromJson(responser);
 }
}
