import 'dart:convert';
import 'package:http/http.dart';
import 'package:oktoast/oktoast.dart';
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
    showToast(
      allTranslations.text("reset_pass_suc").toString(),
    );
  } else {
    status = false;
    showToast(
      allTranslations.text("reset_pass_false").toString(),
    );
  }

  return status;
}
