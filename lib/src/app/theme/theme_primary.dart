import 'package:flutter/material.dart';

class ThemePrimary {
  static ThemeData theme() {
    return ThemeData(
      textTheme: TextTheme(),
      fontFamily: "HelveticaNeueLTStd",
      // primaryColor: primaryColor,
      backgroundColor: Colors.white,
      snackBarTheme: SnackBarThemeData(
        // backgroundColor: primaryColor,
        actionTextColor: Colors.white,
      ),
      // dialogTheme: DialogTheme(
      //     backgroundColor: Colors.white,
      //     contentTextStyle: TextStyle(color: primaryColor)),
      // accentColor: primaryColor,
      // buttonTheme: ButtonThemeData(
      //   buttonColor: primaryColor,
      // ),
      // buttonColor: primaryColor,
//      accentTextTheme: TextTheme(button: TextStyle(color: primaryColor))
      //canvasColor: Colors.white,
      // appBarTheme:
      //     AppBarTheme(textTheme: appBar_textTheme, iconTheme: appBar_iconTheme),
    );
  }
}
