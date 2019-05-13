import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> PostSignUp(
    String name, String pass, String phone, String date) async {
  bool status = false;
  final SignUpJson = {
    "Username": name,
    "Password": pass,
    "Phone": phone,
    "Name": name,
    "Repassword": pass,
    "Age": date
  };
  Response response = await post(Config.signup_API, body: SignUpJson);
  String body = response.body;
  var data = json.decode(body);
  var rest = data['Message'];
  if (rest == "Sign up successfully") {
    status = true;
    var token = data['Value']['Token'];
    var id_user = data['Value']['Id'];
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
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
  } else {
    Fluttertoast.showToast(
        msg: rest,
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