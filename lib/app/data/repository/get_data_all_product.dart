import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thekingcoffee/app/config/config.dart';

Future getDataAllProduct(int i) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    switch (i) {
      case 0:
        {
          if (token != null) {
            final response = await http.get(
                Config.getDataHomeCartAPI + "?IsDesc=true",
                headers: {'Token': token});
            final res = json.decode(response.body)['Value'];
            return res;
          }

          final response =
              await http.get(Config.getDataHomeCartAPI + "?IsDesc=true");
          final res = json.decode(response.body)['Value'];
          return res;
        }
      case 1:
        {
          if (token != null) {
            final response = await http.get(Config.getAllDrinkingProductsAPI,
                headers: {'Token': token});
            final res = json.decode(response.body)['Value'];
            return res;
          }
          final response = await http.get(Config.getAllDrinkingProductsAPI);
          final res = json.decode(response.body)['Value'];
          return res;
        }
      case 2:
        {
          if (token != null) {
            final response = await http
                .get(Config.getAllCoffeeProductsAPI, headers: {'Token': token});
            final res = json.decode(response.body)['Value'];
            return res;
          }
          final response = await http.get(Config.getAllCoffeeProductsAPI);
          final res = json.decode(response.body)['Value'];
          return res;
        }
      case 3:
        {
          if (token != null) {
            final response = await http
                .get(Config.getAllFoodProductsAPI, headers: {'Token': token});
            final res = json.decode(response.body)['Value'];
            return res;
          }
          final response = await http.get(Config.getAllFoodProductsAPI);
          final res = json.decode(response.body)['Value'];
          return res;
        }
      case 4:
        {
          if (token != null) {
            final response = await http
                .get(Config.getAllTeaProductsAPI, headers: {'Token': token});
            final res = json.decode(response.body)['Value'];
            return res;
          }
          final response = await http.get(Config.getAllTeaProductsAPI);
          final res = json.decode(response.body)['Value'];
          return res;
        }
    }
  } catch (e) {
    print(e.toString());
    return null;
  }
}
