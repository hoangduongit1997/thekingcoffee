import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thekingcoffee/app/screens/login.dart';
import 'package:thekingcoffee/app/screens/map.dart';
import 'package:thekingcoffee/app/screens/shopping_list.dart';
import 'package:thekingcoffee/app/screens/splash_screen.dart';
import 'package:thekingcoffee/core/components/lib/change_language/change_language.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:thekingcoffee/core/components/ui/home_cart/home_cart_coffee.dart';
import 'app/validation/validation.dart';

void main() async {
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
    super.dispose();
  }

  // @override
  // didChangeAppLifecycleState(AppLifecycleState state) async {
  //   if (state == AppLifecycleState.paused) {
  //     final pref = await SharedPreferences.getInstance();
  //     await pref.setString("list_order", ListOrderProducts.toString());
  //     print("AAAAAAAAAAAAAAAAAAAA" + pref.getString('list_order').toString());
  //   }
  //   if (state == AppLifecycleState.) {
  //     final pref = await SharedPreferences.getInstance();
  //     var a = pref.getString("list_order");
  //     ListOrderProducts = a as List<dynamic>;
  //     print("TTTTTTTTTTTT" + ListOrderProducts.toString());
  //   }
  // }

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
