import 'package:flutter/material.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/app/screens/dashboard.dart';
import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/core/components/ui/draw_left/draw_left.dart';

class Setting extends StatefulWidget {
  Setting({Key key}) : super(key: key);

  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Setting",
          style: StylesText.style20BrownBold,
        ),
        leading: FlatButton(
            onPressed: () {
              Config.current_botton_tab = 0;
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => DashBoard()));
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.brown,
            )),
      ),
      body: Container(
        padding: const EdgeInsets.all(2.0),
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          children: <Widget>[
            Card(
      child: ListTile(
        
        leading: FlutterLogo(),
        title: Text('One-line with both widgets'),
        trailing: Icon(Icons.more_vert),
      ),
    ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
      drawer: Drawer(
        child: HomeMenu(),
      ),
    );
  }
}
