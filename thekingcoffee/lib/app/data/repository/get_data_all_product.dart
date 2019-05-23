import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:thekingcoffee/app/config/config.dart';

Get_Data_All_Product(int i) async {
  try {
    switch (i) {
      case 1:
        {
          final response = await http.get(Config.get_all_drinking_products_API);
          final res = json.decode(response.body)['Value'];
          return res;
        }
      case 2:
        {
          final response = await http.get(Config.get_all_coffee_products_API);
          final res = json.decode(response.body)['Value'];
          return res;
        }
      case 3:
        {
          final response = await http.get(Config.get_all_food_products_API);
          final res = json.decode(response.body)['Value'];
          return res;
        }
      case 4:
        {
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
