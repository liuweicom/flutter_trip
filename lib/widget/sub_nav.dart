import 'package:flutter/material.dart';
import 'package:flutter_trip/modal/CommonModel.dart';
import 'package:flutter_trip/util/navigator_util.dart';
import 'package:flutter_trip/widget/webview.dart';

class SubNav extends StatelessWidget {
  final List<CommonModel> subNavList;

  const SubNav({Key key, this.subNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(6))),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  _items(BuildContext context) {
    int count = (subNavList.length/2+0.5).toInt();
    return Column(
      children: <Widget>[
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: seperatedItems(context, subNavList, 0, count),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: seperatedItems(context, subNavList, count, subNavList.length),
          ),
        )
      ],
    );
  }

  Widget _item(BuildContext context, CommonModel model) {
    return Expanded(//保证了图片得等分，不然图片对不齐
      flex: 1,
      child: GestureDetector(
      onTap: () {
        print(model.url);
        NavigatorUtil.push(
          context,
          WebView(url: model.url,statusBarColor: model.statusBarColor, title: model.title, hideAppBar: model.hideAppBar
          ),
        );
      },
      child: Column(
        children: <Widget>[
          Image.network(
            model.icon,
            width: 18,
            height: 18,
          ),
          Padding(
            padding: EdgeInsets.only(top: 3),
            child: Text(
              model.title,
              style: TextStyle(fontSize: 12,color: Colors.black,inherit: false),
            ),),
        ],
      ),
    ),);
  }

  List<Widget> seperatedItems(BuildContext context, List<CommonModel> subNavList, int start, int end) {
    List<Widget> items = [];
    List<CommonModel> listItems = subNavList.sublist(start, end);
    listItems.forEach((model) {
      items.add(_item(context, model));
    });
    return items;
  }
}
