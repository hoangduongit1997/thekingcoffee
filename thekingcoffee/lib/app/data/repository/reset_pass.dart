import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thekingcoffee/core/components/lib/change_language/change_language.dart';

Future<bool> ReSetPass_Res(
    String code, int id_user, String id_request, String pass) async {
  bool status = false;
  String id_user_string = id_user.toString();
  final GmailAuthJson = {
    "Code_Reset": code,
    "IdCustomer": id_user_string,
    "IdRequest": id_request,
    "Password": pass
  };
  Response response = await post(Config.gmail_auth_API, body: GmailAuthJson)
      .timeout(const Duration(seconds: 4));
  String body = response.body;
  var data = json.decode(body);

  if (data['Status'] == 1) {
    status = true;
    final pref = await SharedPreferences.getInstance();
    pref.clear();
    Fluttertoast.showToast(
        msg: allTranslations.text("reset_pass_suc").toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0);
  } else {
    status = false;
    Fluttertoast.showToast(
        msg: allTranslations.text("reset_pass_false").toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  return status;
}
