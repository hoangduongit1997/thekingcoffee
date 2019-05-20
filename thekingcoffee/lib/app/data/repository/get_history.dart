import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:thekingcoffee/app/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

Get_History() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    int id_user = prefs.getInt('id_user');

    final response = await http.get(
      Config.get_history_API + id_user.toString(),
      headers: {'Token': token.toString()},
    );
    final res = json.decode(response.body)['Value'];
    print(res);
    return res;
  } catch (e) {
    print(e.toString());
    return null;
  }
}
