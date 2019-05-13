import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';

import 'package:thekingcoffee/app/screens/login.dart';
import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/core/components/ui/tutorial/tutorial_helper.dart';


class Tutorial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: MySplashScreen(),
        ));
  }
}

class MySplashScreen extends StatefulWidget {
  MySplashScreen({Key key}) : super(key: key);

  @override
  MySplashScreenState createState() => new MySplashScreenState();
}

// Custom config
class MySplashScreenState extends State<MySplashScreen> {
  List<Slide> slides = new List();
  @override
  void initState() {
    super.initState();
    slides.add(
      new Slide(
        backgroundOpacity: 0.2,
        maxLineTitle: 2,
        styleTitle: StylesText.style30WhileBoldRobotoMono,
        styleDescription: StylesText.style20WhileItalicRaleway,
        marginDescription:
            EdgeInsets.only(left: 20.0, right: 20.0, top: 0, bottom: 0),
        centerWidget: Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[Container(child: CarouselWithIndicator())],
            )),
        colorBegin: Color(0xffFFDAB9),
        colorEnd: Color(0xff40E0D0),
        backgroundImage: 'assets/images/background.png',
        directionColorBegin: Alignment.topLeft,
        directionColorEnd: Alignment.bottomRight,
      ),
    );
  }

  void onDonePress() {
    Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginWithPass()));
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: Colors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            child: IntroSlider(
          isScrollable: false,
          // List slides
          slides: this.slides,
          // Done button
          renderDoneBtn: this.renderDoneBtn(),
          onDonePress: this.onDonePress,
          colorDoneBtn: Color(0x33000000),
          highlightColorDoneBtn: Color(0xff000000),
          isShowDotIndicator: false,
          // Locale
          // locale: 'en',
          // Show or hide status bar
          shouldHideStatusBar: true,
        )));
  }
}
