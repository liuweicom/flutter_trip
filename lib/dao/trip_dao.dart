import 'dart:convert';

import 'package:flutter_trip/modal/TravelModal.dart';
import 'package:http/http.dart' as http;
//param格式
var params = {
  "contentType": "json",
  "districtId": -1,
  "groupChannelCode": "tourphoto_global1",
  "head": {
    "auth": null,
    "cid": "09031179411169828484",
    "ctok": "",
    "cver": "1.0",
    "extension": [{"name": "protocal", "value": "https"}],
    "name": "protocal",
    "value": "https",
    "lang": "01",
    "sid": "8888",
  },
  "pagePara": {"pageIndex": 1, "pageSize": 10, "sortType": 9, "sortDirection": 0},
  "type": 1
};

class TripDao{
  static Future<TravelModel> fetch(String url,Map params, String groupChannelCode, int pageIndex, int pageSize) async{
    Map pagePara = params['pagePara'];
    pagePara['pageIndex'] = pageIndex;
    pagePara['pageSize'] = pageSize;
    params['groupChannelCode'] = groupChannelCode;
    final response = await http.post(url,body: jsonEncode(params));
    if(response.statusCode == 200){
      Utf8Decoder utf8Decoder= Utf8Decoder();
      var result = json.decode(utf8Decoder.convert(response.bodyBytes));
      TravelModel model = TravelModel.fromJson(result);
      return model;
    }else{
      throw Exception('Failed to load trip_tab_model.json');
    }
  }
}
