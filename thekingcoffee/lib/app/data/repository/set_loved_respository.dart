import 'dart:_http';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thekingcoffee/app/config/config.dart';


Future<int> IsLove(int id_product) async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token_user = prefs.getString("token");
  var res;
  final data = {"IdProduct": id_product.toString()};

  Response response = await post(Config.set_love,
      headers: {
        'Token': token_user,
      },
      body: data);
  res = json.decode(response.body);
  if (res['Status'] == 1) {
    return 1;
  } else {
    return 0;
  }
}
