import 'package:flutter/material.dart';
import 'package:thekingcoffee/app/bloc/reset_pass_bloc.dart';
import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/core/utils/utils.dart';

class ResetPass extends StatefulWidget {
  ResetPass({Key key}) : super(key: key);

  _ResetPassState createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  ResetPassBloc resetpass = new ResetPassBloc();
  TextEditingController _pass = new TextEditingController();
  TextEditingController _confirm = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              constraints: BoxConstraints.expand(),
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                      child: Text("Reset Your Password",
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
                                  labelText: "Password",
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
                                      labelText: "Retype Password",
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
                          child: Text("Submit", style: StylesText.style16While),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          onPressed: onSigninClick,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  void onSigninClick() {}
}
