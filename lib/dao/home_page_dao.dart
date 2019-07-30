import 'dart:convert';

import 'package:flutter_trip/modal/HomeModel.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

const URL = "https://www.easy-mock.com/mock/5d2ec0ee4f3b4f312eed7cb8/home_app";

class HomePageDao {
  static Future<HomeModel> fetch() async {
    Response response = await http.get(URL);
    if (response.statusCode == 200) {
      Utf8Decoder decoder = new Utf8Decoder();
      var result = json.decode(decoder.convert(response.bodyBytes));
      return HomeModel.fromJson(result);
    } else {
      throw Exception("获取home_app错误！");
    }
  }
}
