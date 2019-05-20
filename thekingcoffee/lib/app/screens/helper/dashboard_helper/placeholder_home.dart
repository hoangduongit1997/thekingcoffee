import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/app/data/repository/get_data_all_product.dart';
import 'package:thekingcoffee/app/data/repository/get_new_products.dart';
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

class PlaceholderMainWidgetState extends State<PlaceholderMainWidget> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  intDataHomeSlider() async {
    final result = await Get_New_Products();
    setState(() {
      list_new_products = result;
    });
  }

  @override
  void initState() {
    Config.current_botton_tab = 0;
    this.intDataHomeSlider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return list_new_products.length == 0 || list_new_products == null
        ? Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.redAccent),
            ),
          )
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primaryColor: Colors.orangeAccent),
            home: Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
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
                    onPressed: onsearchbutton,
                  )
                ],
              ),
              resizeToAvoidBottomInset: false,
              body: Container(
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
                          child: Text("All Catalogues",
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("New product",
                                      style:
                                          StylesText.style17BrownBoldlRaleway),
                                ],
                              ),
                            )),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: Center(
                              child: Container(
                                  width: double.infinity,
                                  height: Dimension.getHeight(0.32),
                                  child: Center(
                                    child: CarouselDemo(),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Coffee",
                                      style:
                                          StylesText.style17BrownBoldlRaleway),
                                  Text("See all",
                                      style: StylesText.style15RedAccentBold)
                                ],
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Container(
                              color: Colors.white,
                              height: Dimension.getHeight(0.355),
                              width: double.infinity,
                              child: Center(
                                child: Home_Card_Coffee(),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Tea",
                                      style:
                                          StylesText.style17BrownBoldlRaleway),
                                  Text("See all",
                                      style: StylesText.style15RedAccentBold)
                                ],
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Container(
                              height: Dimension.getHeight(0.355),
                              width: double.infinity,
                              child: Home_Card_Tea()),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Drinking",
                                      style:
                                          StylesText.style17BrownBoldlRaleway),
                                  Text(
                                    "See all",
                                    style: StylesText.style15RedAccentBold,
                                  )
                                ],
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Container(
                              height: Dimension.getHeight(0.355),
                              width: double.infinity,
                              child: Home_Card_Drinking()),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Food",
                                      style:
                                          StylesText.style17BrownBoldlRaleway),
                                  Text(
                                    "See all",
                                    style: StylesText.style15RedAccentBold,
                                  )
                                ],
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                          child: Container(
                            height: Dimension.getHeight(0.355),
                            width: double.infinity,
                            child: Home_Card_Food(),
                          ),
                        )
                      ],
                    ),
                  )),
              drawer: Drawer(
                child: HomeMenu(),
              ),
            ),
          );
  }

  void onsearchbutton() {}
}
