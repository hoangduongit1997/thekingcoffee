import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/app/screens/account_detail.dart';

import 'package:thekingcoffee/app/screens/earn_point.dart';

import 'package:thekingcoffee/app/screens/history.dart';
import 'package:thekingcoffee/app/screens/login.dart';

import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thekingcoffee/app/validation/validation.dart';
import 'package:thekingcoffee/core/components/lib/change_language/change_language.dart';
import 'package:thekingcoffee/core/components/ui/home_cart/home_cart_coffee.dart';
import 'package:thekingcoffee/core/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeMenu extends StatefulWidget {
  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  Future<void> _launched;
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw allTranslations.text("could_not_run ") + '$url';
    }
  }

  bool islogin;
  String point;
  CheckLogin() async {
    if ((await Validation.IsLogin() == true)) {
      final pref = await SharedPreferences.getInstance();
      setState(() {
        point = pref.getInt('points').toString();
      });
      print("Is Login");
      setState(() {
        islogin = true;
      });
    } else {
      print("No Login");
      setState(() {
        islogin = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    CheckLogin();
  }

  @override
  Widget build(BuildContext context) {
    return islogin == true
        ? ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                  accountName: Text(
                    'Hoàng Dương',
                    style: StylesText.style15BlackBold,
                  ),
                  accountEmail: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SvgPicture.asset(
                        'assets/icons/point.svg',
                        width: Dimension.getWidth(0.03),
                        height: Dimension.getHeight(0.03),
                      ),
                      Text(
                        "  " + point,
                        style: StylesText.style13BlackBold,
                      ),
                    ],
                  ),
                  currentAccountPicture: GestureDetector(
                      child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                              Config.ip +
                                  "/storage/images/kingcoffee/congan.png",
                            ))),
                  )),
                  decoration: new BoxDecoration(color: Colors.redAccent[400])),
              InkWell(
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .push(MaterialPageRoute(builder: (context) => Account()));
                },
                child: ListTile(
                  title: Text(
                    allTranslations.text("my_account").toString(),
                    style: StylesText.style13BlackBold,
                  ),
                  leading: Icon(
                    Icons.person_outline,
                    color: Colors.redAccent,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(builder: (context) => EarnPoint()));
                },
                child: ListTile(
                  title: Text(
                    allTranslations.text("earn_point").toString(),
                    style: StylesText.style13BlackBold,
                  ),
                  leading: Icon(
                    Icons.control_point,
                    color: Colors.redAccent,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .push(MaterialPageRoute(builder: (context) => History()));
                },
                child: ListTile(
                  title: Text(
                    allTranslations.text("history").toString(),
                    style: StylesText.style13BlackBold,
                  ),
                  leading: Icon(Icons.history, color: Colors.redAccent),
                ),
              ),
              InkWell(
                child: ListTile(
                  title: Text(
                    allTranslations.text("log_out").toString(),
                    style: StylesText.style13BlackBold,
                  ),
                  leading: Icon(Icons.error_outline, color: Colors.redAccent),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                            title: new Text(
                                allTranslations.text("confirm").toString(),
                                style: StylesText.style18RedaccentBold),
                            content: new Text(
                              allTranslations.text("do_log_out").toString(),
                              style: StylesText.style15Black,
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Container(
                                  width: Dimension.getWidth(0.28),
                                  height: Dimension.getHeight(0.04),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                      color: Colors.brown),
                                  child: Center(
                                      child: Text(
                                    allTranslations.text("cancel").toString(),
                                    style: StylesText.style14While,
                                  )),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              FlatButton(
                                child: Container(
                                    width: Dimension.getWidth(0.28),
                                    height: Dimension.getHeight(0.04),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                        color: Colors.redAccent),
                                    child: Center(
                                      child: Container(
                                          width: Dimension.getWidth(0.28),
                                          height: Dimension.getHeight(0.04),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0)),
                                              color: Colors.redAccent),
                                          child: Center(
                                            child: Text(
                                                allTranslations
                                                    .text("yes")
                                                    .toString(),
                                                style: StylesText.style14While),
                                          )),
                                    )),
                                onPressed: () async {
                                  ListOrderProducts.clear();
                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();
                                  await preferences.clear();
                                  Navigator.of(context, rootNavigator: true)
                                      .pushReplacement(MaterialPageRoute(
                                          builder: (context) =>
                                              LoginWithPass()));
                                },
                              ),
                            ],
                          );
                        });
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _launched = _makePhoneCall('tel:+84798353751');
                  });
                },
                child: ListTile(
                  title: Text(
                    allTranslations.text("help_draw_left").toString(),
                    style: StylesText.style13BlackBold,
                  ),
                  leading: Icon(Icons.help_outline, color: Colors.redAccent),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .push(MaterialPageRoute(builder: (context) => History()));
                },
                child: ListTile(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                            title: new Text(
                                allTranslations.text("confirm").toString(),
                                style: StylesText.style18RedaccentBold),
                            content: new Text(
                              allTranslations.text("do_exit").toString(),
                              style: StylesText.style15Black,
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Container(
                                  width: Dimension.getWidth(0.28),
                                  height: Dimension.getHeight(0.04),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                      color: Colors.brown),
                                  child: Center(
                                      child: Text(
                                    allTranslations.text("cancel").toString(),
                                    style: StylesText.style14While,
                                  )),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              FlatButton(
                                child: Container(
                                    width: Dimension.getWidth(0.28),
                                    height: Dimension.getHeight(0.04),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                        color: Colors.redAccent),
                                    child: Center(
                                      child: Text(
                                          allTranslations
                                              .text("yes")
                                              .toString(),
                                          style: StylesText.style14While),
                                    )),
                                onPressed: () {
                                  SystemChannels.platform
                                      .invokeMethod('SystemNavigator.pop');
                                },
                              ),
                            ],
                          );
                        });
                  },
                  title: Text(
                    allTranslations.text("exit_draw_left").toString(),
                    style: StylesText.style13BlackBold,
                  ),
                  leading: Icon(Icons.exit_to_app, color: Colors.redAccent),
                ),
              ),
            ],
          )
        : ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: Text(
                  '',
                  style: StylesText.style15BlackBold,
                ),
                accountEmail: Text(
                  '',
                  style: StylesText.style13Black,
                ),
                decoration: new BoxDecoration(color: Colors.redAccent),
              ),
              InkWell(
                child: ListTile(
                  title: Text(
                    allTranslations.text("login").toString(),
                    style: StylesText.style13BlackBold,
                  ),
                  leading: Icon(Icons.open_in_browser, color: Colors.redAccent),
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => LoginWithPass()));
                  },
                ),
              ),
              InkWell(
                child: ListTile(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                            title: new Text(
                                allTranslations.text("confirm").toString(),
                                style: StylesText.style18RedaccentBold),
                            content: new Text(
                              allTranslations.text("do_exit").toString(),
                              style: StylesText.style15Black,
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Container(
                                  width: Dimension.getWidth(0.28),
                                  height: Dimension.getHeight(0.04),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                      color: Colors.brown),
                                  child: Center(
                                      child: Text(
                                    allTranslations.text("cancel").toString(),
                                    style: StylesText.style14While,
                                  )),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              FlatButton(
                                child: Container(
                                    width: Dimension.getWidth(0.28),
                                    height: Dimension.getHeight(0.04),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                        color: Colors.redAccent),
                                    child: Center(
                                      child: Text(
                                          allTranslations
                                              .text("yes")
                                              .toString(),
                                          style: StylesText.style14While),
                                    )),
                                onPressed: () {
                                  SystemChannels.platform
                                      .invokeMethod('SystemNavigator.pop');
                                },
                              ),
                            ],
                          );
                        });
                  },
                  title: Text(
                    allTranslations.text("exit_draw_left").toString(),
                    style: StylesText.style13BlackBold,
                  ),
                  leading: Icon(Icons.exit_to_app, color: Colors.redAccent),
                ),
              ),
            ],
          );
  }
}
