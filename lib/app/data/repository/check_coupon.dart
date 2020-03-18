import 'dart:convert';

import 'package:http/http.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/core/components/ui/home_cart/home_cart_coffee.dart';

Future<int> Check_Coupon(String coupon) async {
  var order_data = [];
  for (var item in ListOrderProducts) {
    var product = {};
    product['Id'] = item['Id'];
    order_data.add(product);
  }

  final check = {"CouponCode": coupon, "ListProduct": order_data};
  var data_finish = json.encode(check);
  Response response = await post(Config.check_coupon,
      headers: {'Content-Type': 'application/json'}, body: data_finish);
  var data = json.decode(response.body);
  if (data['Status'] == 1) {
    for (var item in ListOrderProducts) {
      for (var check_item in data['Value']) {
        if (item['Id'] == check_item['Id'] && check_item['HasCoupon'] == true) {
          item['Price'] = item['Price'] - check_item['PriceDiscount'];
        }
      }
    }
    print(ListOrderProducts.toString());
    return 1;
  }
  return 0;
}
