import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/core/components/lib/change_language/change_language.dart';

Future<bool> gmailAuthCode(String code, int idUser, String idRequest) async {
  bool status = false;
  String idUserString = idUser.toString();
  final gmailAuthJson = {
    "Code_Reset": code,
    "IdCustomer": idUserString,
    "IdRequest": idRequest,
    "Password": idUserString
  };
  Response response = await post(Config.gmailAuthAPI, body: gmailAuthJson)
      .timeout(const Duration(seconds: 4));
  String body = response.body;
  var data = json.decode(body);
  var rest = data['Message'];

  if (rest == "Reset password successfully") {
    status = true;
  }
  if (rest == "Check mail for getting cod") {
    Fluttertoast.showToast(
        msg: allTranslations.text("code_input_wrong").toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0);
    status = false;
  }
  if (rest == "Data for reset password is wrong") {
    Fluttertoast.showToast(
        msg: allTranslations.text("code_input_wrong").toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0);
    status = false;
  }
  return status;
}
