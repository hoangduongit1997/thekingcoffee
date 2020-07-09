import 'dart:convert';
import 'package:http/http.dart';
import 'package:oktoast/oktoast.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/core/components/lib/change_language/change_language.dart';

Future<bool> postSignUp(String name, String pass, String phone, String date,
    String fullname, String gmail) async {
  bool status = false;
  final signUpJson = {
    "Username": name,
    "Password": pass,
    "Phone": phone,
    "Name": fullname,
    "Repassword": pass,
    "Age": date,
    "Email": gmail
  };
  Response response = await post(Config.signupAPI, body: signUpJson);
  String body = response.body;
  var data = json.decode(body);
  if (data['Status'] == 1) {
    status = true;
    showToast(
      allTranslations.text("sign_up_suc").toString(),
    );
  } else {
    showToast(
      allTranslations.text("sign_up_false").toString(),
    );
    status = false;
  }
  return status;
}