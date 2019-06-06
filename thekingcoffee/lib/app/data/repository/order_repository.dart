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
  double lat = prefs.getDouble('Lat');
  double lng = prefs.getDouble('Lng');
  Map Order_Detail = {
    "IsApp": true,
    "IdCustomer": id_user.toString(),
    "Address": address.toString(),
    "Phone": phone.toString(),
    "Total": 1000,
    "OrdersData": ListOrderProducts,
    "Lat": lat.toString(),
    "Long": lng.toString()
  };
  var body_order = json.encode(Order_Detail);
  Response response = await post(Config.order_API,
      body: body_order, headers: {'Token': token.toString()});
  String body = response.body;
  var data = json.decode(body);
  var rest = data['Message'];
  Fluttertoast.showToast(
      msg: rest,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
      fontSize: 16.0);
  if (rest == "Order successfully") {
    status = true;
  } else {
    status = false;
  }
  return status;
}
