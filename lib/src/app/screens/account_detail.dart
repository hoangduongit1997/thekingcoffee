import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:thekingcoffee/src/app/core/components/lib/change_language/change_language.dart';
import 'package:thekingcoffee/src/app/core/components/widgets/draw_left/draw_left.dart';
import 'package:thekingcoffee/src/app/core/utils.dart';
import 'package:thekingcoffee/src/app/theme/styles.dart';

class Account extends StatefulWidget {
  Account({Key key}) : super(key: key);

  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
          appBar: AppBar(
            key: _scaffoldKey,
            backgroundColor: Colors.white,
            elevation: 0.5,
            title: Text(
              allTranslations.text("account_information").toString(),
              style: StylesText.style20BrownBold,
            ),
            leading: FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
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
                      height: Dimension.getHeight(0.32),
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
                                        child: Icon(Icons.more_horiz,
                                            color: Colors.brown),
                                        onTap: () {},
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Container(
                                    // child:
                                    //  CircularProfileAvatar(
                                    //   "http://207.148.71.41/storage/images/kingcoffee/congan.png",
                                    //   errorWidget: (context, url, error) =>
                                    //       Container(
                                    //         child: Icon(
                                    //           Icons.error,
                                    //           color: Colors.redAccent,
                                    //         ),
                                    //       ),
                                    //   placeHolder: (context, url) => Container(
                                    //         width: 40,
                                    //         height: 40,
                                    //         child: CircularProgressIndicator(
                                    //           valueColor:
                                    //               new AlwaysStoppedAnimation(
                                    //                   Colors.redAccent),
                                    //         ),
                                    //       ),
                                    //   radius: 90,
                                    //   backgroundColor: Colors.white,
                                    //   borderWidth: 2,
                                    //   borderColor: Colors.redAccent,
                                    //   elevation: 5.0,
                                    //   cacheImage: true,
                                    // ),
                                    ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Container(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text(
                                    "Hoàng Dương",
                                    style: StylesText.style20BrownNomorlRaleway,
                                  ),
                                ],
                              ),
                            ),
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
