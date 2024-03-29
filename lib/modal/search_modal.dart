import 'package:flutter/material.dart';
class SearchModel{
final List<SearchItem> data;
String keyword;

  SearchModel({this.data,this.keyword});

  factory SearchModel.fromJson(Map<String, dynamic>json){
    var dataJson = json['data'] as List;
    List<SearchItem> data = dataJson.map((item)=>SearchItem.fromJson(item)).toList();
    return SearchModel(data: data);
  }
}

class SearchItem {
  final String word; //xx酒店
  final String type; //hotel
  final String price; //实时计价
  final String star; //豪华型
  final String zonename; //虹桥
  final String districtname; //上海
  final String url;

  SearchItem({this.word, this.type, this.price, this.star, this.zonename, this.districtname, this.url});

  factory SearchItem.fromJson(Map<String, dynamic>json){
    return SearchItem(
        word: json['word'],
        type: json['type'],
        price: json['price'],
        star: json['star'],
        zonename: json['zonename'],
        districtname: json['districtname'],
        url: json['url']
    );
  }
}
