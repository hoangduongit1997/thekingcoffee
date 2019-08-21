import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:thekingcoffee/app/config/config.dart';

import 'package:thekingcoffee/core/components/lib/change_language/change_language.dart';

Future<bool> PostSignUp(String name, String pass, String phone, String date,
    String fullname, String gmail) async {
  bool status = false;
  final SignUpJson = {
    "Username": name,
    "Password": pass,
    "Phone": phone,
    "Name": fullname,
    "Repassword": pass,
    "Age": date,
    "Email": gmail
  };
  Response response = await post(Config.signup_API, body: SignUpJson);
  String body = response.body;
  var data = json.decode(body);
  if (data['Status'] == 1) {
    status = true;


    Fluttertoast.showToast(
        msg: allTranslations.text("sign_up_suc").toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0);
  } else {
    Fluttertoast.showToast(
        msg: allTranslations.text("sign_up_false").toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0);
    status = false;
  }
  return status;
}
