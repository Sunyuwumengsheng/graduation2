import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:graduation/entitys/commodity.dart';
import 'package:graduation/pages/detilaspage/commoditydetials.dart';
import 'package:provider/provider.dart';
class MySchoolNamePage extends StatefulWidget {
  @override
  _MySchoolNamePageState createState() => _MySchoolNamePageState();
}

class _MySchoolNamePageState extends State<MySchoolNamePage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: EdgeInsets.all(12),
          child: Consumer<CommodityResponsEntitys>(
            builder: (context, comodity, child) {
              return comodity.schoolData == null
                  ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      backgroundColor: Color(0xFF28D8A1),
                    ),
                  ))
                  : StaggeredGridView.countBuilder(
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  crossAxisCount: 2,
                  itemCount: comodity.schoolData.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius:
                          BorderRadius.all(Radius.circular(20))),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        child: comodity.schoolData.length == 0
                            ? Container()
                            : GestureDetector(
                          child: SchoolSing_prod(
                            name: comodity.schoolData[index].commodityname,
                            pictures: _getpictureImg(
                                comodity.schoolData[index].commodityImg),
                          ),
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetialsCommoditysPage(
                                        data: comodity.data[index],
                                      ))),
                        ),
                      ),
                    );
                  },
                  staggeredTileBuilder: (index) {
                    return StaggeredTile.count(1, index.isEven ? 1.2 : 1.0);
                  });
            },
          )),
    );
  }
  String _getpictureImg(String s) {
    return s.split(',')[0];
  }
}
class SchoolSing_prod extends StatelessWidget {
  final name;
  final pictures;
  final price;

  SchoolSing_prod({this.name, this.price, this.pictures});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Card(
      clipBehavior: Clip.antiAlias,
      child: GestureDetector(
        child: GridTile(
          child: ExtendedImage.network(
            pictures,
            fit: BoxFit.cover,
          ),
          footer: Container(
            color: Colors.white70,
            child: ListTile(
              leading: Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
