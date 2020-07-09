import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thekingcoffee/app/bloc/number_bloc.dart';
import 'package:thekingcoffee/app/screens/login.dart';
import 'package:thekingcoffee/app/screens/map.dart';
import 'package:thekingcoffee/app/screens/shopping_list.dart';
import 'package:thekingcoffee/app/screens/splash_screen.dart';
import 'package:thekingcoffee/core/components/lib/change_language/change_language.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:thekingcoffee/core/components/ui/home_cart/home_cart_coffee.dart';
import 'app/validation/validation.dart';

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

var routes = <String, WidgetBuilder>{
  '/map': (BuildContext context) => new MapPage(),
  '/shop': (BuildContext context) => new ShoppingList(),
};

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
        theme: ThemeData(primaryColor: Colors.redAccent),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: allTranslations.supportedLocales(),
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SplashScreen(),
        ),
        routes: routes,
      ),
    );
  }
}
