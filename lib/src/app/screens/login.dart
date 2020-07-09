import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:thekingcoffee/app/bloc/login_bloc.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/app/data/repository/login_repository.dart';
import 'package:thekingcoffee/app/screens/customWebView.dart';
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
    return LoginState();
  }
}

bool isTapEn = false;
bool isTapVn = true;

class LoginState extends State<LoginWithPass> {
  int tapEn = 0;
  int tapVn = 0;
  String yourClientId = "276563053543011";
  String yourRedirectUrl =
      "https://thekingcoffee-49a91.firebaseapp.com/__/auth/handler";
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
  void dispose() {
    loginBloc.dispose();
    super.dispose();
  }

  Future<bool> onWillPop() async {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: GestureDetector(
            onTap: () async {
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
                                onTap: showPass,
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
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => GmailAuth()));
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
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignUp()));
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
                        child: FlatButton.icon(
                            color: Colors.blue,
                            onPressed: () async {
                              await loginWithFacebook();
                            },
                            icon: Icon(Icons.face),
                            label: Text('Login with Facebook')),
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
                                      tapVn = 0;
                                      if (tapEn == 0) {
                                        await allTranslations
                                            .setNewLanguage('vi');
                                        setState(() {
                                          isTapVn = true;
                                          isTapEn = false;
                                        });
                                      }
                                      tapEn++;
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: isTapVn
                                                      ? Colors.redAccent
                                                      : Colors.transparent,
                                                  width: 2.0)),
                                        ),
                                        child: Text(
                                          "Tiếng Việt",
                                          style: isTapVn
                                              ? StylesText
                                                  .style17BrownBoldlRaleway
                                              : StylesText.style18Black,
                                        )),
                                  ),
                                  GestureDetector(
                                      onTap: () async {
                                        tapEn = 0;
                                        if (tapVn == 0) {
                                          await allTranslations
                                              .setNewLanguage('en');
                                          setState(() {
                                            isTapEn = true;
                                            isTapVn = false;
                                          });
                                        }
                                        tapVn++;
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: isTapEn
                                                        ? Colors.redAccent
                                                        : Colors.transparent,
                                                    width: 2.0)),
                                          ),
                                          child: Text(
                                            "English",
                                            style: isTapEn
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
    LoadingDialog.showLoadingDialog(
        context, allTranslations.text("splash_screen").toString());
    if ((await Validation.isConnectedNetwork()) == false) {
      Navigator.pop(context);
      MsgDialog.showMsgDialog(
          context,
          allTranslations.text("title_no_netword").toString(),
          allTranslations.text("no_network").toString());
    }
    if ((await Validation.isConnectedNetwork()) == true &&
        loginBloc.isValidInfo(_user.text.trim(), _pass.text.trim()) == true) {
      LoadingDialog.hideLoadingDialog(context);
      if (await postLogin(
              _user.text.trim().toString(), _pass.text.trim().toString()) ==
          true) {
        Config.isLogin = true;
        Navigator.of(context, rootNavigator: true).pushReplacement(
            MaterialPageRoute(builder: (context) => DashBoard()));
      }
    }
    if ((await Validation.isConnectedNetwork()) == true &&
        loginBloc.isValidInfo(_user.text.trim(), _pass.text.trim()) == false) {
      LoadingDialog.hideLoadingDialog(context);
    }
  }

  void showPass() {
    setState(() {
      _showpass = !_showpass;
    });
  }

  Future loginWithFacebook() async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomWebView(
          selectedUrl:
              'https://www.facebook.com/dialog/oauth?client_id=$yourClientId&redirect_uri=$yourRedirectUrl&response_type=token&scope=email,public_profile,',
        ),
      ),
    );
    print('$result');
    await signInWithFacebook(result);
  }

  Future<void> signInWithFacebook(String token) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    final AuthCredential credential = FacebookAuthProvider.getCredential(
      accessToken: token,
    );
    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    if (user != null) {
      print('Successfully signed in with Facebook. ' + user.uid);
    } else {
      print('Failed to sign in with Facebook. ');
    }
  }
}
