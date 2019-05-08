import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class Validation {
  static Future<bool> IsLogin() async {
    Future<SharedPreferences> _sp = SharedPreferences.getInstance();
    final SharedPreferences prefs =
        await _sp.timeout(const Duration(seconds: 4));
    String key = prefs.getString('token');
    if (key == null) {
      return false;
    }
    return true;
  }

  static bool isValidUser(String user) {
    return user != null && user.length > 0;
  }

  static bool isValidPass(String pass) {
    return pass != null && pass.length > 0;
  }

  static bool isValidPhoneNumber(String phonenumber) {
    return phonenumber != null && phonenumber.length == 10;
  }

  static bool isValidConfirmPass(String pass, String confirmpass) {
    if (pass == confirmpass && pass.length > 0 && confirmpass.length > 0)
      return true;
    return false;
  }

  static bool isValidDate(String date) {
    return date.length > 0 && date != null;
  }

  static bool isValidAccept(bool checked) {
    return checked == true;
  }

  static bool isValidGmail(String gmail) {
    return gmail != null && gmail.length > 10 && gmail.contains("@");
  }

  static Future<bool> isConnectedNetwork() async {
    bool status = false;
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 4));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        status = true;
      }
    } on SocketException catch (_) {
      status = false;
    }
    return status;
  }
}
