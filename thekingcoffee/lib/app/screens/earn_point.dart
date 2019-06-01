import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:barcode_generator/barcode_generator.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/app/screens/dashboard.dart';
import 'package:thekingcoffee/app/screens/helper/dashboard_helper/placeholder_home.dart';
import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/core/components/ui/draw_left/draw_left.dart';

class EarnPoint extends StatefulWidget {
  EarnPoint({Key key}) : super(key: key);

  _EarnPointState createState() => _EarnPointState();
}

class _EarnPointState extends State<EarnPoint> {
  String id_user;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  get_Id_User() async {
    final pref = await SharedPreferences.getInstance();
    id_user = pref.getInt('id_user').toString();
  }

  @override
  Future initState() {
    get_Id_User();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Your code", style: StylesText.style20BrownBold),
          elevation: 0.5,
          backgroundColor: Colors.white,
          leading: FlatButton(
              onPressed: () {
                // Navigator.of(context, rootNavigator: true)
                //     .push(MaterialPageRoute(builder: (context) => DashBoard()));
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.brown,
              )),
        ),
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: id_user == null
                ? CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation(Colors.redAccent),
                  )
                : BarcodeGenerator(
                    witdth: 350,
                    height: 350,
                    backgroundColor: Colors.grey[300],
                    fromString: id_user.toString(),
                    codeType: BarCodeType.kBarcodeFormatQRCode,
                  ),
          ),
        ),
        drawer: Drawer(
          child: HomeMenu(),
        ),
      ),
    );
  }
}
