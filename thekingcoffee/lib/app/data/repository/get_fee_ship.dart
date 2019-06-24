import 'dart:convert';

import 'package:http/http.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/core/components/ui/home_cart/home_cart_coffee.dart';

Future<int> Get_fee_ship(double lat, double lng) async {
  var order_data=ListOrderProducts;
  Response response =
      await get(Config.get_fee_ship + "?Lat=$lat" + "&Long=$lng");
  var data = json.decode(response.body);
  if (data['Status'] == 1) {
    print("Phi ship: " + data['Value'].toString());
    return data['Value'];
  }
  return 0;
}
