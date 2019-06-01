import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/app/screens/dashboard.dart';
import 'package:thekingcoffee/app/screens/language.dart';
import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/core/components/ui/draw_left/draw_left.dart';

class Setting extends StatefulWidget {
  Setting({Key key}) : super(key: key);

  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0.8,
            backgroundColor: Colors.white,
            title: Text(
              "Setting",
              style: StylesText.style20BrownBold,
            ),
            // leading: FlatButton(
            //     onPressed: () {
            //       Config.current_botton_tab = 0;
            //       Navigator.of(context).pushReplacement(
            //           MaterialPageRoute(builder: (context) => DashBoard()));
            //     },
            //     child: Icon(
            //       Icons.arrow_back,
            //       color: Colors.brown,
            //     )),
          ),
          body: Container(
            padding: const EdgeInsets.all(2.0),
            width: double.infinity,
            height: double.infinity,
            child: ListView(
              children: <Widget>[
                Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChangeLanguage()));
                    },
                    title: Text(
                      'Display language',
                      style: StylesText.style16Brown,
                    ),
                    trailing:
                        Text("English", style: StylesText.style14Redaccent),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text(
                      'Terms of service',
                      style: StylesText.style16Brown,
                    ),
                    trailing:
                        Icon(Icons.arrow_forward_ios, color: Colors.grey[300]),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text(
                      'Version 1.0',
                      style: StylesText.style16Brown,
                    ),
                    trailing:
                        Icon(Icons.arrow_forward_ios, color: Colors.grey[300]),
                  ),
                ),
              ],
            ),
          ),
          resizeToAvoidBottomInset: false,
          drawer: Drawer(
            child: HomeMenu(),
          ),
        ));
  }
}
