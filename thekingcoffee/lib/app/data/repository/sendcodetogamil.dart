import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thekingcoffee/core/components/ui/show_dialog/show_message_dialog.dart';

Future<bool> SendCodeToGmail(String gmail) async {
  bool status = false;
  final GmailJson = {"email": gmail};
  Response response = await post(Config.sendcodetogmail_API, body: GmailJson);
  String body = response.body;

  var data = json.decode(body);

  var rest = data['Message'];
  var error = data['Error'];
  if (rest == "Sent code to your email") {
    status = true;
    var id_request = data['Value']['IdRequest'];
    var id_user = data['Value']['IdCustomer'];

    final prefs = await SharedPreferences.getInstance()
        .timeout(const Duration(seconds: 4));
    prefs.setString('id_request', id_request);
    prefs.setInt('id_user', id_user);
    prefs.commit();
    Fluttertoast.showToast(
        msg: rest,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0);
  }
  if (error == 'Email sent doesnot belong any user') {
    Fluttertoast.showToast(
        msg: "Email is not belong to any user",
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