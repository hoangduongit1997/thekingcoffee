import 'package:flutter/material.dart';
import 'package:thekingcoffee/app/data/repository/gmail_auth.dart';
import 'package:thekingcoffee/app/screens/reset_pass.dart';
import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/app/validation/validation.dart';
import 'package:thekingcoffee/core/components/lib/change_language/change_language.dart';
import 'package:thekingcoffee/core/components/lib/verifyphone/verification_code_input.dart';
import 'package:thekingcoffee/core/components/ui/show_dialog/loading_dialog.dart';
import 'package:thekingcoffee/core/components/ui/show_dialog/show_message_dialog.dart';
import 'package:thekingcoffee/core/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyGmail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return VerifyPhonePageSate();
  }
}

class VerifyPhonePageSate extends State<VerifyGmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
                      child: Text(allTranslations.text("very_mail").toString(),
                          style: StylesText.style24BrownBold),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Text(
                          allTranslations.text("very_mail_title").toString(),
                          style: StylesText.style16BrownBold),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 120, 0, 20),
                        child: new VerificationCodeInput(
                          keyboardType: TextInputType.number,
                          length: 6,
                          onCompleted: (String value) async {
                            LoadingDialog.showLoadingDialog(
                                context,
                                allTranslations
                                    .text("splash_screen")
                                    .toString());
                            final prefs = await SharedPreferences.getInstance()
                                .timeout(const Duration(seconds: 4));
                            prefs.setString('code', value);
                            int id_user = prefs.getInt('id_user');
                            String id_request = prefs.getString('id_request');
                            if ((await Gmail_Auth_Code(
                                        value, id_user, id_request)) ==
                                    true &&
                                (await Validation.isConnectedNetwork()) ==
                                    true) {
                              LoadingDialog.hideLoadingDialog(context);
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => ResetPass()));
                            }
                            if ((await Gmail_Auth_Code(
                                        value, id_user, id_request)) ==
                                    false &&
                                (await Validation.isConnectedNetwork()) ==
                                    true) {
                              LoadingDialog.hideLoadingDialog(context);
                            }
                            if ((await Validation.isConnectedNetwork()) ==
                                false) {
                              LoadingDialog.hideLoadingDialog(context);
                              MsgDialog.showMsgDialog(
                                  context,
                                  allTranslations
                                      .text("title_no_netword")
                                      .toString(),
                                  allTranslations
                                      .text("no_network")
                                      .toString());
                            }
                          },
                        )),
                  ],
                ),
              )),
        ));
  }
}
