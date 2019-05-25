import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/app/screens/account_detail.dart';
import 'package:thekingcoffee/app/screens/dashboard.dart';
import 'package:thekingcoffee/app/screens/earn_point.dart';
import 'package:thekingcoffee/app/screens/favorite_page.dart';
import 'package:thekingcoffee/app/screens/helper/dashboard_helper/placeholder_home.dart';
import 'package:thekingcoffee/app/screens/history.dart';
import 'package:thekingcoffee/app/screens/login.dart';
import 'package:thekingcoffee/app/screens/shopping_list.dart';
import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thekingcoffee/app/validation/validation.dart';
import 'package:thekingcoffee/core/components/widgets/favorite.dart';

class HomeMenu extends StatefulWidget {
  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  CheckLogin() async {
    if ((await Validation.IsLogin()) == true) {
      Config.islogin = 1;
    }
  }

  @override
  Future initState() {
    CheckLogin();
    Config.isHideNavigation = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Account()));
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => EarnPoint()));
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
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => History()));
          },
          child: ListTile(
            title: Text(
              'History',
              style: StylesText.style13BlackBold,
            ),
            leading: Icon(Icons.history, color: Colors.redAccent),
          ),
        ),
        Config.islogin == 0
            ? Container()
            : InkWell(
                child: ListTile(
                  title: Text(
                    'Log out',
                    style: StylesText.style13BlackBold,
                  ),
                  leading: Icon(Icons.error, color: Colors.redAccent),
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
                                  Config.islogin = 0;
                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();
                                  preferences.clear();
                                  print(preferences);
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
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
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => History()));
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
