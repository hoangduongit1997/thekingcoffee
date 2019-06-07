import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/app/screens/account_detail.dart';

import 'package:thekingcoffee/app/screens/earn_point.dart';

import 'package:thekingcoffee/app/screens/history.dart';
import 'package:thekingcoffee/app/screens/login.dart';

import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thekingcoffee/app/validation/validation.dart';

class HomeMenu extends StatefulWidget {
  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  bool islogin;
  CheckLogin() async {
    if ((await Validation.IsLogin() == true)) {
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
                accountEmail: Text(
                  'hoangduongit1997@gmail.com',
                  style: StylesText.style13Black,
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
                            Config.ip + "/storage/images/kingcoffee/congan.png",
                          ))),
                )),
                decoration: new BoxDecoration(color: Colors.redAccent),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .push(MaterialPageRoute(builder: (context) => Account()));
                },
                child: ListTile(
                  title: Text(
                    'My account',
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
                    'Earn points',
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
                    'History',
                    style: StylesText.style13BlackBold,
                  ),
                  leading: Icon(Icons.history, color: Colors.redAccent),
                ),
              ),
              InkWell(
                child: ListTile(
                  title: Text(
                    'Log in',
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
                  title: Text(
                    'Log out',
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
                            title: new Text("Confirm",
                                style: StylesText.style18RedaccentBold),
                            content: new Text(
                              "Do you want to log out ?",
                              style: StylesText.style15Black,
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("No"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              FlatButton(
                                child: Text("Yes"),
                                onPressed: () async {
                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();
                                  preferences.clear();

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
                  Navigator.of(context, rootNavigator: true).pushReplacement(
                      MaterialPageRoute(builder: (context) => History()));
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
                            title: new Text("Confirm",
                                style: StylesText.style18RedaccentBold),
                            content: new Text(
                              "Do you want to exit ?",
                              style: StylesText.style15Black,
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("No"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              FlatButton(
                                child: Text("Yes"),
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
                    'Exit',
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
                    'Log in',
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
                onTap: () {
                  Navigator.of(context, rootNavigator: true).pushReplacement(
                      MaterialPageRoute(builder: (context) => History()));
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
                            title: new Text("Confirm",
                                style: StylesText.style18RedaccentBold),
                            content: new Text(
                              "Do you want to exit ?",
                              style: StylesText.style15Black,
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("No"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              FlatButton(
                                child: Text("Yes"),
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
                    'Exit',
                    style: StylesText.style13BlackBold,
                  ),
                  leading: Icon(Icons.exit_to_app, color: Colors.redAccent),
                ),
              ),
            ],
          );
  }
}
