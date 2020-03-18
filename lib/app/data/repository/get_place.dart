import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/app/data/model/get_place_item.dart';
class Get_Place{
  static Future<List<Get_Place_Item>> searchPlace(String keyword) async {
    var res = await http.get(Config.search_place_Api+Uri.encodeQueryComponent(keyword));
    if (res.statusCode == 200) {
      return Get_Place_Item.fromJson(json.decode(res.body));
    } else {
      return new List();
    }
}
}