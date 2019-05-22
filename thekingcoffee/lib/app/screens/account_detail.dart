import 'package:flutter/material.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/core/components/ui/draw_left/draw_left.dart';
import 'package:thekingcoffee/core/utils/utils.dart';

import 'helper/dashboard_helper/placeholder_home.dart';

class Account extends StatefulWidget {
  Account({Key key}) : super(key: key);

  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  void initState() {
    Config.isHideNavigation = true;
    super.initState();
  }

  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            key: _scaffoldKey,
            backgroundColor: Colors.white,
            elevation: 0.5,
            title: Text(
              "Account information",
              style: StylesText.style20BrownBold,
            ),
            leading: FlatButton(
              onPressed: () {
                Config.isHideNavigation = false;
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => PlaceholderMainWidget()));
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.brown,
              ),
            ),
          ),
          body: Container(
            padding: const EdgeInsets.all(5.0),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Container(
                      width: double.infinity,
                      height: Dimension.getHeight(0.35),
                      color: Colors.blue[300],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          FlatButton(
                            child:
                                Icon(Icons.more_horiz, color: Colors.redAccent),
                            onPressed: () {},
                          )
                        ],
                      )),
                ),
              ],
            ),
          ),
          drawer: Drawer(
            child: HomeMenu(),
          ),
        ));
  }
}
