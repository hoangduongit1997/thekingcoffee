import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/app/data/model/radiomodel.dart';
import 'package:thekingcoffee/app/screens/dashboard.dart';
import 'package:thekingcoffee/app/screens/login.dart';
import 'package:thekingcoffee/app/screens/tutorial.dart';
import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/app/validation/validation.dart';

import 'package:thekingcoffee/core/utils/utils.dart';
import 'package:thekingcoffee/main.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  // List<RadioModel> _langList = new List<RadioModel>();
  // int _index = 0;
  @override
  void initState() {
    super.initState();
    // _initLanguage();
    loadSplash();
  }

  Future<Timer> loadSplash() async {
    return Timer(Duration(seconds: 3), onDoneLoading);
  }

  onDoneLoading() async {
    if ((await Validation.IsLogin()) == true) {
      return Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => DashBoard()));
    }
    return Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Tutorial()));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    Dimension.height = MediaQuery.of(context).size.height;
    Dimension.witdh = MediaQuery.of(context).size.width;
    SizeText.queryData = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              color: Colors.white,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 100.0,
                            child: Image.asset(
                              "assets/images/cafe1.png",
                              width: Dimension.getWidth(0.5),
                              height: Dimension.getHeight(0.5),
                            )),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                        Text("The King Coffee",
                            style: StylesText.style24BrownBold)
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: Dimension.getHeight(0.03),
                        width: Dimension.getWidth(0.05),
                        child: Center(
                            child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Colors.redAccent),
                        )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      Text(
                        "Loading...",
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: StylesText.style16BrownBold,
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  // Future<String> _getLanguageCode() async {
  //   var prefs = await SharedPreferences.getInstance();
  //   if (prefs.getString('languageCode') == null) {
  //     return null;
  //   }
  //   print('_fetchLocale():' + prefs.getString('languageCode'));
  //   return prefs.getString('languageCode');
  // }

  // void _initLanguage() async {
  //   Future<String> status = _getLanguageCode();
  //   status.then((result) {
  //     if (result != null && result.compareTo('en') == 0) {
  //       setState(() {
  //         _index = 0;
  //       });
  //     }
  //     if (result != null && result.compareTo('vi') == 0) {
  //       setState(() {
  //         _index = 1;
  //       });
  //     } else {
  //       setState(() {
  //         _index = 0;
  //       });
  //     }

  //     _setupLangList();
  //   });
  // }

  // void _setupLangList() {
  //   setState(() {
  //     _langList.add(new RadioModel(_index == 0 ? true : false, 'English'));
  //     _langList.add(new RadioModel(_index == 0 ? false : true, 'VN'));
  //   });
  // }

  // void _updateLocale(String lang, String country) async {
  //   print(lang + ':' + country);

  //   var prefs = await SharedPreferences.getInstance();
  //   prefs.setString('languageCode', lang);
  //   prefs.setString('countryCode', country);

  //   MyApp.setLocale(context, Locale(lang, country));
  // }
}
