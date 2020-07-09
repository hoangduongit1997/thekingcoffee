import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thekingcoffee/src/app/core/components/lib/change_language/change_language.dart';
import 'package:thekingcoffee/src/app/core/components/lib/verifyphone/verification_code_input.dart';
import 'package:thekingcoffee/src/app/core/components/ui/show_dialog/loading_dialog.dart';
import 'package:thekingcoffee/src/app/theme/styles.dart';

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
                            int idUser = prefs.getInt('idUser');
                            String idRequest = prefs.getString('idRequest');
                            if ((await gmailAuthCode(
                                        value, idUser, idRequest)) ==
                                    true &&
                                (await Validation.isConnectedNetwork()) ==
                                    true) {
                              LoadingDialog.hideLoadingDialog(context);
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => ResetPass()));
                            }
                            if ((await gmailAuthCode(
                                        value, idUser, idRequest)) ==
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
