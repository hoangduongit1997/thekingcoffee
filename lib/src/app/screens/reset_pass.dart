import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thekingcoffee/src/app/core/components/lib/change_language/change_language.dart';
import 'package:thekingcoffee/src/app/core/components/widgets/show_dialog/loading_dialog.dart';
import 'package:thekingcoffee/src/app/core/components/widgets/show_dialog/show_message_dialog.dart';
import 'package:thekingcoffee/src/app/core/config.dart';
import 'package:thekingcoffee/src/app/core/utils.dart';
import 'package:thekingcoffee/src/app/core/validation.dart';
import 'package:thekingcoffee/src/app/screens/login.dart';
import 'package:thekingcoffee/src/app/streams/reset_pass_bloc.dart';
import 'package:thekingcoffee/src/app/theme/styles.dart';

class ResetPass extends StatefulWidget {
  ResetPass({Key key}) : super(key: key);

  _ResetPassState createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  ResetPassBloc resetpass = new ResetPassBloc();
  TextEditingController _pass = new TextEditingController();
  TextEditingController _confirm = new TextEditingController();
  @override
  void dispose() {
    resetpass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              constraints: BoxConstraints.expand(),
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                      child: Text(
                          allTranslations.text("reset_your_pass").toString(),
                          style: StylesText.style20Brown),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: StreamBuilder<Object>(
                          stream: resetpass.passStream,
                          builder: (context, snapshot) {
                            return TextField(
                              controller: _pass,
                              obscureText: true,
                              style: StylesText.style18Black,
                              decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.redAccent),
                                  ),
                                  labelText: allTranslations.text("password"),
                                  errorText:
                                      snapshot.hasError ? snapshot.error : null,
                                  labelStyle: StylesText.style12Bluegray),
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Stack(
                        alignment: AlignmentDirectional.centerEnd,
                        children: <Widget>[
                          StreamBuilder<Object>(
                              stream: resetpass.confirmStream,
                              builder: (context, snapshot) {
                                return TextField(
                                  style: StylesText.style18Black,
                                  controller: _confirm,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.redAccent),
                                      ),
                                      labelText: allTranslations
                                          .text("retype_pass")
                                          .toString(),
                                      errorText: snapshot.hasError
                                          ? snapshot.error
                                          : null,
                                      labelStyle: StylesText.style12Bluegray),
                                );
                              }),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: SizedBox(
                        width: Dimension.getWidth(0.86),
                        height: Dimension.getHeight(0.063),
                        child: RaisedButton(
                          color: Colors.red[300],
                          child: Text(allTranslations.text("submit").toString(),
                              style: StylesText.style16While),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          onPressed: onSubmitClick,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ));
  }

  void onSubmitClick() async {
    LoadingDialog.showLoadingDialog(
        context, allTranslations.text("splash_screen").toString());
    final prefs = await SharedPreferences.getInstance()
        .timeout(const Duration(seconds: 4));
    String code = prefs.getString('code');
    int idUser = prefs.getInt('idUser');
    String idRequest = prefs.getString('idRequest');
    if ((await Validation.isConnectedNetwork()) == true &&
        resetpass.isValidInfo(_pass.text.trim().toString(),
                _confirm.text.trim().toString()) ==
            true) {
      if ((await api.reSetPassRes(
              code, idUser, idRequest, _pass.text.trim())) ==
          true) {
        LoadingDialog.hideLoadingDialog(context);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginWithPass()));
      }
    }
    if ((await Validation.isConnectedNetwork()) == true &&
        resetpass.isValidInfo(_pass.text.trim().toString(),
                _confirm.text.trim().toString()) ==
            false) {
      LoadingDialog.hideLoadingDialog(context);
    }
    if ((await Validation.isConnectedNetwork()) == false) {
      LoadingDialog.hideLoadingDialog(context);
      MsgDialog.showMsgDialog(
          context,
          allTranslations.text("title_no_netword").toString(),
          allTranslations.text("no_network").toString());
    }
  }
}
