import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:thekingcoffee/app/bloc/signup_bloc.dart';
import 'package:thekingcoffee/app/data/repository/login_repository.dart';
import 'package:thekingcoffee/app/data/repository/signup_reposotory.dart';
import 'package:thekingcoffee/app/screens/dashboard.dart';
import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/app/validation/validation.dart';
import 'package:thekingcoffee/core/components/ui/show_dialog/loading_dialog.dart';
import 'package:thekingcoffee/core/components/ui/show_dialog/show_message_dialog.dart';
import 'package:thekingcoffee/core/utils/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<SignUp> {
  SignupBloc signupBloc = new SignupBloc();
  bool _showpass = false;
  bool checked = false;
  TextEditingController _name = new TextEditingController();
  TextEditingController _phone = new TextEditingController();
  TextEditingController _pass = new TextEditingController();
  TextEditingController _confirmpass = new TextEditingController();
  TextEditingController _date = new TextEditingController();
  final formats = {
    InputType.date: DateFormat('dd/MM/yyyy'),
  };
  InputType inputType = InputType.date;
  DateTime date;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.orange,
        ),
        home: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            title: Text(
              "Register",
              style: StylesText.style20BrownBold,
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, true),
            ),
            actions: <Widget>[
              IconButton(
                  icon: SvgPicture.asset('assets/images/danger.svg',
                      width: Dimension.getWidth(0.064),
                      height: Dimension.getWidth(0.031)),
                  onPressed: null)
            ],
          ),
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
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: StreamBuilder<Object>(
                          stream: signupBloc.nameStream,
                          builder: (context, snapshot) {
                            return TextField(
                              controller: _name,
                              style: StylesText.style18Black,
                              decoration: InputDecoration(
                                  labelText: "Name",
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
                                  labelText: "Phone number",
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
                                  labelText: "Password",
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
                                  labelText: "Confirm Password",
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
                                labelText: 'Date of birth',
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
                          title: Text("Accept terms & conditions"),
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
                          child:
                              Text("Sign up", style: StylesText.style16While),
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
    LoadingDialog.showLoadingDialog(context, "Loading...");
    if ((await Validation.isConnectedNetwork()) == true &&
        signupBloc.isValidInfo(
                _name.text.trim(),
                _phone.text.trim(),
                _pass.text.trim(),
                _confirmpass.text.trim(),
                _date.text.trim(),
                checked) ==
            true) {
      if ((await PostSignUp(
              _name.text.trim().toString(),
              _pass.text.trim().toString(),
              _phone.text.trim().toString(),
              _date.text.toString())) ==
          true) {
        LoadingDialog.hideLoadingDialog(context);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => DashBoard()));
      }
    }
    if ((await Validation.isConnectedNetwork()) == true &&
        signupBloc.isValidInfo(
                _name.text.trim(),
                _phone.text.trim(),
                _pass.text.trim(),
                _confirmpass.text.trim(),
                _date.text.trim(),
                checked) ==
            false) {
      LoadingDialog.hideLoadingDialog(context);
    }
    if ((await Validation.isConnectedNetwork()) == false) {
      LoadingDialog.hideLoadingDialog(context);
      MsgDialog.showMsgDialog(
          context, "No network!", "No network connection found");
    }
  }
}