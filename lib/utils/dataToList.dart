import 'package:graduation/entitys/entitys.dart';

class DataTolist{
  List<Data> items ;
  DataTolist(){
    items = List();
  }
  toJson() {
    return items.map((item) {
      return item.toJson();
    }).toList();
  }
}