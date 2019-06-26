import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thekingcoffee/app/screens/login.dart';
import 'package:thekingcoffee/app/screens/map.dart';
import 'package:thekingcoffee/app/screens/shopping_list.dart';
import 'package:thekingcoffee/app/screens/splash_screen.dart';
import 'package:thekingcoffee/core/components/lib/change_language/change_language.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:thekingcoffee/core/components/ui/home_cart/home_cart_coffee.dart';
import 'app/validation/validation.dart';
import 'package:connectivity/connectivity.dart';

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

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        Fluttertoast.showToast(
            msg: "Wifi",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
            fontSize: 16.0);
        String wifiName, wifiBSSID, wifiIP;

        try {
          wifiName = await _connectivity.getWifiName();

        } catch (e) {
          print(e.toString());
          wifiName = "Failed to get Wifi Name";
        }

        try {
          wifiBSSID = await _connectivity.getWifiBSSID();
        } catch (e) {
          print(e.toString());
          wifiBSSID = "Failed to get Wifi BSSID";
        }

        try {
          wifiIP = await _connectivity.getWifiIP();
        }  catch (e) {
          print(e.toString());
          wifiIP = "Failed to get Wifi IP";
        }

        setState(() {
          _connectionStatus = '$result\n'
              'Wifi Name: $wifiName\n'
              'Wifi BSSID: $wifiBSSID\n'
              'Wifi IP: $wifiIP\n';
        });
        break;
      case ConnectivityResult.mobile:
        {
          Fluttertoast.showToast(
              msg: "Mobile",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.redAccent,
              textColor: Colors.white,
              fontSize: 16.0);
          break;
        }
      case ConnectivityResult.none:
        Fluttertoast.showToast(
            msg: "None",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        Fluttertoast.showToast(
            msg: "Failed to get connectivity",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }
  Future<void> initConnectivity() async {
    ConnectivityResult result;

    try {
      result = await _connectivity.checkConnectivity();
      Fluttertoast.showToast(
          msg: result.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      print(e.toString());
    }
    if (!mounted) {
      return;
    }

    _updateConnectionStatus(result);
  }
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _connectivitySubscription.cancel();
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
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
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
