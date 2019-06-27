import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thekingcoffee/app/bloc/number_bloc.dart';
import 'package:thekingcoffee/app/screens/dashboard.dart';
import 'package:thekingcoffee/app/screens/login.dart';
import 'package:thekingcoffee/app/screens/map.dart';
import 'package:thekingcoffee/app/screens/shopping_list.dart';
import 'package:thekingcoffee/app/screens/splash_screen.dart';
import 'package:thekingcoffee/core/components/lib/change_language/change_language.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:thekingcoffee/core/components/ui/home_cart/home_cart_coffee.dart';
import 'app/validation/validation.dart';

Number_Bloc number_bloc = new Number_Bloc();
void main() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  int value = await Validation.check_language();
  if (value == 1) {
    await allTranslations.init('vi');
    istap_en = false;
    istap_vn = true;
  } else if (value == 0) {
    await allTranslations.init('en');
    istap_en = true;
    istap_vn = false;
  } else {
    await allTranslations.init('vi');
    istap_en = false;
    istap_vn = true;
  }

  try {
    var save_list_order = pref.getString("list_order");
    if(save_list_order!=null)
    {
      ListOrderProducts = json.decode(save_list_order);
       number_bloc.Check_Number();
    }
   
  } catch (e) {}
  runApp(MyApp());
}

var routes = <String, WidgetBuilder>{
  '/map': (BuildContext context) => new MapPage(),
  '/shop': (BuildContext context) => new Shopping_List(),
};

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {





  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    number_bloc.dispose();
    super.dispose();
  }

  @override
  didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.paused) {
      final pref = await SharedPreferences.getInstance();
      var save_list_order = json.encode(ListOrderProducts);
      await pref.setString("list_order", save_list_order);
     
    }
    if (state == AppLifecycleState.resumed) {
      final pref = await SharedPreferences.getInstance();
      var save_list_order = pref.getString("list_order");
      ListOrderProducts = json.decode(save_list_order);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    allTranslations.onLocaleChangedCallback = _onLocaleChanged;

  }

  _onLocaleChanged() async {
    SharedPreferences language = await SharedPreferences.getInstance();
    language.setString('language', '${allTranslations.currentLanguage}');
    print('Language has been changed to: ${allTranslations.currentLanguage}');
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.redAccent),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: allTranslations.supportedLocales(),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SplashScreen(),
      ),
      routes: routes,
    );
  }
}
