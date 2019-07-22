import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_trip/modal/CommonModel.dart';
import 'package:flutter_trip/modal/GridNavModel.dart';
import 'package:flutter_trip/modal/HomeModel.dart';
import 'package:flutter_trip/modal/SalesBoxModel.dart';
import 'package:flutter_trip/page/search_page.dart';
import 'package:flutter_trip/util/navigator_util.dart';
import 'package:flutter_trip/widget/banner.dart';
import 'package:flutter_trip/widget/grid_Nav.dart';
import 'package:flutter_trip/widget/loading_widget.dart';
import 'package:flutter_trip/widget/local_nav.dart';
import 'package:flutter_trip/widget/sales_box.dart';
import 'package:flutter_trip/widget/search_bar.dart';
import 'package:flutter_trip/widget/sub_nav.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeModel homeModel;
  List<CommonModel> localNavList = [];
  List<CommonModel> bannerList = [];
  List<CommonModel> subNavList = [];
  GridNavModel gridNavModel;
  SalesBoxModel salesBoxModel;
  bool isLoading = false;

  double appBarAlpha = 0;
  Future<HomeModel> fetch() async {
    Response response = await http.get(
        "https://www.easy-mock.com/mock/5d2ec0ee4f3b4f312eed7cb8/home_app");
    if (response.statusCode == 200) {
      Utf8Decoder decoder = new Utf8Decoder();
      var result = json.decode(decoder.convert(response.bodyBytes));
      print(result.toString());
      return HomeModel.fromJson(result);
    } else {
      throw Exception("获取home_app错误！");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isLoading = true;
    });
    fetch().then((HomeModel homeModelJson) {
      setState(() {
        homeModel = homeModelJson;
        localNavList = homeModelJson.localNavList;
        bannerList = homeModelJson.bannerList;
        subNavList = homeModelJson.subNavList;
        gridNavModel = homeModelJson.gridNav;
        salesBoxModel = homeModelJson.salesBox;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: LoadWidget(
        isLoading: isLoading,
        child: Stack(children: <Widget>[
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: Container(
              decoration: BoxDecoration(color: Color(0xfff2f2f2)),
              child: RefreshIndicator(
                onRefresh: fetch,
                child: NotificationListener(
                  child: _listView(),
                  onNotification: (scrollNotification){
                    if(scrollNotification is ScrollUpdateNotification && scrollNotification.depth == 0){
                      _onScroll(scrollNotification.metrics.pixels);
                    }
                  },),
              ),
            ),
          ),
          _appBar(),
        ],),
      ),
    );
  }

  ListView _listView() {
    return ListView(
                children: <Widget>[
                  BannerWidget(bannerList: bannerList),
                  Padding(
                    padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                    child: LocalNav(localNavList: localNavList),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
                    child: GridNav(gridNavModel: gridNavModel),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
                    child: SubNav(subNavList: subNavList),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
                    child: SalesBox(salesBoxModel: salesBoxModel),
                  ),
                ],
              );
  }

  _appBar() {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0x66000000), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
            ),
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            height: 88,
            decoration: BoxDecoration(
              color: Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255)
            ),
            child: SearchBar(
              searchBarType: appBarAlpha>0.2 ? SearchBarType.homeLight:SearchBarType.home,
              inputBoxClick: _jumpToSearch,
              speakClick: _jumpToSpeak,
              defaultText: '网红打卡地 景点 酒店 美食',
              leftButtonClick: (){},
            ),
          ),
        ),
        Container(
          height: appBarAlpha > 0.2 ? 0.5 : 0,
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]
          ),
        ),
      ],
    );
  }

  _jumpToSearch() {
    NavigatorUtil.push(
      context,
      SearchPage(
        keyword: '网红打卡地 景点 酒店 美食',
      )
  );
  }

  _jumpToSpeak() {
    print('jumptoSpeak');
  }

  void _onScroll(double offset) {
    double alpha = offset / 100;
    if(alpha < 0){
      alpha = 0;
    }else if(alpha>1){
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
    print(appBarAlpha);
  }
}
