import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thekingcoffee/core/components/ui/home_cart/home_cart_coffee.dart';

Future<bool> PostOrder() async {
  bool status = false;
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  int id_user = prefs.getInt('id_user');
  final Order_Detail = {"Username": ListOrderProducts, "Password": null};
  Response response = await post(Config.order_API, body: Order_Detail);
  String body = response.body;
  var data = json.decode(body);
  var rest = data['Message'];
  if (rest == "Login successfully") {
    status = true;
  } else {
    status = false;
  }
  return status;
}
