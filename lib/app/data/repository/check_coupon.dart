import 'dart:convert';
import 'package:http/http.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/core/components/ui/home_cart/home_cart_coffee.dart';

Future<int> checkCoupon(String coupon) async {
  var orderData = [];
  for (var item in listOrderProducts) {
    var product = {};
    product['Id'] = item['Id'];
    orderData.add(product);
  }

  final check = {"CouponCode": coupon, "ListProduct": orderData};
  var dataFinish = json.encode(check);
  Response response = await post(Config.checkCoupon,
      headers: {'Content-Type': 'application/json'}, body: dataFinish);
  var data = json.decode(response.body);
  if (data['Status'] == 1) {
    for (var item in listOrderProducts) {
      for (var check_item in data['Value']) {
        if (item['Id'] == check_item['Id'] && check_item['HasCoupon'] == true) {
          item['Price'] = item['Price'] - check_item['PriceDiscount'];
        }
      }
    }
    print(listOrderProducts.toString());
    return 1;
  }
  return 0;
}
