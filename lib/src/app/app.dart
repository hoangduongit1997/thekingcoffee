import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:thekingcoffee/main.dart';
import 'package:thekingcoffee/src/app/core/change_language.dart';
import 'package:thekingcoffee/src/app/core/widgets/home_cart/home_cart_coffee.dart';
import 'package:thekingcoffee/src/app/routes.dart';
import 'package:thekingcoffee/src/app/theme/theme_primary.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    numberBloc.dispose();
    super.dispose();
  }

  @override
  didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.paused) {
      final pref = await SharedPreferences.getInstance();
      var saveListOrder = json.encode(listOrderProducts);
      await pref.setString("list_order", saveListOrder);
    }
    if (state == AppLifecycleState.resumed) {
      final pref = await SharedPreferences.getInstance();
      var saveListOrder = pref.getString("list_order");
      listOrderProducts = json.decode(saveListOrder);
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
    return OKToast(
      textStyle: TextStyle(
        fontSize: 16.0,
      ),
      duration: Duration(seconds: 3),
      position: ToastPosition.bottom,
      textAlign: TextAlign.center,
      child: MaterialApp(
        title: "The King Coffee",
        theme: ThemePrimary.theme(),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.buildRoutes,
        supportedLocales: allTranslations.supportedLocales(),
        builder: (context, child) {
          return MediaQuery(
            child: child,
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          );
        },
      ),
    );
  }
}
