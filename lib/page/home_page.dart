import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_trip/modal/CommonModel.dart';
import 'package:flutter_trip/modal/GridNavModel.dart';
import 'package:flutter_trip/modal/HomeModel.dart';
import 'package:flutter_trip/modal/SalesBoxModel.dart';
import 'package:flutter_trip/widget/banner.dart';
import 'package:flutter_trip/widget/grid_Nav.dart';
import 'package:flutter_trip/widget/local_nav.dart';
import 'package:flutter_trip/widget/sales_box.dart';
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
    fetch().then((HomeModel homeModelJson) {
      setState(() {
        homeModel = homeModelJson;
        localNavList = homeModelJson.localNavList;
        bannerList = homeModelJson.bannerList;
        subNavList = homeModelJson.subNavList;
        gridNavModel = homeModelJson.gridNav;
        salesBoxModel = homeModelJson.salesBox;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: Container(
        decoration: BoxDecoration(color: Color(0xfff2f2f2)),
        child: RefreshIndicator(
          onRefresh: fetch,
          child: ListView(
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
          ),
        ),
      ),
    );
  }
}
