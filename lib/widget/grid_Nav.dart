import 'package:flutter/material.dart';
import 'package:flutter_trip/modal/CommonModel.dart';
import 'package:flutter_trip/modal/GridNavItem.dart';
import 'package:flutter_trip/modal/GridNavModel.dart';
import 'package:flutter_trip/util/navigator_util.dart';
import 'package:flutter_trip/widget/webview.dart';

class GridNav extends StatelessWidget {
  final GridNavModel gridNavModel;

  const GridNav({Key key, this.gridNavModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(6),
      child: Column(children: _getItems(context)),
    );
  }

  _getItems(BuildContext context) {
    List<Widget> items = [];
    if (gridNavModel == null) return items;
    if (gridNavModel.hotel != null) {
      items.add(_getNavItem(context, gridNavModel.hotel, true));
    }
    if (gridNavModel.flight != null) {
      items.add(_getNavItem(context, gridNavModel.flight, false));
    }
    if (gridNavModel.travel != null) {
      items.add(_getNavItem(context, gridNavModel.travel, false));
    }
    return items;
  }

  Widget _getNavItem(
      BuildContext context, GridNavItem gridNavItem, bool isFirst) {
    List<Widget> items = [];
    if (gridNavItem == null) return null;
    if (gridNavItem.mainItem != null) {
      items.add(_mainItem(context, gridNavItem.mainItem));
    }
    if (gridNavItem.item1 != null && gridNavItem.item2 != null) {
      items.add(_doubleItem(context, gridNavItem.item1, gridNavItem.item2));
    }
    if (gridNavItem.item3 != null && gridNavItem.item4 != null) {
      items.add(_doubleItem(context, gridNavItem.item3, gridNavItem.item4));
    }
    Color startColor = Color(int.parse("0xff" + gridNavItem.startColor));
    Color endColor = Color(int.parse("0xff" + gridNavItem.endColor));
    return Container(
      height: 88,
      margin: isFirst ? null : EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [startColor, endColor]),
      ),
      child: Row(
        children: items,
      ),
    );
  }

  Widget _mainItem(BuildContext context, CommonModel mainItem) {
    return Expanded(
      child: Stack(
        children: <Widget>[
          Image.network(
            mainItem.icon,
            fit: BoxFit.fitWidth,
            alignment: AlignmentDirectional.bottomCenter,
            height: 88,
            width: 121,
          ),
          Container(
            margin: EdgeInsets.only(top: 11),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  print(mainItem.url);
                  NavigatorUtil.push(
                    context,
                    WebView(url: mainItem.url,statusBarColor: mainItem.statusBarColor, title: mainItem.title, hideAppBar: mainItem.hideAppBar
                    ),
                  );

                },
                child: Text(
                  mainItem.title,
                  style: TextStyle(
                      fontSize: 14, color: Colors.white, inherit: false),
                ),
              ),
            ),
          ),
        ],
      ),
      flex: 1,
    );
  }

  Widget _doubleItem(
      BuildContext context, CommonModel item1, CommonModel item2) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: _item(context, item1, true),
          ),
          Expanded(
            flex: 1,
            child: _item(context, item2, false),
          ),
        ],
      ),
      flex: 1,
    );
  }

  _item(BuildContext context, CommonModel item1, bool isFirst) {
    var borderStyle = BorderSide(
      width: 0.8,
      color: Colors.white,
    );
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              left: borderStyle,
              bottom: isFirst ? borderStyle : BorderSide.none),
        ),
        child: Center(
          child: GestureDetector(
            child: Text(
              item1.title,
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontSize: 14, color: Colors.white, inherit: false),
            ),
            onTap: () {
              print(item1.url);
              NavigatorUtil.push(
                context,
                WebView(url: item1.url,statusBarColor: item1.statusBarColor, title: item1.title, hideAppBar: item1.hideAppBar
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
