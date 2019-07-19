import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip/modal/CommonModel.dart';
import 'package:flutter_trip/util/navigator_util.dart';
import 'package:flutter_trip/widget/webview.dart';

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
              NavigatorUtil.push(
                context,
                WebView(url: model.url,statusBarColor: model.statusBarColor, title: model.title, hideAppBar: model.hideAppBar, backForbid: false
                ),
              );
            },
            child: Image.network(bannerList[index].icon,fit: BoxFit.fill),
          );
        },
        pagination: SwiperPagination(alignment: Alignment.bottomCenter),
      ),
    );
  }
}
