import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thekingcoffee/app/config/config.dart';

Future getTeaProducts() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    if (token != null) {
      final response =
          await http.get(Config.getTeaProductsAPI, headers: {'Token': token});
      final res = json.decode(response.body)['Value'];
      return res;
    } else {
      final response = await http.get(Config.getTeaProductsAPI);
      final res = json.decode(response.body)['Value'];
      return res;
    }
  } catch (e) {
    print(e.toString());
    return null;
  }
}

Future isHaveTeaProducts() async {
  try {
    final response = await http.get(Config.isHaveTeaProductsAPI);
    final res = json.decode(response.body)['Value'];
    return res;
  } catch (e) {
    print(e.toString());
    return null;
  }
}
