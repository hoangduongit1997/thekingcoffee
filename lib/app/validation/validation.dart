import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class Validation {
  static Future<bool> isLogin() async {
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
    return pass.length >= 6;
  }

  static bool isValidPhoneNumber(String phonenumber) {
    return phonenumber != null && phonenumber.length == 10;
  }

  static bool isValidConfirmPass(String pass, String confirmpass) {
    return pass == confirmpass && confirmpass.length > 0;
  }

  static bool isValidDate(String date) {
    return date.length > 0 && date != null;
  }

  static bool isValidAccept(bool checked) {
    return checked == true;
  }

  static bool isValidGmail(String gmail) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(gmail);
  }

  static bool isValidAddress(String address) {
    return address.trim().length > 0 && address.isNotEmpty;
  }

  static Future<bool> isConnectedNetwork() async {
    bool status = false;
    try {
      final result = await InternetAddress.lookup('google.com.vn');

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        status = true;
      }
    } on SocketException catch (_) {
      status = false;
    }
    return status;
  }

  static Future checkLanguage() async {
    SharedPreferences check = await SharedPreferences.getInstance();
    if (check.getString('language') == 'vi')
      return 1;
    else if (check.getString('language') == 'en') {
      return 0;
    }
  }
}
