import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:thekingcoffee/app/bloc/login_bloc.dart';
import 'package:thekingcoffee/app/config/config.dart';

import 'package:thekingcoffee/app/data/repository/login_repository.dart';
import 'package:thekingcoffee/app/screens/dashboard.dart';
import 'package:thekingcoffee/app/screens/gmail.auth.dart';
import 'package:thekingcoffee/app/screens/signup_dart.dart';

import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/app/validation/validation.dart';
import 'package:thekingcoffee/core/components/lib/change_language/change_language.dart';

import 'package:thekingcoffee/core/components/ui/show_dialog/loading_dialog.dart';
import 'package:thekingcoffee/core/components/ui/show_dialog/show_message_dialog.dart';
import 'package:thekingcoffee/core/utils/utils.dart';

class LoginWithPass extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

bool istap_en = false;
bool istap_vn = true;

class MyAppState extends State<LoginWithPass> {
  int tap_en = 0;
  int tap_vn = 0;

  int _index = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  LoginBloc loginBloc = new LoginBloc();
  bool _showpass = false;
  TextEditingController _user = new TextEditingController();
  TextEditingController _pass = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return WillPopScope(
      onWillPop: () {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      },
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Container(
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
                        child: Text(
                            allTranslations.text("title_name").toString(),
                            style: StylesText.style20Brown),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text("The King Coffee",
                            style: StylesText.style20Brown),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Text(
                            allTranslations.text("title_second").toString(),
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
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.redAccent),
                                    ),
                                    labelText: allTranslations
                                        .text("email")
                                        .toString(),
                                    errorText: snapshot.hasError
                                        ? snapshot.error
                                        : null,
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
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.redAccent),
                                        ),
                                        labelText: allTranslations
                                            .text("password")
                                            .toString(),
                                        errorText: snapshot.hasError
                                            ? snapshot.error
                                            : null,
                                        labelStyle: StylesText.style12Bluegray),
                                  );
                                }),
                            GestureDetector(
                                onTap: ShowPass,
                                child: Text(
                                  _showpass
                                      ? allTranslations
                                          .text("action_enable")
                                          .toString()
                                      : allTranslations
                                          .text("action_disable")
                                          .toString(),
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
                                              builder: (context) =>
                                                  GmailAuth()))
                                    },
                                child: Text(
                                    allTranslations
                                        .text("forget_pass")
                                        .toString(),
                                    style: StylesText.style16Red300Bold),
                              )),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pushReplacement(MaterialPageRoute(
                                          builder: (context) => DashBoard()));
                                },
                                child: Text(
                                    allTranslations.text("skip").toString(),
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
                            child: Text(
                                allTranslations.text("login_button").toString(),
                                style: StylesText.style16While),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
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
                                allTranslations.text("new_account").toString(),
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
                                    allTranslations.text("sign_up").toString(),
                                    style: StylesText.style16Red300Bold,
                                  ))
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Container(
                            height: Dimension.getHeight(0.2),
                            width: Dimension.getWidth(0.5),
                            child: Container(
                              width: Dimension.getWidth(0.5),
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () async {
                                      tap_vn = 0;
                                      if (tap_en == 0) {
                                        await allTranslations
                                            .setNewLanguage('vi');
                                        setState(() {
                                          istap_vn = true;
                                          istap_en = false;
                                        });
                                      }
                                      tap_en++;
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: istap_vn
                                                      ? Colors.redAccent
                                                      : Colors.transparent,
                                                  width: 2.0)),
                                        ),
                                        child: Text(
                                          "Tiếng Việt",
                                          style: istap_vn
                                              ? StylesText
                                                  .style17BrownBoldlRaleway
                                              : StylesText.style18Black,
                                        )),
                                  ),
                                  GestureDetector(
                                      onTap: () async {
                                        tap_en = 0;
                                        if (tap_vn == 0) {
                                          await allTranslations
                                              .setNewLanguage('en');
                                          setState(() {
                                            istap_en = true;
                                            istap_vn = false;
                                          });
                                        }
                                        tap_vn++;
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: istap_en
                                                        ? Colors.redAccent
                                                        : Colors.transparent,
                                                    width: 2.0)),
                                          ),
                                          child: Text(
                                            "English",
                                            style: istap_en
                                                ? StylesText
                                                    .style17BrownBoldlRaleway
                                                : StylesText.style18Black,
                                          )))
                                ],
                              ),
                            )),
                      )
                    ],
                  ),
                )),
          )),
    );
  }

  void onSigninClick() async {
    LoadingDialog.showLoadingDialog(context, "Loading...");
    if ((await Validation.isConnectedNetwork()) == false) {
      Navigator.pop(context);
      MsgDialog.showMsgDialog(
          context, "No network!", "No network connection found");
    }
    if ((await Validation.isConnectedNetwork()) == true &&
        loginBloc.isValidInfo(_user.text.trim(), _pass.text.trim()) == true) {
      LoadingDialog.hideLoadingDialog(context);
      if (await PostLogin(
              _user.text.trim().toString(), _pass.text.trim().toString()) ==
          true) {
        Navigator.of(context, rootNavigator: true).pushReplacement(
            MaterialPageRoute(builder: (context) => DashBoard()));
      }
    }
    if ((await Validation.isConnectedNetwork()) == true &&
        loginBloc.isValidInfo(_user.text.trim(), _pass.text.trim()) == false) {
      LoadingDialog.hideLoadingDialog(context);
    }
  }

  void ShowPass() {
    setState(() {
      _showpass = !_showpass;
    });
  }
}
