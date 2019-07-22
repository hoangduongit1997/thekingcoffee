import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thekingcoffee/core/components/lib/change_language/change_language.dart';

Future<bool> PostLogin(String username, String password) async {
  bool status = false;
  final LoginJson = {"Username": username, "Password": password};
  Response response = await post(Config.login_Api, body: LoginJson);
  String body = response.body;
  var data = json.decode(body);
  if (data['Status'] == 1) {
    status = true;
    var token = data['Value']['Token'];
    var id_user = data['Value']['Id'];
    var point = data['Value']['Point'];
    var fullname=data['Value']['Name'];
    var phone_number=data['Value']['Phone'];
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    prefs.setInt('id_user', id_user);
    prefs.setInt('points', point);
    prefs.setString('name', fullname);
    prefs.setString('phone', phone_number);
 
    Fluttertoast.showToast(
        msg: allTranslations.text("login_suc").toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0);
  } else {
    Fluttertoast.showToast(
        msg: allTranslations.text("login_false").toString(),
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
