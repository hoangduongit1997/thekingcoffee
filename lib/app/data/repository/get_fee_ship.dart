import 'dart:convert';
import 'package:http/http.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/core/components/ui/home_cart/home_cart_coffee.dart';

Future<int> getFeeShip(double lat, double lng) async {
  Map dataOrder = {"OrdersData": listOrderProducts, "Lat": lat, "Long": lng};
  var dataOrderFinal = json.encode(dataOrder);
  Response response = await post(Config.getFeeShip,
      headers: {'Content-Type': 'application/json'}, body: dataOrderFinal);
  var data = json.decode(response.body);
  if (data['Status'] == 1) {
    return data['Value'];
  }
  return 0;
}
