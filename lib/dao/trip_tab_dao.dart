import 'dart:convert';

import 'package:flutter_trip/modal/TripTabModel.dart';
import 'package:http/http.dart' as http;
class TripTabDao{
  static Future<TripTabModel> fetch(String url,String text) async{
    final response = await http.get(url);
    if(response.statusCode == 200){
      Utf8Decoder utf8Decoder= Utf8Decoder();
      var result = json.decode(utf8Decoder.convert(response.bodyBytes));
      TripTabModel model = TripTabModel.fromJson(result);
      return model;
    }else{
      throw Exception('Failed to load trip_tab_model.json');
    }
  }
}
