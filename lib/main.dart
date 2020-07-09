import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thekingcoffee/src/app/app.dart';
import 'package:thekingcoffee/src/app/core/components/lib/change_language/change_language.dart';
import 'package:thekingcoffee/src/app/core/components/widgets/home_cart/home_cart_coffee.dart';
import 'package:thekingcoffee/src/app/screens/login.dart';
import 'package:thekingcoffee/src/app/core/validation.dart';
import 'package:thekingcoffee/src/app/streams/number_bloc.dart';

NumberBloc numberBloc = new NumberBloc();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  int value = await Validation.checkLanguage();
  if (value == 1) {
    await allTranslations.init('vi');
    isTapEn = false;
    isTapVn = true;
  } else if (value == 0) {
    await allTranslations.init('en');
    isTapEn = true;
    isTapVn = false;
  } else {
    await allTranslations.init('vi');
    isTapEn = false;
    isTapVn = true;
  }

  try {
    var saveListOrder = pref.getString("list_order");
    if (saveListOrder != null) {
      listOrderProducts = json.decode(saveListOrder);
      numberBloc.checkNumber();
    }
  } catch (e) {}
  runApp(MyApp());
}
