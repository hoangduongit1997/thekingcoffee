import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/core/components/lib/change_language/change_language.dart';

Future findFood(String food) async {
  try {
    var res;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    if (token != null) {
      http.Response response =
          await http.get(Config.findFoodAPI + food, headers: {'Token': token});
      res = json.decode(response.body)['Value'];
    } else {
      http.Response response = await http.get(Config.findFoodAPI + food);
      res = json.decode(response.body)['Value'];
    }
    if (res == null) {
      showToast(
        allTranslations.text("no_food").toString(),
      );
    }
    return res;
  } catch (e) {
    print(e.toString());
    return null;
  }
}
