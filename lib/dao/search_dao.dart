import 'dart:convert';

import 'package:flutter_trip/modal/search_modal.dart';
import 'package:http/http.dart' as http;
class SearchDao{
  static Future<SearchModel> fetch(String url,String text) async{
    final response = await http.get(url);
    if(response.statusCode == 200){
      Utf8Decoder utf8Decoder= Utf8Decoder();
      var result = json.decode(utf8Decoder.convert(response.bodyBytes));
      SearchModel model = SearchModel.fromJson(result);
      model.keyword = text;
      return model;
    }else{
      throw Exception('Failed to load home_page.json');
    }
  }
}
