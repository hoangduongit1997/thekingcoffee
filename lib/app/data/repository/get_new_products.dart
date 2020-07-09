import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thekingcoffee/app/config/config.dart';

Future getNewProducts() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    if (token != null) {
      final response =
          await http.get(Config.getNewProductsAPI, headers: {'Token': token});
      final res = json.decode(response.body)['Value'];
      return res;
    } else {
      final response = await http.get(Config.getNewProductsAPI);
      final res = json.decode(response.body)['Value'];
      return res;
    }
  } catch (e) {
    print(e.toString());
    return null;
  }
}
