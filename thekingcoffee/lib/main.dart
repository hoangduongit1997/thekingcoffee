import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thekingcoffee/app/screens/map.dart';
import 'package:thekingcoffee/app/screens/shopping_list.dart';
import 'package:thekingcoffee/app/screens/splash_screen.dart';
import 'package:thekingcoffee/core/components/lib/change_language/change_language.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app/validation/validation.dart';

void main() async {
  int value = await Validation.check_language();
  if (value == 1) {
    await allTranslations.init('vi');
  } else if (value == 0) {
    await allTranslations.init('en');
  } else {
    await allTranslations.init('vi');
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

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
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
