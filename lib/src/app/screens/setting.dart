import 'package:flutter/material.dart';
import 'package:thekingcoffee/src/app/core/components/lib/change_language/change_language.dart';
import 'package:thekingcoffee/src/app/core/components/widgets/draw_left/draw_left.dart';
import 'package:thekingcoffee/src/app/screens/language.dart';
import 'package:thekingcoffee/src/app/theme/styles.dart';

class Setting extends StatefulWidget {
  Setting({Key key}) : super(key: key);

  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.8,
        backgroundColor: Colors.white,
        title: Text(
          allTranslations.text("setting"),
          style: StylesText.style20BrownBold,
        ),
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
                  allTranslations.text("language").toString(),
                  style: StylesText.style16Brown,
                ),
                trailing: Text(
                    allTranslations.text("language_settings").toString(),
                    style: StylesText.style14Redaccent),
              ),
            ),
            Card(
              child: ListTile(
                title: Text(
                  allTranslations.text("terms"),
                  style: StylesText.style16Brown,
                ),
                trailing:
                    Icon(Icons.arrow_forward_ios, color: Colors.grey[300]),
              ),
            ),
            Card(
              child: ListTile(
                title: Text(
                  allTranslations.text("version").toString() + " 1.0.0",
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
    );
  }
}
