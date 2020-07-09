import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thekingcoffee/core/components/lib/change_language/change_language.dart';

Future<bool> reSetPassRes(
    String code, int idUser, String idRequest, String pass) async {
  bool status = false;
  String idUserString = idUser.toString();
  final gmailAuthJson = {
    "Code_Reset": code,
    "IdCustomer": idUserString,
    "IdRequest": idRequest,
    "Password": pass
  };
  Response response = await post(Config.gmailAuthAPI, body: gmailAuthJson)
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
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0);
  } else {
    status = false;
    Fluttertoast.showToast(
      msg: allTranslations.text("reset_pass_false").toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  return status;
}
