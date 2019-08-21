import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thekingcoffee/app/config/config.dart';

Future<bool> Rate_Order(String id_order, double start_rate, String note) async {
  bool status = false;
  final Rate_Order = {
    "IdOrder": id_order,
    "Star": start_rate.toString(),
    "Note": note
  };
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  Response response = await post(Config.rate_order,
      headers: {'Token': token}, body: Rate_Order);
  var data = json.decode(response.body);
  if (data['Status'] == 1) {
    status = true;
  } else {
    status = false;
  }
  return status;
}
