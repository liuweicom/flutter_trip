import 'package:flutter/material.dart';

import 'CommonModel.dart';
import 'ConfigModel.dart';
import 'GridNavModel.dart';
import 'SalesBoxModel.dart';

class HomeModel{
  final ConfigModel config;
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final GridNavModel gridNav;
  final List<CommonModel> subNavList;
  final SalesBoxModel salesBox;

  HomeModel({this.config, this.bannerList, this.localNavList, this.gridNav, this.subNavList, this.salesBox});

  factory  HomeModel.fromJson(Map<String, dynamic>json){
    var bannerListJson = json['bannerList'] as List;
    List<CommonModel> bannerList = bannerListJson.map((item)=> CommonModel.fromJson(item)).toList();

    var localNavListJson = json['localNavList'] as List;
    List<CommonModel> localNavList = localNavListJson.map((item)=> CommonModel.fromJson(item)).toList();

    var subNavListJson = json['subNavList'] as List;
    List<CommonModel> subNavList = subNavListJson.map((item)=> CommonModel.fromJson(item)).toList();

    return HomeModel(
      config: ConfigModel.fromJson(json['config']),
      bannerList: bannerList,
    localNavList: localNavList,
    gridNav: GridNavModel.fromJson(json['gridNav']),
    subNavList: subNavList,
    salesBox: SalesBoxModel.formJson(json['salesBox'])
    );
  }

}
