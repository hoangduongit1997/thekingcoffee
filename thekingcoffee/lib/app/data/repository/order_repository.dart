import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thekingcoffee/core/components/ui/home_cart/home_cart_coffee.dart';

Future<bool> PostOrder(String phone, String address) async {
  bool status = false;
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  int id_user = prefs.getInt('id_user');
  Map Order_Detail = {
    "IdCustomer": id_user.toString(),
    "Address": address.toString(),
    "Phone": phone.toString(),
    "Total": "1000",
    "OrdersData": [
      {
        "Id": 1,
        "Quantity": 2,
        "Catalogue_Size_Id": 1,
        "Price": 99,
        "Toppings": [
          {"Id": 1},
          {"Id": 2}
        ]
      }
    ]
  };
  var body_order = json.encode(Order_Detail);
  Response response = await post(Config.order_API,
      body: body_order, headers: {'Token': token.toString()});
  String body = response.body;
  var data = json.decode(body);
  var rest = data['Message'];
  if (rest == "Order successfully") {
    status = true;
  } else {
    status = false;
  }
  return status;
}
