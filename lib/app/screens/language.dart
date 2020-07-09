import 'package:flutter/material.dart';
import 'package:thekingcoffee/app/screens/login.dart';

import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/core/components/lib/change_language/change_language.dart';

import 'package:thekingcoffee/core/components/ui/draw_left/draw_left.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:thekingcoffee/core/utils/utils.dart';

class ChangeLanguage extends StatefulWidget {
  int tapEn = 0;
  int tapVn = 0;
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
                    widget.tapVn = 0;
                    if (widget.tapEn == 0) {
                      await allTranslations.setNewLanguage('en');
                      setState(() {
                        if (isTapEn == true) {
                          isTapEn = true;
                          isTapVn = false;
                        } else {
                          isTapEn = true;
                          isTapVn = false;
                        }
                      });
                    }
                    widget.tapEn++;
                  },
                  title: Text(
                    "English",
                    style: StylesText.style16Brown,
                  ),
                  trailing: Icon(Icons.check,
                      color: isTapEn ? Colors.redAccent : Colors.transparent)),
            ),
            Card(
              child: ListTile(
                onTap: () async {
                  widget.tapEn = 0;
                  if (widget.tapVn == 0) {
                    await allTranslations.setNewLanguage('vi');
                    setState(() {
                      if (isTapVn) {
                        isTapVn = true;
                        isTapEn = false;
                      } else {
                        isTapVn = true;
                        isTapEn = false;
                      }
                    });
                  }
                  widget.tapVn++;
                },
                leading: SvgPicture.asset("assets/icons/vietnam.svg",
                    width: Dimension.getWidth(0.1),
                    height: Dimension.getWidth(0.1)),
                title: Text(
                  "Tiếng Việt",
                  style: StylesText.style16Brown,
                ),
                trailing: Icon(Icons.check,
                    color: isTapVn ? Colors.redAccent : Colors.transparent),
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
