import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/app/data/model/get_place_item.dart';

class GetPlace {
  static Future<List<GetPlaceItem>> searchPlace(String keyword) async {
    var res = await http
        .get(Config.searchPlaceApi + Uri.encodeQueryComponent(keyword));
    if (res.statusCode == 200) {
      return GetPlaceItem.fromJson(json.decode(res.body));
    } else {
      return new List();
    }
  }
}
