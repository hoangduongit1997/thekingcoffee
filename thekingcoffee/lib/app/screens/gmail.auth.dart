import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thekingcoffee/app/bloc/gmail_auth_bloc.dart';
import 'package:thekingcoffee/app/data/repository/sendcodetogamil.dart';
import 'package:thekingcoffee/app/screens/veryfy_gmail.dart';

import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/app/validation/validation.dart';
import 'package:thekingcoffee/core/components/ui/show_dialog/loading_dialog.dart';
import 'package:thekingcoffee/core/components/ui/show_dialog/show_message_dialog.dart';
import 'package:thekingcoffee/core/utils/utils.dart';

class GmailAuth extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return VerifyPhonePageSate();
  }
}

class VerifyPhonePageSate extends State<GmailAuth> {
  bool _loading = false;
  GmailAuthBloc resetPassBloc = new GmailAuthBloc();
  TextEditingController _gmail = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.orange,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                    padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
                    child: Text("Forget password?",
                        style: StylesText.style24BrownBold),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Text("Enter your email to continute",
                        style: StylesText.style16BrownBold),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: StreamBuilder<Object>(
                          stream: resetPassBloc.gmailStream,
                          builder: (context, snapshot) {
                            return TextField(
                              controller: _gmail,
                              style: StylesText.style18Black,
                              decoration: InputDecoration(
                                  labelText: "Email",
                                  errorText:
                                      snapshot.hasError ? snapshot.error : null,
                                  labelStyle: StylesText.style12Bluegray),
                            );
                          })),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: SizedBox(
                      width: Dimension.getWidth(0.86),
                      height: Dimension.getHeight(0.063),
                      child: RaisedButton(
                        color: Colors.red[300],
                        child: Text(
                          "Submit",
                          style: StylesText.style16While,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        onPressed: onSubmitClick,
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  void onSubmitClick() async {
    LoadingDialog.showLoadingDialog(context, "Loading...");
    if ((await Validation.isConnectedNetwork()) == true &&
        resetPassBloc.isValidInfo(_gmail.text.trim().toString()) == true) {
      if ((await SendCodeToGmail(_gmail.text.trim().toString())) == true) {
        LoadingDialog.hideLoadingDialog(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => VerifyGmail()));
      }
    }
    if ((await Validation.isConnectedNetwork()) &&
        resetPassBloc.isValidInfo(_gmail.text.trim().toString()) == false) {
      LoadingDialog.hideLoadingDialog(context);
    }

    if ((await Validation.isConnectedNetwork()) == false) {
      LoadingDialog.hideLoadingDialog(context);
      MsgDialog.showMsgDialog(
          context, "No network!", "No network connection found");
    }
  }
}