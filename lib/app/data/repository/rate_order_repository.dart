import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thekingcoffee/app/config/config.dart';

Future<bool> rateOrder(String idOrder, double startRate, String note) async {
  bool status = false;
  final rateOrder = {
    "IdOrder": idOrder,
    "Star": startRate.toString(),
    "Note": note
  };
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  Response response =
      await post(Config.rateOrder, headers: {'Token': token}, body: rateOrder);
  var data = json.decode(response.body);
  if (data['Status'] == 1) {
    status = true;
  } else {
    status = false;
  }
  return status;
}
