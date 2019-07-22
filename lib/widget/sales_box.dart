import 'package:flutter/material.dart';
import 'package:flutter_trip/modal/CommonModel.dart';
import 'package:flutter_trip/modal/SalesBoxModel.dart';
import 'package:flutter_trip/util/navigator_util.dart';
import 'package:flutter_trip/widget/webview.dart';
class SalesBox extends StatelessWidget {
  final SalesBoxModel salesBoxModel;

  const SalesBox({Key key, this.salesBoxModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 44,
          padding: EdgeInsets.only(left: 10),
          margin: EdgeInsets.only(top: 3),
          decoration: BoxDecoration(
            // TODO 为什么添加了borderRadius这个child和border的内容都不见了
//            borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Color(0xfff2f2f2))),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
            Image.network(salesBoxModel.icon,height: 15, fit: BoxFit.fill,),
              Container(
                padding: EdgeInsets.fromLTRB(10, 1, 8, 1),
                margin: EdgeInsets.only(right: 7),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), gradient: LinearGradient(
                    colors: [
                      Color(0xffff4e63),
                      Color(0xffff6cc9),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight)),
                child: GestureDetector(
                  onTap: () {
                    print(salesBoxModel.moreUrl);
                    NavigatorUtil.push(
                      context,
                      WebView(url: salesBoxModel.moreUrl, title: '更多活动',),
                    );
                  },
                  child: Text(
                    '获取更多福利 >',
                    style: TextStyle(color: Colors.white, fontSize: 12, inherit: false),),
                ),
              ),
            ],
          ),
        ),
        _doubleItem(context,salesBoxModel.bigCard1,salesBoxModel.bigCard2,true,false),
        _doubleItem(context,salesBoxModel.smallCard1,salesBoxModel.smallCard2,false,false),
        _doubleItem(context,salesBoxModel.smallCard3,salesBoxModel.smallCard4,false,true),
      ],
    );
  }

  _doubleItem(BuildContext context, CommonModel card1, CommonModel card2, bool isBig,  bool isLast) {
    return Row(
      children: <Widget>[
        _item(context, card1, isBig, true, isLast),
        _item(context, card2, isBig, false, isLast),
      ],
    );
  }

  _item(BuildContext context, CommonModel card1, bool isBig, bool isLeft, bool isLast) {
    BorderSide borderSide = BorderSide(width: 0.8, color: Color(0xfff2f2f2));
    return GestureDetector(
      onTap: (){
        print(card1.url);
        NavigatorUtil.push(
          context,
          WebView(url: card1.url,statusBarColor: card1.statusBarColor, title: card1.title, hideAppBar: card1.hideAppBar
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                right: isLeft ? borderSide : BorderSide.none,
              bottom: isLast ? BorderSide.none : borderSide
            )),
        child: Image.network(
          card1.icon,
          height: isBig ? 129 : 80,
          width: MediaQuery.of(context).size.width/2 - 7.4,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
