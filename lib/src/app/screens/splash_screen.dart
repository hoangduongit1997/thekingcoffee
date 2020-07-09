import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thekingcoffee/src/app/core/components/lib/change_language/change_language.dart';
import 'package:thekingcoffee/src/app/core/config.dart';
import 'package:thekingcoffee/src/app/core/utils.dart';
import 'package:thekingcoffee/src/app/core/validation.dart';
import 'package:thekingcoffee/src/app/screens/dashboard.dart';
import 'package:thekingcoffee/src/app/screens/tutorial.dart';
import 'package:thekingcoffee/src/app/theme/styles.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    loadSplash();
  }

  Future<Timer> loadSplash() async {
    return Timer(Duration(seconds: 3), onDoneLoading);
  }

  onDoneLoading() async {
    if ((await Validation.isLogin()) == true) {
      isLogin = true;
      return Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => DashBoard()));
    }
    isLogin = false;
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
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
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
                            allTranslations.text("splash_screen").toString(),
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
        ));
  }
}
