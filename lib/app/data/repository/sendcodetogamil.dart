import 'dart:convert';
import 'package:http/http.dart';
import 'package:oktoast/oktoast.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thekingcoffee/core/components/lib/change_language/change_language.dart';

Future<bool> sendCodeToGmail(String gmail) async {
  bool status = false;
  final gmailJson = {"email": gmail};
  Response response = await post(Config.sendCodeToGmailAPI, body: gmailJson);
  String body = response.body;

  var data = json.decode(body);

  if (data['Status'] == 1) {
    status = true;
    var idRequest = data['Value']['IdRequest'];
    var idUser = data['Value']['IdCustomer'];

    final prefs = await SharedPreferences.getInstance()
        .timeout(const Duration(seconds: 4));
    prefs.setString('idRequest', idRequest);
    prefs.setInt('idUser', idUser);
    showToast(
      allTranslations.text("gmail_auth").toString(),
    );
  } else {
    showToast(
      allTranslations.text("invalid_send_code_to_gmail").toString(),
    );
    status = false;
  }
  return status;
}
