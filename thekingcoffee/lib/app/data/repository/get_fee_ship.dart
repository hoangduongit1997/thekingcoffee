import 'dart:convert';

import 'package:http/http.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/core/components/ui/home_cart/home_cart_coffee.dart';

Future<int> Get_fee_ship(double lat, double lng) async {

  Map data_order={
      "OrdersData":ListOrderProducts,
      "Lat":lat,
      "Long":lng
  };
  var data_order_final=json.encode(data_order);
  Response response =
      await post(Config.get_fee_ship,headers: {'Content-Type': 'application/json'},body: data_order_final);
  var data = json.decode(response.body);
  if (data['Status'] == 1) {
    return data['Value'];
  }
  return 0;
}
