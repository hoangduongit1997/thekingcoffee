import 'package:flutter/material.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/app/screens/dashboard.dart';
import 'package:thekingcoffee/app/screens/helper/dashboard_helper/placeholder_home.dart';
import 'package:thekingcoffee/app/screens/map.dart';
import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/core/components/ui/draw_left/draw_left.dart';

class Favorite_Page extends StatefulWidget {
  Favorite_Page({Key key}) : super(key: key);

  Shopping_ListState createState() => Shopping_ListState();
}

class Shopping_ListState extends State<Favorite_Page> {
  @override
  void initState() {
    Config.current_botton_tab = 1;
    super.initState();
  }

  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController name = new TextEditingController(text: "Hoàng Dương");
  TextEditingController phone = new TextEditingController(text: "0798353751");
  TextEditingController address =
      new TextEditingController(text: "196/31/8, Tan Son Nhi");
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.redAccent),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: FlatButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => DashBoard()));
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.brown,
              )),
          backgroundColor: Colors.white,
          title: Text(
            "Favorites",
            style: StylesText.style20BrownBold,
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    "Shipment Details",
                    style: StylesText.style18Black,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextField(
                      decoration:
                          InputDecoration(icon: Icon(Icons.account_circle)),
                      controller: name,
                      style: StylesText.style16Brown,
                    )),
                Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextField(
                      decoration: InputDecoration(icon: Icon(Icons.phone)),
                      controller: phone,
                      style: StylesText.style16Brown,
                    )),
                Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextField(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MapPage()));
                      },
                      decoration: InputDecoration(icon: Icon(Icons.map)),
                      controller: address,
                      style: StylesText.style16Brown,
                    )),
              ],
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
