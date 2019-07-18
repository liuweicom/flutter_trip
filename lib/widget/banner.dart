import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip/modal/CommonModel.dart';

class BannerWidget extends StatelessWidget {
  final List<CommonModel> bannerList;

  const BannerWidget({Key key, this.bannerList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(this.bannerList);
    return Container(
      height: 160,
      decoration: BoxDecoration(color: Colors.white),
      child: Swiper(
        itemCount: bannerList.length,
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              CommonModel model = bannerList[index];
              print(model.url);
//              Navigator.push(context, MaterialPageRoute(builder: (context)=>))
            },
            child: Image.network(bannerList[index].icon,fit: BoxFit.fill),
          );
        },
        pagination: SwiperPagination(alignment: Alignment.bottomCenter),
      ),
    );
  }
}
