import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:thekingcoffee/app/config/config.dart';

Get_Coffee_Product() async {
  try {
    final response = await http.get(Config.get_coffee_products_API);
    final res = json.decode(response.body)['Value'];
    return res;
  } catch (e) {
    print(e.toString());
    return null;
  }
}

Is_Has_Coffee_Product() async {
  try {
    final response = await http.get(Config.is_have_coffee_products_API);
    final res = json.decode(response.body)['Value'];
    return res;
  } catch (e) {
    print(e.toString());
    return null;
  }
}
