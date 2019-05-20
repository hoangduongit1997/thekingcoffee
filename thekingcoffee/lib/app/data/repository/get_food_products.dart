import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:thekingcoffee/app/config/config.dart';

Get_Food_Products() async {
  try {
    final response = await http.get(Config.get_food_products_API);
    final res = json.decode(response.body)['Value'];
    return res;
  } catch (e) {
    print(e.toString());
    return null;
  }
}
