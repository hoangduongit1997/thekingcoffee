import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:thekingcoffee/app/screens/veryfy_gmail.dart';
import 'package:thekingcoffee/core/components/lib/change_language/flutter_i18n.dart';
import 'package:thekingcoffee/core/components/lib/change_language/flutter_i18n_delegate.dart';

void main() => runApp(ChangeLanguage());

class ChangeLanguage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: MyAppPage(),
      localizationsDelegates: [
        FlutterI18nDelegate(
            useCountryCode: true, fallbackFile: 'vn', path: 'assets/i18n'),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
    );
  }
}

class MyAppPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyAppPage> with TickerProviderStateMixin {
  Locale currentLang;
  bool _enable = false;
  bool _showpass = false;
  TextEditingController _user = new TextEditingController();
  TextEditingController _pass = new TextEditingController();
  bool _uservalid = false;
  bool _passvalid = false;
  @override
  void initState() {
    super.initState();
    new Future.delayed(Duration.zero, () async {
      await FlutterI18n.refresh(context, new Locale('vn'));
      setState(() {
        currentLang = FlutterI18n.currentLocale(context);
      });
    });
  }

  changeLanguage() {
    setState(() {
      currentLang = currentLang.languageCode == 'en'
          ? new Locale('vn')
          : new Locale('en');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          constraints: BoxConstraints.expand(),
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        new Switch(
                          value: _enable,
                          activeColor: Colors.orange,
                          activeThumbImage:
                              new AssetImage('assets/images/1.png'),
                          inactiveThumbImage:
                              new AssetImage('assets/images/2.png'),
                          onChanged: (bool value) async {
                            setState(() {
                              _enable = value;
                            });
                            changeLanguage();
                            await FlutterI18n.refresh(context, currentLang);
                          },
                        ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: new Text(
                    FlutterI18n.translate(context, "title.name"),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(224, 145, 121, 1.0),
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text(
                    FlutterI18n.translate(context, "title.second"),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: TextField(
                    controller: _user,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                        labelText:
                            FlutterI18n.translate(context, "lable.email"),
                        errorText: _uservalid
                            ? FlutterI18n.translate(
                                context, "lable.error_email")
                            : null,
                        labelStyle:
                            TextStyle(color: Colors.blueGrey, fontSize: 12)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Stack(
                    alignment: AlignmentDirectional.centerEnd,
                    children: <Widget>[
                      TextField(
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        controller: _pass,
                        obscureText: !_showpass,
                        decoration: InputDecoration(
                            labelText: FlutterI18n.translate(
                                context, "lable.password"),
                            errorText: _passvalid
                                ? FlutterI18n.translate(
                                    context, "lable.error_password")
                                : null,
                            labelStyle: TextStyle(
                                color: Colors.blueGrey, fontSize: 12)),
                      ),
                      GestureDetector(
                          onTap: ShowPass,
                          child: Text(
                            _showpass
                                ? FlutterI18n.translate(
                                    context, "action.enable")
                                : FlutterI18n.translate(
                                    context, "action.disable"),
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ),
                Row(
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: Text(
                          FlutterI18n.translate(context, "lable.forget_pass"),
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.red[300],
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: RaisedButton(
                      color: Colors.red[300],
                      child: Text(
                        FlutterI18n.translate(context, "lable.login_button"),
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      onPressed: onSigninClick,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Container(
                    height: 56,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          FlutterI18n.translate(context, "lable.new_account"),
                          style: TextStyle(fontSize: 16, color: Colors.brown),
                        ),
                        Text(
                          FlutterI18n.translate(context, "lable.sign_up"),
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.red[300],
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  void onSigninClick() {
    Navigator.push(context, MaterialPageRoute(builder: gotoverify));
  }

  void ShowPass() {
    setState(() {
      _showpass = !_showpass;
    });
  }

  Widget gotoverify(BuildContext context) {
    return VerifyGmail();
  }
}
