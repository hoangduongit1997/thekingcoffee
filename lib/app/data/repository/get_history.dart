import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:thekingcoffee/app/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future getHistory() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    int idUser = prefs.getInt('idUser');
    final response = await http.get(
      Config.getHistoryAPI + idUser.toString(),
      headers: {'Token': token.toString()},
    );
    final res = json.decode(response.body)['Value'];
    return res;
  } catch (e) {
    print(e.toString());
    return null;
  }
}
