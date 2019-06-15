import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:thekingcoffee/app/bloc/signup_bloc.dart';
import 'package:thekingcoffee/app/data/repository/signup_reposotory.dart';
import 'package:thekingcoffee/app/screens/login.dart';
import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/app/validation/validation.dart';
import 'package:thekingcoffee/core/components/lib/change_language/change_language.dart';
import 'package:thekingcoffee/core/components/ui/show_dialog/loading_dialog.dart';
import 'package:thekingcoffee/core/components/ui/show_dialog/show_message_dialog.dart';
import 'package:thekingcoffee/core/utils/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignUpState();
  }
}

class SignUpState extends State<SignUp> {
  SignupBloc signupBloc = new SignupBloc();

  bool _showpass = false;
  bool checked = false;
  TextEditingController _name = new TextEditingController();
  TextEditingController _phone = new TextEditingController();
  TextEditingController _pass = new TextEditingController();
  TextEditingController _confirmpass = new TextEditingController();
  TextEditingController _date = new TextEditingController();
  TextEditingController _fullname = new TextEditingController();
  TextEditingController _gmail = new TextEditingController();
  final formats = {
    InputType.date: DateFormat('dd/MM/yyyy'),
  };
  InputType inputType = InputType.date;
  DateTime date;
  @override
  void dispose() {
    signupBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text(
            allTranslations.text("register").toString(),
            style: StylesText.style20BrownBold,
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.brown),
            onPressed: () => Navigator.pop(context),
          ),
          actions: <Widget>[
            IconButton(
                icon: SvgPicture.asset('assets/images/danger.svg',
                    width: Dimension.getWidth(0.04),
                    height: Dimension.getWidth(0.04)),
                onPressed: null)
          ],
        ),
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
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: StreamBuilder<Object>(
                          stream: signupBloc.usernameStream,
                          builder: (context, snapshot) {
                            return TextField(
                              controller: _name,
                              style: StylesText.style18Black,
                              decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.redAccent),
                                  ),
                                  labelText: allTranslations
                                      .text("user_name")
                                      .toString(),
                                  errorText:
                                      snapshot.hasError ? snapshot.error : null,
                                  labelStyle: StylesText.style12Bluegray),
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: StreamBuilder<Object>(
                          stream: signupBloc.passStream,
                          builder: (context, snapshot) {
                            return TextField(
                              style: StylesText.style18Black,
                              controller: _pass,
                              obscureText: !_showpass,
                              decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.redAccent),
                                  ),
                                  labelText: allTranslations
                                      .text("password")
                                      .toString(),
                                  errorText:
                                      snapshot.hasError ? snapshot.error : null,
                                  labelStyle: StylesText.style12Bluegray),
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: StreamBuilder<Object>(
                          stream: signupBloc.confirmStream,
                          builder: (context, snapshot) {
                            return TextField(
                              style: StylesText.style18Black,
                              controller: _confirmpass,
                              obscureText: !_showpass,
                              decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.redAccent),
                                  ),
                                  labelText: allTranslations
                                      .text("retype_pass")
                                      .toString(),
                                  errorText:
                                      snapshot.hasError ? snapshot.error : null,
                                  labelStyle: StylesText.style12Bluegray),
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: StreamBuilder<Object>(
                          stream: signupBloc.phoneStream,
                          builder: (context, snapshot) {
                            return TextField(
                              controller: _phone,
                              style: StylesText.style18Black,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.redAccent),
                                  ),
                                  labelText: allTranslations
                                      .text("phone_number")
                                      .toString(),
                                  errorText:
                                      snapshot.hasError ? snapshot.error : null,
                                  labelStyle: StylesText.style12Bluegray),
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: StreamBuilder<Object>(
                          stream: signupBloc.gmailStream,
                          builder: (context, snapshot) {
                            return TextField(
                              controller: _gmail,
                              style: StylesText.style18Black,
                              decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.redAccent),
                                  ),
                                  labelText: "Email",
                                  errorText:
                                      snapshot.hasError ? snapshot.error : null,
                                  labelStyle: StylesText.style12Bluegray),
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: StreamBuilder<Object>(
                          stream: signupBloc.fullnameStream,
                          builder: (context, snapshot) {
                            return TextField(
                              controller: _fullname,
                              style: StylesText.style18Black,
                              decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.redAccent),
                                  ),
                                  labelText: allTranslations
                                      .text("full_name")
                                      .toString(),
                                  errorText:
                                      snapshot.hasError ? snapshot.error : null,
                                  labelStyle: StylesText.style12Bluegray),
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: StreamBuilder<Object>(
                          stream: signupBloc.dateStream,
                          builder: (context, snapshot) {
                            return DateTimePickerFormField(
                              inputType: inputType,
                              controller: _date,
                              format: formats[inputType],
                              editable: false,
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.redAccent),
                                ),
                                labelText: allTranslations
                                    .text("date_of_birth")
                                    .toString(),
                                errorText:
                                    snapshot.hasError ? snapshot.error : null,
                                labelStyle: StylesText.style12Bluegray,
                                hasFloatingPlaceholder: false,
                              ),
                              onChanged: (dt) => setState(() => date = dt),
                            );
                          }),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: CheckboxListTile(
                          title: Text(
                              allTranslations.text("accept_terms").toString()),
                          value: checked,
                          activeColor: Colors.red[300],
                          onChanged: (bool value) {
                            setState(() {
                              checked = value;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: SizedBox(
                        width: Dimension.getWidth(0.86),
                        height: Dimension.getHeight(0.063),
                        child: RaisedButton(
                          color: Colors.red[300],
                          child: Text(
                              allTranslations.text("sign_up").toString(),
                              style: StylesText.style16While),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          onPressed: onSignupClick,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ));
  }

  void onSignupClick() async {
    LoadingDialog.showLoadingDialog(
        context, allTranslations.text("splash_screen").toString());
    if ((await Validation.isConnectedNetwork()) == true &&
        signupBloc.isValidInfo(
              _name.text.trim(),
              _phone.text.trim(),
              _pass.text.trim(),
              _confirmpass.text.trim(),
              _date.text.trim(),
              checked,
              _fullname.text.trim(),
              _gmail.text.trim(),
            ) ==
            true) {
      if ((await PostSignUp(
              _name.text.trim().toString(),
              _pass.text.trim().toString(),
              _phone.text.trim().toString(),
              _date.text.toString(),
              _fullname.text.trim().toString(),
              _gmail.text.trim().toString())) ==
          true) {
        LoadingDialog.hideLoadingDialog(context);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginWithPass()));
      }
    }
    if ((await Validation.isConnectedNetwork()) == true &&
        signupBloc.isValidInfo(
                _name.text.trim(),
                _phone.text.trim(),
                _pass.text.trim(),
                _confirmpass.text.trim(),
                _date.text.trim(),
                checked,
                _fullname.text.trim(),
                _gmail.text.trim()) ==
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
