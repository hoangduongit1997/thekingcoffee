import 'package:flutter/material.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/app/screens/dashboard.dart';
import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/core/components/ui/draw_left/draw_left.dart';
import 'package:thekingcoffee/core/utils/utils.dart';

import 'helper/dashboard_helper/placeholder_home.dart';

class Account extends StatefulWidget {
  Account({Key key}) : super(key: key);

  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
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
                Navigator.of(context).pop();
                // Navigator.of(context, rootNavigator: true).pushReplacement(
                //     MaterialPageRoute(builder: (context) => DashBoard()));
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.brown,
              ),
            ),
          ),
          body: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Container(
                      color: Colors.grey[300],
                      padding: const EdgeInsets.all(5.0),
                      width: double.infinity,
                      height: Dimension.getHeight(0.30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Stack(
                            alignment: AlignmentDirectional.topCenter,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Container(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      GestureDetector(
                                        child: Icon(
                                          Icons.more_horiz,
                                          color: Colors.redAccent,
                                        ),
                                        onTap: () {},
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Container(
                                  height: Dimension.getHeight(0.28),
                                  width: Dimension.getWidth(0.5),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.redAccent, width: 2.0),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                          Config.ip +
                                              "/storage/images/kingcoffee/congan.png",
                                        ),
                                      )),
                                ),
                              ),
                            ],
                          )
                        ],
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                )
              ],
            ),
          ),
          drawer: Drawer(
            child: HomeMenu(),
          ),
        ));
  }
}
