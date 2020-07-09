import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thekingcoffee/app/config/config.dart';

Future<int> isLove(int idProduct) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String tokenUser = prefs.getString("token");
  var res;
  final data = {"IdProduct": idProduct.toString()};

  Response response = await post(Config.setLove,
      headers: {
        'Token': tokenUser,
      },
      body: data);
  res = json.decode(response.body);
  if (res['Status'] == 1) {
    return 1;
  } else {
    return 0;
  }
}
