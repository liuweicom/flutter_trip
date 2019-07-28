import 'dart:convert';

import 'package:flutter_trip/modal/TravelTabModel.dart';
import 'package:http/http.dart' as http;
class TripTabDao{
  static Future<TravelTabModel> fetch() async{
    final response = await http.get("https://www.easy-mock.com/mock/5d2ec0ee4f3b4f312eed7cb8/trip_tabbar");
    if(response.statusCode == 200){
      Utf8Decoder utf8Decoder= Utf8Decoder();
      var result = json.decode(utf8Decoder.convert(response.bodyBytes));
      TravelTabModel model = TravelTabModel.fromJson(result);
      return model;
    }else{
      throw Exception('Failed to load trip_tab_model.json');
    }
  }
}
