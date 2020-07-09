import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thekingcoffee/app/config/config.dart';

Future getFavoriteProduct() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    Response response =
        await get(Config.getDataHomeCartAPI, headers: {'Token': token});
    var res = json.decode(response.body)['Value'];
    return res;
  } catch (e) {
    print(e.toString());
    return null;
  }
}
