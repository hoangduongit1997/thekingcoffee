import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:thekingcoffee/app/bloc/login_bloc.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/app/data/model/radiomodel.dart';

import 'package:thekingcoffee/app/data/repository/login_repository.dart';
import 'package:thekingcoffee/app/screens/dashboard.dart';
import 'package:thekingcoffee/app/screens/gmail.auth.dart';
import 'package:thekingcoffee/app/screens/signup_dart.dart';
import 'package:thekingcoffee/app/screens/splash_screen.dart';
import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/app/validation/validation.dart';
import 'package:thekingcoffee/core/components/lib/change_language/localizations.dart';

import 'package:thekingcoffee/core/components/ui/show_dialog/loading_dialog.dart';
import 'package:thekingcoffee/core/components/ui/show_dialog/show_message_dialog.dart';
import 'package:thekingcoffee/core/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thekingcoffee/main.dart';

class LoginWithPass extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<LoginWithPass> {
  int tap_en = 0;
  int tap_vn = 0;
  int _index = 0;
  bool istap_en = false;
  bool istap_vn = true;

  List<RadioModel> _langList = new List<RadioModel>();

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    // _initLanguage();
  }

  LoginBloc loginBloc = new LoginBloc();
  bool _showpass = false;
  TextEditingController _user = new TextEditingController();
  TextEditingController _pass = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    Config.context_app = context;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.orange,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
            padding: EdgeInsets.fromLTRB(30, 50, 30, 0),
            constraints: BoxConstraints.expand(),
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: Text(AppLocalizations.of(context).title_welcome,
                        style: StylesText.style20Brown),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child:
                        Text("The King Coffee", style: StylesText.style20Brown),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Text(
                        AppLocalizations.of(context).title_signincontinute,
                        style: StylesText.style16Brown),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: StreamBuilder<Object>(
                        stream: loginBloc.userStream,
                        builder: (context, snapshot) {
                          return TextField(
                            controller: _user,
                            style: StylesText.style18Black,
                            decoration: InputDecoration(
                                labelText: "Email or phone number",
                                errorText:
                                    snapshot.hasError ? snapshot.error : null,
                                labelStyle: StylesText.style12Bluegray),
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: <Widget>[
                        StreamBuilder<Object>(
                            stream: loginBloc.passStream,
                            builder: (context, snapshot) {
                              return TextField(
                                style: StylesText.style18Black,
                                controller: _pass,
                                obscureText: !_showpass,
                                decoration: InputDecoration(
                                    labelText: "Password",
                                    errorText: snapshot.hasError
                                        ? snapshot.error
                                        : null,
                                    labelStyle: StylesText.style12Bluegray),
                              );
                            }),
                        GestureDetector(
                            onTap: ShowPass,
                            child: Text(
                              _showpass ? "Hide" : "Show",
                              style: StylesText.style12BluegrayBold,
                            ))
                      ],
                    ),
                  ),
                  Row(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: GestureDetector(
                            onTap: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => GmailAuth()))
                                },
                            child: Text(
                                AppLocalizations.of(context).forget_pass,
                                style: StylesText.style16Red300Bold),
                          )),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: GestureDetector(
                            onTap: () {
                              Config.islogin = 0;

                              Navigator.of(context, rootNavigator: true)
                                  .pushReplacement(MaterialPageRoute(
                                      builder: (context) => DashBoard()));
                            },
                            child: Text(AppLocalizations.of(context).lable_skip,
                                style: StylesText.style16Red300Bold),
                          )),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: SizedBox(
                      width: Dimension.getWidth(0.86),
                      height: Dimension.getHeight(0.063),
                      child: RaisedButton(
                        color: Colors.red[300],
                        child: Text(AppLocalizations.of(context).btn_login,
                            style: StylesText.style16While),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        onPressed: onSigninClick,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Container(
                      height: Dimension.getHeight(0.05),
                      width: Dimension.getWidth(0.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context).lable_newaccount,
                            style: StylesText.style16Brown,
                          ),
                          GestureDetector(
                              onTap: () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignUp()))
                                  },
                              child: Text(
                                AppLocalizations.of(context).lable_signup,
                                style: StylesText.style16Red300Bold,
                              ))
                        ],
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  //   child: Container(
                  //       height: Dimension.getHeight(0.2),
                  //       width: Dimension.getWidth(0.5),
                  //       child: Container(
                  //         width: Dimension.getWidth(0.5),
                  //         color: Colors.white,
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: <Widget>[
                  //             GestureDetector(
                  //               onTap: () {
                  //                 tap_vn = 0;
                  //                 if (tap_en == 0) {
                  //                   _updateLocale('vi', '');
                  //                   setState(() {
                  //                     istap_vn = true;
                  //                     istap_en = false;
                  //                   });
                  //                 }
                  //                 tap_en++;
                  //               },
                  //               child: Container(
                  //                   decoration: BoxDecoration(
                  //                     border: Border(
                  //                         bottom: BorderSide(
                  //                             color: istap_vn
                  //                                 ? Colors.redAccent
                  //                                 : Colors.transparent,
                  //                             width: 2.0)),
                  //                   ),
                  //                   child: Text(
                  //                     "Tiếng Việt",
                  //                     style: istap_vn
                  //                         ? StylesText.style17BrownBoldlRaleway
                  //                         : StylesText.style18Black,
                  //                   )),
                  //             ),
                  //             GestureDetector(
                  //                 onTap: () async {
                  //                   tap_en = 0;
                  //                   if (tap_vn == 0) {
                  //                     _updateLocale('en', '');
                  //                     setState(() {
                  //                       istap_en = true;
                  //                       istap_vn = false;
                  //                     });
                  //                   }
                  //                   tap_vn++;
                  //                 },
                  //                 child: Container(
                  //                     decoration: BoxDecoration(
                  //                       border: Border(
                  //                           bottom: BorderSide(
                  //                               color: istap_en
                  //                                   ? Colors.redAccent
                  //                                   : Colors.transparent,
                  //                               width: 2.0)),
                  //                     ),
                  //                     child: Text(
                  //                       "English",
                  //                       style: istap_en
                  //                           ? StylesText
                  //                               .style17BrownBoldlRaleway
                  //                           : StylesText.style18Black,
                  //                     )))
                  //           ],
                  //         ),
                  //       )),
                  // )
                ],
              ),
            )),
      ),
    );
  }

  void onSigninClick() async {
    LoadingDialog.showLoadingDialog(context, "Loading...");

    if ((await Validation.isConnectedNetwork()) == true &&
        loginBloc.isValidInfo(_user.text.trim(), _pass.text.trim()) == true) {
      LoadingDialog.hideLoadingDialog(context);
      if (await PostLogin(
              _user.text.trim().toString(), _pass.text.trim().toString()) ==
          true) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => DashBoard()));
      }
    }
    if ((await Validation.isConnectedNetwork()) == true &&
        loginBloc.isValidInfo(_user.text.trim(), _pass.text.trim()) == false) {
      LoadingDialog.hideLoadingDialog(context);
    }
    if ((await Validation.isConnectedNetwork()) == false) {
      Navigator.pop(context);
      MsgDialog.showMsgDialog(
          context, "No network!", "No network connection found");
    }
  }

  Future<String> _getLanguageCode() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('languageCode') == null) {
      return null;
    }
    print('_fetchLocale():' + prefs.getString('languageCode'));
    return prefs.getString('languageCode');
  }

  void _initLanguage() async {
    Future<String> status = _getLanguageCode();
    status.then((result) {
      if (result != null && result.compareTo('en') == 0) {
        setState(() {
          _index = 0;
        });
      }
      if (result != null && result.compareTo('vi') == 0) {
        setState(() {
          _index = 1;
        });
      } else {
        setState(() {
          _index = 0;
        });
      }

      _setupLangList();
    });
  }

  void _setupLangList() {
    setState(() {
      _langList.add(new RadioModel(_index == 0 ? true : false, 'English'));
      _langList.add(new RadioModel(_index == 0 ? false : true, 'VN'));
    });
  }

  void _updateLocale(String lang, String country) async {
    print(lang + ':' + country);

    var prefs = await SharedPreferences.getInstance();
    prefs.setString('languageCode', lang);
    prefs.setString('countryCode', country);

    MyApp.setLocale(context, Locale(lang, country));
  }

  void ShowPass() {
    setState(() {
      _showpass = !_showpass;
    });
  }
}
