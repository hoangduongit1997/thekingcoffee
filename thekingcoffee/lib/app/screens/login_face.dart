import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:thekingcoffee/app/screens/veryfy_gmail.dart';
import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/core/utils/utils.dart';


class LoginWithFace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.orange,
      ),
      home: MyAppPage(),
    );
  }
}

class MyAppPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyAppPage> {
  bool _showpass = false;
  TextEditingController _user = new TextEditingController();
  TextEditingController _pass = new TextEditingController();
  String _usererror = "Tài khoản không hợp lệ";
  String _passerror = "Mật khẩu không hợp lệ";
  bool _uservalid = false;
  bool _passvalid = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          "Login",
          style: StylesText.style20Brown,
        ),
        leading:
            new IconButton(icon: new Icon(Icons.arrow_back), onPressed: null),
        actions: <Widget>[
          IconButton(
              icon: SvgPicture.asset('assets/images/danger.svg',
                  width: Dimension.getWidth(0.064),
                  height: Dimension.getWidth(0.031)),
              onPressed: null)
        ],
      ),
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
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: TextField(
                    controller: _user,
                    style: StylesText.style18Black,
                    decoration: InputDecoration(
                        labelText: "Email",
                        errorText: _uservalid ? _usererror : null,
                        labelStyle: StylesText.style12Bluegray),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Stack(
                    alignment: AlignmentDirectional.centerEnd,
                    children: <Widget>[
                      TextField(
                        style: StylesText.style18Black,
                        controller: _pass,
                        obscureText: !_showpass,
                        decoration: InputDecoration(
                            labelText: "Password",
                            errorText: _passvalid ? _passerror : null,
                            labelStyle: StylesText.style12Bluegray),
                      ),
                      GestureDetector(
                          onTap: ShowPass,
                          child: Text(_showpass ? "HIDE" : "SHOW",
                              style: StylesText.style12Bluegray))
                    ],
                  ),
                ),
                Row(
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: Text("Forget password?",
                          style: StylesText.style16Red300Bold),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
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
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 35),
                  child: Container(
                    height: Dimension.getHeight(0.02),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "New to Cocook?",
                          style: StylesText.style16Brown,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                  child: Container(
                    height: Dimension.getHeight(0.018),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Sign up with",
                          style: StylesText.style16Brown,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: Dimension.getWidth(0.86),
                          height: Dimension.getHeight(0.063),
                          child: RaisedButton.icon(
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              icon: SvgPicture.asset(
                                  'assets/images/facebook.svg',
                                  width: Dimension.getWidth(0.059),
                                  height: Dimension.getWidth(0.031)),
                              color: Colors.indigo[500],
                              onPressed: () {},
                              label: Text("Facebook",
                                  style: StylesText.style14While)),
                        )
                      ],
                    )),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: Dimension.getWidth(0.86),
                          height: Dimension.getHeight(0.063),
                          child: RaisedButton.icon(
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              icon: SvgPicture.asset(
                                'assets/images/google.svg',
                                width: Dimension.getWidth(0.059),
                                height: Dimension.getWidth(0.031),
                              ),
                              color: Colors.pink,
                              onPressed: () {},
                              label: Text("Google",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14.0))),
                        )
                      ],
                    )),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: Dimension.getWidth(0.86),
                          height: Dimension.getHeight(0.063),
                          child: RaisedButton.icon(
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              icon: SvgPicture.asset(
                                  'assets/images/twitter.svg',
                                  width: Dimension.getWidth(0.059),
                                  height: Dimension.getWidth(0.031)),
                              color: Colors.blue[400],
                              onPressed: () {},
                              label: Text("Twitter",
                                  style: StylesText.style14While)),
                        )
                      ],
                    )),
              ],
            ),
          )),
    );
  }

  void onSigninClick() {
    setState(() {
      Navigator.push(context, MaterialPageRoute(builder: gotohome));
    });
  }

  void ShowPass() {
    setState(() {
      _showpass = !_showpass;
    });
  }

  Widget gotohome(BuildContext context) {
    return VerifyGmail();
  }
}
