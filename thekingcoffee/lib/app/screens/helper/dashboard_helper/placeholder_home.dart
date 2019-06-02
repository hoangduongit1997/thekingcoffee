import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

import 'package:thekingcoffee/app/data/model/radiomodel.dart';

import 'package:thekingcoffee/app/data/repository/get_coffee_products.dart';

import 'package:thekingcoffee/app/data/repository/get_drinking_products.dart';
import 'package:thekingcoffee/app/data/repository/get_food_products.dart';
import 'package:thekingcoffee/app/data/repository/get_new_products.dart';
import 'package:thekingcoffee/app/data/repository/get_tea_products.dart';
import 'package:thekingcoffee/app/screens/find_food.dart';

import 'package:thekingcoffee/app/screens/see_all_product.dart';

import 'package:thekingcoffee/app/styles/styles.dart';

import 'package:thekingcoffee/core/components/ui/draw_left/draw_left.dart';
import 'package:thekingcoffee/core/components/ui/home_cart/home_cart_coffee.dart';
import 'package:thekingcoffee/core/components/ui/home_cart/home_cart_drinking.dart';
import 'package:thekingcoffee/core/components/ui/home_cart/home_cart_food.dart';
import 'package:thekingcoffee/core/components/ui/home_cart/home_cart_tea.dart';
import 'package:thekingcoffee/core/components/ui/slider_card/new_products_slider.dart';
import 'package:thekingcoffee/core/utils/utils.dart';
import 'package:http/http.dart' as http;

class PlaceholderMainWidget extends StatefulWidget {
  const PlaceholderMainWidget();
  @override
  State<StatefulWidget> createState() {
    return PlaceholderMainWidgetState();
  }
}

var list_new_products = [];
var list_coffee = [];
var list_tea = [];
var list_food = [];
var list_drinking = [];
var list_all_product = [];

class PlaceholderMainWidgetState extends State<PlaceholderMainWidget> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<RadioModel> _langList = new List<RadioModel>();
  int _index = 0;
  intDataHomeSlider() async {
    final result = await Get_New_Products();
    final coffee = await Is_Has_Coffee_Product();
    final tea = await Is_Have_Tea_Products();
    final food = await Is_Have_Food_Products();
    final drinking = await Is_Have_Drinking_Products();
    if (this.mounted) {
      setState(() {
        list_new_products = result;
        list_coffee = coffee;
        list_tea = tea;
        list_food = food;
        list_drinking = drinking;
      });
    }
  }

  @override
  void initState() {
    intDataHomeSlider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.redAccent),
        home: Scaffold(
          resizeToAvoidBottomPadding: false,
          key: _scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
            title: Text("Home", style: StylesText.style20BrownBold),
            leading: FlatButton(
                onPressed: () {
                  _scaffoldKey.currentState.openDrawer();
                },
                child: Icon(Icons.menu, color: Colors.brown)),
            backgroundColor: Colors.white,
            elevation: 0.8,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                color: Colors.brown,
                splashColor: Colors.brown,
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => FindFood()));
                },
              )
            ],
          ),
          resizeToAvoidBottomInset: false,
          body: RefreshIndicator(
            backgroundColor: Colors.white,
            color: Colors.redAccent,
            child: Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                constraints: BoxConstraints.expand(),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text("All catalogues",
                            style: StylesText.style20BrownNomorlRaleway),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Container(
                            height: Dimension.getHeight(0.03),
                            width: double.infinity,
                            padding:
                                const EdgeInsets.only(left: 5.0, right: 20.0),
                            decoration: BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                              color: Colors.redAccent,
                              width: Dimension.getWidth(0.005),
                            ))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("New product",
                                    style: StylesText.style17BrownBoldlRaleway),
                              ],
                            ),
                          )),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Center(
                            child: Container(
                                width: double.infinity,
                                height: Dimension.getHeight(0.29),
                                child: Center(
                                  child: list_new_products == null ||
                                          list_new_products.length == 0
                                      ? Container(
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  new AlwaysStoppedAnimation<
                                                      Color>(Colors.redAccent),
                                            ),
                                          ),
                                        )
                                      : CarouselDemo(),
                                )),
                          )),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Container(
                            height: Dimension.getHeight(0.03),
                            padding:
                                const EdgeInsets.only(left: 5.0, right: 20.0),
                            decoration: BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                              color: Colors.redAccent,
                              width: 2.0,
                            ))),
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Coffee",
                                    style: StylesText.style17BrownBoldlRaleway),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  See_All_Product(
                                                      "All Coffee", 2)));
                                    },
                                    child: Text("See all",
                                        style: StylesText.style15RedAccentBold))
                              ],
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Container(
                            color: Colors.white,
                            height: Dimension.getHeight(0.36),
                            width: double.infinity,
                            child: Center(
                              child: list_coffee == null ||
                                      list_coffee.length == 0
                                  ? Container(
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              new AlwaysStoppedAnimation<Color>(
                                                  Colors.redAccent),
                                        ),
                                      ),
                                    )
                                  : Home_Card_Coffee(),
                            )),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Container(
                            height: Dimension.getHeight(0.03),
                            padding:
                                const EdgeInsets.only(left: 5.0, right: 20.0),
                            decoration: BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                              color: Colors.redAccent,
                              width: 2.0,
                            ))),
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Tea",
                                    style: StylesText.style17BrownBoldlRaleway),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  See_All_Product(
                                                      "All Tea", 4)));
                                    },
                                    child: Text("See all",
                                        style: StylesText.style15RedAccentBold))
                              ],
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Container(
                            height: Dimension.getHeight(0.36),
                            width: double.infinity,
                            child: list_tea == null || list_tea.length == 0
                                ? Container(
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                                Colors.redAccent),
                                      ),
                                    ),
                                  )
                                : Home_Card_Tea()),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Container(
                            height: Dimension.getHeight(0.03),
                            padding:
                                const EdgeInsets.only(left: 5.0, right: 20.0),
                            decoration: BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                              color: Colors.redAccent,
                              width: 2.0,
                            ))),
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Drinking",
                                    style: StylesText.style17BrownBoldlRaleway),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  See_All_Product(
                                                      "All Drinking", 1)));
                                    },
                                    child: Text("See all",
                                        style: StylesText.style15RedAccentBold))
                              ],
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Container(
                            height: Dimension.getHeight(0.36),
                            width: double.infinity,
                            child: list_drinking == null ||
                                    list_drinking.length == 0
                                ? Container(
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                                Colors.redAccent),
                                      ),
                                    ),
                                  )
                                : Home_Card_Drinking()),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Container(
                            height: Dimension.getHeight(0.03),
                            padding:
                                const EdgeInsets.only(left: 5.0, right: 20.0),
                            decoration: BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                              color: Colors.redAccent,
                              width: 2.0,
                            ))),
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Food",
                                    style: StylesText.style17BrownBoldlRaleway),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  See_All_Product(
                                                      "All Food", 3)));
                                    },
                                    child: Text("See all",
                                        style: StylesText.style15RedAccentBold))
                              ],
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                        child: Container(
                          height: Dimension.getHeight(0.36),
                          width: double.infinity,
                          child: list_food == null || list_food.length == 0
                              ? Container(
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      valueColor:
                                          new AlwaysStoppedAnimation<Color>(
                                              Colors.redAccent),
                                    ),
                                  ),
                                )
                              : Home_Card_Food(),
                        ),
                      )
                    ],
                  ),
                )),
            onRefresh: refreshPage,
          ),
          drawer: Drawer(
            child: HomeMenu(),
          ),
        ));
  }

  Future<void> refreshPage() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      initState();
    });
  }
}
