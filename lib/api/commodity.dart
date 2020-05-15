


import 'package:graduation/entitys/addcomodity.dart';
import 'package:graduation/entitys/entitys.dart';
import 'package:graduation/utils/http.dart';
///商品API
class CommodityAPI{
  ///获取发布商品
  static Future<CommodityResponsEntitys> getPersonCommodity({CommoditysRequsterEntitys parmas})async{
    var response = await HttpUtil().post('/GetpersonCommoditys/',params: parmas);
    return CommodityResponsEntitys.fromJson(response);
  }

  ///获取所有商品
  static Future<CommodityResponsEntitys> getAllCommoditys()async{
    var response = await HttpUtil().get('/GetComoditys/');
    return CommodityResponsEntitys.fromJson(response);
  }
  ///查询商品
  static Future<CommodityResponsEntitys> getSelectCommoditys({Map<String,dynamic> parmas})async{
    var response = await HttpUtil().post('/GetComoditys/',params: parmas);
    return CommodityResponsEntitys.fromJson(response);
  }
  ///发布商品
  static Future<UploadCommodityInfoResponse> UploadComodity({Map<String,dynamic> params})async{
    print(params.toString());
    var response = await HttpUtil().postForm('/UpLoadCommoditysInfo/',params: params);
    return UploadCommodityInfoResponse.fromJson(response);
  }
  ///获取收藏商品
  static Future<FavorCommodityResponsEntitys> getFavorCommodityData({FavorCommoditysRequsterEntitys parmas})async{
    var response = await HttpUtil().post('/getGoodscollectionRecources/',params: parmas);
    return FavorCommodityResponsEntitys.fromJson(response);
  }
  ///添加收藏
  static Future<AddCommodityResponseEntitys> addCommodityData({AddCommodityRequsterEntitys parmas}) async{
    var response = await HttpUtil().post('/addGoodscollection/',params: parmas);
    return AddCommodityResponseEntitys.fromJson(response);
  }
  ///删除收藏
  static Future<AddCommodityResponseEntitys> deleteCommodityData({AddCommodityRequsterEntitys parmas}) async{
    var response = await HttpUtil().post('/geleteGoodscollectionRecources/',params: parmas);
    return AddCommodityResponseEntitys.fromJson(response);
  }
  ///删除发布
  static Future<AddCommodityResponseEntitys> deleteFavorCommodityData({AddCommodityRequsterEntitys parmas}) async{
    var response = await HttpUtil().post('/deletecommoditys/',params: parmas);
    return AddCommodityResponseEntitys.fromJson(response);
  }
}
