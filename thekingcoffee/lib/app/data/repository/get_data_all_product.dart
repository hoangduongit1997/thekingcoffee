import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thekingcoffee/app/config/config.dart';

Get_Data_All_Product(int i) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    switch (i) {
      case 0:
        {
          if (token != null) {
            final response = await http.get(
                Config.get_data_home_cart_API + "?IsDesc=true",
                headers: {'Token': token});
            final res = json.decode(response.body)['Value'];
            return res;
          }

          final response =
              await http.get(Config.get_data_home_cart_API + "?IsDesc=true");
          final res = json.decode(response.body)['Value'];
          return res;
        }
      case 1:
        {
          if (token != null) {
            final response = await http.get(
                Config.get_all_drinking_products_API,
                headers: {'Token': token});
            final res = json.decode(response.body)['Value'];
            return res;
          }
          final response = await http.get(Config.get_all_drinking_products_API);
          final res = json.decode(response.body)['Value'];
          return res;
        }
      case 2:
        {
          if (token != null) {
            final response = await http.get(Config.get_all_coffee_products_API,
                headers: {'Token': token});
            final res = json.decode(response.body)['Value'];
            return res;
          }
          final response = await http.get(Config.get_all_coffee_products_API);
          final res = json.decode(response.body)['Value'];
          return res;
        }
      case 3:
        {
          if (token != null) {
            final response = await http.get(Config.get_all_food_products_API,
                headers: {'Token': token});
            final res = json.decode(response.body)['Value'];
            return res;
          }
          final response = await http.get(Config.get_all_food_products_API);
          final res = json.decode(response.body)['Value'];
          return res;
        }
      case 4:
        {
          if (token != null) {
            final response = await http.get(Config.get_all_tea_products_API,
                headers: {'Token': token});
            final res = json.decode(response.body)['Value'];
            return res;
          }
          final response = await http.get(Config.get_all_tea_products_API);
          final res = json.decode(response.body)['Value'];
          return res;
        }
    }
  } catch (e) {
    print(e.toString());
    return null;
  }
}
