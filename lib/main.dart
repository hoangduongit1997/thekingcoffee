import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:thekingcoffee/src/app/app.dart';
import 'package:thekingcoffee/src/app/core/sharedPreference.dart';
import 'package:thekingcoffee/src/app/core/widgets/home_cart/home_cart_coffee.dart';
import 'package:thekingcoffee/src/app/core/widgets/restart_widget.dart';
import 'package:thekingcoffee/src/app/streams/number_bloc.dart';

NumberBloc numberBloc = new NumberBloc();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  // SharedPreferences pref = await SharedPreferences.getInstance();
  // int value = await Validation.checkLanguage();
  // if (value == 1) {
  //   await allTranslations.init('vi');
  //   isTapEn = false;
  //   isTapVn = true;
  // } else if (value == 0) {
  //   await allTranslations.init('en');
  //   isTapEn = true;
  //   isTapVn = false;
  // } else {
  //   await allTranslations.init('vi');
  //   isTapEn = false;
  //   isTapVn = true;
  // }
  try {
    var saveListOrder = SpUtil.getString("list_order");
    if (saveListOrder != null) {
      listOrderProducts = json.decode(saveListOrder);
      numberBloc.checkNumber();
    }
  } catch (e) {}
  runApp(RestartWidget(child: MyApp()));
}
