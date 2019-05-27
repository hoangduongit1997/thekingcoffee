import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thekingcoffee/app/bloc/login_bloc.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/app/data/repository/login_repository.dart';
import 'package:thekingcoffee/app/screens/dashboard.dart';
import 'package:thekingcoffee/app/screens/gmail.auth.dart';
import 'package:thekingcoffee/app/screens/signup_dart.dart';
import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/app/validation/validation.dart';
import 'package:thekingcoffee/core/components/ui/show_dialog/loading_dialog.dart';
import 'package:thekingcoffee/core/components/ui/show_dialog/show_message_dialog.dart';
import 'package:thekingcoffee/core/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginWithPass extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<LoginWithPass> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    Config.isHideNavigation = true;
    super.initState();
  }

  LoginBloc loginBloc = new LoginBloc();
  bool _showpass = false;
  TextEditingController _user = new TextEditingController();
  TextEditingController _pass = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.orange,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
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
                    child: Text("Welcome to", style: StylesText.style20Brown),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child:
                        Text("The King Coffee", style: StylesText.style20Brown),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Text("Sign in to continute",
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
                              _showpass ? "HIDE" : "SHOW",
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
                            child: Text("Forget password?",
                                style: StylesText.style16Red300Bold),
                          )),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: GestureDetector(
                            onTap: () async {
                              Config.islogin = 0;
                              final prefs =
                                  await SharedPreferences.getInstance();
                              prefs.clear();

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DashBoard()));
                            },
                            child: Text("Skip",
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
                        child: Text("Login", style: StylesText.style16While),
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
                            "New account?  ",
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
                                "Sign up",
                                style: StylesText.style16Red300Bold,
                              ))
                        ],
                      ),
                    ),
                  )
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
        Config.islogin = 1;
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => DashBoard()));
      }
      if (loginBloc.isValidInfo(_user.text.trim(), _pass.text.trim()) ==
              false &&
          (await Validation.isConnectedNetwork()) == true) {
        LoadingDialog.hideLoadingDialog(context);
      }
    }
    if ((await Validation.isConnectedNetwork()) == false) {
      LoadingDialog.hideLoadingDialog(context);
      MsgDialog.showMsgDialog(
          context, "No network!", "No network connection found");
    }
  }

  void ShowPass() {
    setState(() {
      _showpass = !_showpass;
    });
  }
}
