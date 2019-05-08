import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> Gmail_Auth_Code(
    String code, int id_user, String id_request) async {
  bool status = false;
  String id_user_string = id_user.toString();
  final GmailAuthJson = {
    "Code_Reset": code,
    "IdCustomer": id_user_string,
    "IdRequest": id_request,
    "Password": id_user_string
  };
  Response response = await post(Config.gmail_auth_API, body: GmailAuthJson)
      .timeout(const Duration(seconds: 4));
  String body = response.body;
  var data = json.decode(body);
  var rest = data['Message'];

  if (rest == "Reset password successfully") {
    status = true;
  }
  if (rest == "Check mail for getting cod") {
    Fluttertoast.showToast(
        msg: "Code input wrong!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0);
    status = false;
  }
  if (rest == "Data for reset password is wrong") {
    Fluttertoast.showToast(
        msg: "Code input wrong!",
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
