import 'package:flutter/material.dart';

class ThemePrimary {
  ///Colors
  static const primaryColor = Color(0xFF66A73D);

  static const blue = Color(0xFF4285F4);

  static const redOrange = Color(0xFFFE593B);

  static const textPrimaryColor =
      Color(0xFF666666); //Dùng cho các đoạn text chính

  static const textSubColor =
      Color(0xFFA3A3A3); // Dùng cho Navi bottom + các text thứ yếu ngày giờ

  static const gradientColor = Color(0xFFc49b29);

  static const backgroundColor = Colors.white; //Color(0xFFF2F2F2);

  static const backgroundPrimaryColor = Color(0xFFEAEAEA);

  ///fonts
  static const primaryFontFamily = "HelveticaNeueLTStd";

  ///styleHeardLine 24px using for appbar, tutorials heading
  static const styleHeardLine24 = TextStyle(
      color: textPrimaryColor, fontSize: 24, fontWeight: FontWeight.w600);

  ///styleHeardLine 16px using for tutorial description,
  static const styleHeardLine16 = TextStyle(
      color: textPrimaryColor, fontSize: 16, fontWeight: FontWeight.w600);

  ///styleTextPrimary 14px using for primary text,
  static const styleTextPrimary14 =
      TextStyle(color: textPrimaryColor, fontSize: 14);

  ///stylePrimaryText 14px using for primary text,
  static const styleTextPrimaryColor14 =
      TextStyle(color: primaryColor, fontSize: 14);

  ///styleLabelTextField using for label of textField in app
  static const styleLabelTextField = TextStyle(color: primaryColor);

  ///styleTextButton
  static const styleTextButton =
      TextStyle(color: textPrimaryColor, fontSize: 18);

  static const appBar_textTheme = TextTheme(
    headline5: TextStyle(
      fontFamily: primaryFontFamily,
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  );
  static const appBar_iconTheme = IconThemeData(
    color: Colors.white,
  );

  static const Color gradientStart = primaryColor;
  static const Color gradientEnd = gradientColor;

  static const primaryGradient = LinearGradient(
    colors: const [gradientStart, gradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const chatBubbleGradient = const LinearGradient(
    colors: const [Color(0xFFa8ddf7), Color(0xFFa8ddf7)],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );

  static const chatBubbleGradient2 = const LinearGradient(
    colors: const [Color(0xFFf0edda), Color(0xFFf0edda)],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );
  static theme() {
    return ThemeData(
      textTheme: TextTheme(),
      fontFamily: "HelveticaNeueLTStd",
      primaryColor: primaryColor,
      //primaryColor: Colors.blue,
      backgroundColor: Colors.white,
      snackBarTheme: SnackBarThemeData(
        backgroundColor: primaryColor,
        actionTextColor: Colors.white,
      ),
      dialogTheme: DialogTheme(
          backgroundColor: Colors.white,
          contentTextStyle: TextStyle(color: primaryColor)),
      accentColor: primaryColor,
      buttonTheme: ButtonThemeData(
        buttonColor: primaryColor,
      ),
      buttonColor: primaryColor,
//      accentTextTheme: TextTheme(button: TextStyle(color: primaryColor))
      //canvasColor: Colors.white,
      // appBarTheme:
      //     AppBarTheme(textTheme: appBar_textTheme, iconTheme: appBar_iconTheme),
    );
  }

  static TextStyle loginPageButton(BuildContext context) {
    return TextStyle(color: Theme.of(context).primaryColor, fontSize: 15);
  }

  static const history_page_backgroundcolor = Color(0XFFF3F7F6);

  static const colorOptions = Color(0xFFF7F7F7);
}
