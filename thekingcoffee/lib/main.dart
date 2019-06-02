import 'package:flutter/material.dart';
import 'package:thekingcoffee/app/screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.redAccent),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SplashScreen(),
      ),
    );
  }
}

// class MyApp extends StatelessElement {}
// static void setLocale(BuildContext context, Locale newLocale) async {
//   print('setLocale()');
//   _MyAppState state = context.ancestorStateOfType(TypeMatcher<_MyAppState>());

//   state.setState(() {
//     state.locale = newLocale;
//   });
// }

//   @override
//   State<StatefulWidget> createState() {
//     return _MyAppState();
//   }
// }

// class _MyAppState extends State<MyApp> {
// Locale locale;
// bool localeLoaded = false;
// @override
// void initState() {
//   super.initState();

//   this._fetchLocale().then((locale) {
//     setState(() {
//       this.localeLoaded = true;
//       this.locale = locale;
//     });
//   });
// }

// @override
// Widget build(BuildContext context) {
// if (this.localeLoaded == false) {
//   return Center(
//     child: CircularProgressIndicator(
//       valueColor: new AlwaysStoppedAnimation(Colors.redAccent),
//     ),
//   );
// } else {
// return MaterialApp(
//   theme: ThemeData(primaryColor: Colors.redAccent),
//   title: 'The King Coffee',
//   debugShowCheckedModeBanner: false,
//   home: Scaffold(
//     resizeToAvoidBottomInset: false,
//     body: SplashScreen(),
//   ),
// localizationsDelegates: [
//   AppLocalizationsDelegate(),
//   GlobalMaterialLocalizations.delegate,
//   GlobalWidgetsLocalizations.delegate,
// ],
// supportedLocales: [
//   const Locale('en', ''),
//   const Locale('vi', ''),
// ],
// locale: locale,
// );
// }
// }

// _fetchLocale() async {
//   var prefs = await SharedPreferences.getInstance();

//   if (prefs.getString('languageCode') == null) {
//     return null;
//   }
//   return Locale(
//       prefs.getString('languageCode'), prefs.getString('countryCode'));
// }
// }
