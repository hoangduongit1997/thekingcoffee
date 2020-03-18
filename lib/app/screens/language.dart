import 'package:flutter/material.dart';
import 'package:thekingcoffee/app/screens/login.dart';

import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/core/components/lib/change_language/change_language.dart';

import 'package:thekingcoffee/core/components/ui/draw_left/draw_left.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:thekingcoffee/core/utils/utils.dart';

class ChangeLanguage extends StatefulWidget {
  int tap_en = 0;
  int tap_vn = 0;
  ChangeLanguage({Key key}) : super(key: key);

  _LanguageState createState() => _LanguageState();
}

class _LanguageState extends State<ChangeLanguage> {
  Locale currentLang;
  @override
  void initState() {
    super.initState();
  }

  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          allTranslations.text("language").toString(),
          style: StylesText.style20BrownBold,
        ),
        leading: FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.brown,
            )),
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.all(2.0),
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          children: <Widget>[
            Card(
              child: ListTile(
                  leading: SvgPicture.asset(
                    "assets/icons/america.svg",
                    width: Dimension.getWidth(0.1),
                    height: Dimension.getWidth(0.1),
                  ),
                  onTap: () async {
                    widget.tap_vn = 0;
                    if (widget.tap_en == 0) {
                      await allTranslations.setNewLanguage('en');
                      setState(() {
                        if (istap_en == true) {
                          istap_en = true;
                          istap_vn = false;
                        } else {
                          istap_en = true;
                          istap_vn = false;
                        }
                      });
                    }
                    widget.tap_en++;
                  },
                  title: Text(
                    "English",
                    style: StylesText.style16Brown,
                  ),
                  trailing: Icon(Icons.check,
                      color: istap_en ? Colors.redAccent : Colors.transparent)),
            ),
            Card(
              child: ListTile(
                onTap: () async {
                  widget.tap_en = 0;
                  if (widget.tap_vn == 0) {
                    await allTranslations.setNewLanguage('vi');
                    setState(() {
                      if (istap_vn) {
                        istap_vn = true;
                        istap_en = false;
                      } else {
                        istap_vn = true;
                        istap_en = false;
                      }
                    });
                  }
                  widget.tap_vn++;
                },
                leading: SvgPicture.asset("assets/icons/vietnam.svg",
                    width: Dimension.getWidth(0.1),
                    height: Dimension.getWidth(0.1)),
                title: Text(
                  "Tiếng Việt",
                  style: StylesText.style16Brown,
                ),
                trailing: Icon(Icons.check,
                    color: istap_vn ? Colors.redAccent : Colors.transparent),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: HomeMenu(),
      ),
    );
  }
}
