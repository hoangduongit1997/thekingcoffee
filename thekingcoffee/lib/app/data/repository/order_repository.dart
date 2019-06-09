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
  double total = 0;
  var orderData = [];
  for (var item in ListOrderProducts) {
    total += item['Price'];
    var product = {};
    product['Price'] = item['Price'];
    product['Id'] = item['Id'];
    product['Quantity'] = item['Quantity'];
    if (item['Size'] != null) {
      product['Catalogue_Size_Id'] = item['Size']['Id'];
    }
    if (item['Toppings'] != null) {
      var selectedToppings = [];
      for (var topping in item['Toppings']) {
        var t = {};
        t['Id'] = topping['Id'];
        selectedToppings.add(t);
      }
      product['Toppings'] = selectedToppings;
    }
    if (item['SelectedPromotion'] != null &&
        item['selectedDetailedSaleForProduct'] != null) {
      var selectedSaleProductFor = [];
      for (var saleProductFor in item['selectedDetailedSaleForProduct']) {
        var temp = {};
        temp['IdProduct'] = saleProductFor['IdProduct'];
        temp['Quantity'] = 1;
        temp['Id_detailedsale'] = item['SelectedPromotion']['Id'];
        selectedSaleProductFor.add(temp);
      }
      product['SaleProductFor'] = selectedSaleProductFor;
    }
    orderData.add(product);
  }
  Map Order_Detail = {
    "IsApp": true,
    "IdCustomer": id_user.toString(),
    "Address": address.toString(),
    "Phone": phone.toString(),
    "Total": total,
    "OrdersData": orderData,
    "Lat": lat.toString(),
    "Long": lng.toString()
  };
  var body_order = json.encode(Order_Detail);
  Response response = await post(Config.order_API,
      body: body_order, headers: {'Token': token.toString()});
  String body = response.body;
  var data = json.decode(body);
  /*Fluttertoast.showToast(
      msg: data['Message'],
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
      fontSize: 16.0);
  if (data['Status']) {
    status = true;
  } else {
    status = false;
  }*/
  return status;
}
