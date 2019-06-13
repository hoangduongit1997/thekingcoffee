import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/core/components/lib/change_language/change_language.dart';

Find_Food(String food) async {
  try {
    final response = await http.get(Config.find_food_API + food);
    final res = json.decode(response.body)['Value'];
    if (res == null) {
      Fluttertoast.showToast(
          msg: allTranslations.text("no_food").toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return res;
  } catch (e) {
    print(e.toString());
    return null;
  }
}
