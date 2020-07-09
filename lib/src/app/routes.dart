import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thekingcoffee/src/app/screens/map.dart';
import 'package:thekingcoffee/src/app/screens/shopping_list.dart';
import 'package:thekingcoffee/src/app/screens/splash_screen.dart';

class RouteGenerator {
  RouteGenerator._();
  static Route buildRoutes(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        {
          return buildRoute(settings, SplashScreen());
        }
      case "/map":
        {
          return buildRoute(settings, MapPage());
        }
      case "/shop":
        {
          return buildRoute(settings, ShoppingList());
        }
      default:
        return null;
    }
  }

  static CupertinoPageRoute buildRoute(RouteSettings settings, Widget builder) {
    return CupertinoPageRoute(
      settings: settings,
      builder: (BuildContext context) => builder,
    );
  }
}
