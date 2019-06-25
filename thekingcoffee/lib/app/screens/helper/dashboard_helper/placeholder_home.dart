import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

import 'package:thekingcoffee/app/data/repository/get_coffee_products.dart';

import 'package:thekingcoffee/app/data/repository/get_drinking_products.dart';
import 'package:thekingcoffee/app/data/repository/get_food_products.dart';
import 'package:thekingcoffee/app/data/repository/get_new_products.dart';
import 'package:thekingcoffee/app/data/repository/get_tea_products.dart';

import 'package:thekingcoffee/app/screens/find_food.dart';

import 'package:thekingcoffee/app/screens/see_all_product_type.dart';

import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/core/components/lib/change_language/change_language.dart';

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

var list_coffee = [];
var list_tea = [];
var list_food = [];
var list_drinking = [];

class PlaceholderMainWidgetState extends State<PlaceholderMainWidget> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  intDataHomeSlider() async {
    final result = await Get_New_Products();
    final coffee = await Is_Has_Coffee_Product();
    final tea = await Is_Have_Tea_Products();
    final food = await Is_Have_Food_Products();
    final drinking = await Is_Have_Drinking_Products();
    if (this.mounted) {
      setState(() {
        list_new_product = result;
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
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          key: _scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
            title: Text(allTranslations.text("home_page").toString(),
                style: StylesText.style20BrownBold),
            leading: FlatButton(
                splashColor: Colors.grey[300],
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
                        child: Text(allTranslations.text("all_cato").toString(),
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
                                Text(
                                    allTranslations
                                        .text("new_product")
                                        .toString(),
                                    style: StylesText.style17BrownBoldlRaleway),
                                GestureDetector(
                                  onTap: (){
                                     Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  See_All_Product_Type(
                                                      allTranslations
                                                          .text("all_product")
                                                          .toString(),
                                                      0)));
                                  },
                                  child: Text(allTranslations.text("all_product").toString(),
                                    style: StylesText.style15RedAccentBold),
                                )
                                
                              ],
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Container(
                            height: Dimension.getHeight(0.29),
                            child: Center(
                              child: list_new_product == null ||
                                      list_new_product.length == 0
                                  ? Container(
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              new AlwaysStoppedAnimation<Color>(
                                                  Colors.redAccent),
                                        ),
                                      ),
                                    )
                                  : CarouselWithIndicator(),
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
                                Text(allTranslations.text("coffee").toString(),
                                    style: StylesText.style17BrownBoldlRaleway),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  See_All_Product_Type(
                                                      allTranslations
                                                          .text("all_coffee")
                                                          .toString(),
                                                      2)));
                                    },
                                    child: Text(
                                        allTranslations
                                            .text("see_all")
                                            .toString(),
                                        style: StylesText.style15RedAccentBold))
                              ],
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                                color: Colors.white,
                                height: Dimension.getHeight(0.331),
                                width: double.infinity,
                                child: Center(
                                  child: list_coffee == null ||
                                          list_coffee.length == 0
                                      ? Container(
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  new AlwaysStoppedAnimation<
                                                      Color>(Colors.redAccent),
                                            ),
                                          ),
                                        )
                                      : Home_Card_Coffee(),
                                )),
                          ],
                        ),
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
                                Text(allTranslations.text("tea").toString(),
                                    style: StylesText.style17BrownBoldlRaleway),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  See_All_Product_Type(
                                                      allTranslations
                                                          .text("all_tea")
                                                          .toString(),
                                                      4)));
                                    },
                                    child: Text(
                                        allTranslations
                                            .text("see_all")
                                            .toString(),
                                        style: StylesText.style15RedAccentBold))
                              ],
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Container(
                            height: Dimension.getHeight(0.331),
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
                                Text(
                                    allTranslations.text("drinking").toString(),
                                    style: StylesText.style17BrownBoldlRaleway),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  See_All_Product_Type(
                                                      allTranslations
                                                          .text("all_drinking")
                                                          .toString(),
                                                      1)));
                                    },
                                    child: Text(
                                        allTranslations
                                            .text("see_all")
                                            .toString(),
                                        style: StylesText.style15RedAccentBold))
                              ],
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Container(
                            height: Dimension.getHeight(0.331),
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
                                Text(allTranslations.text("food").toString(),
                                    style: StylesText.style17BrownBoldlRaleway),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  See_All_Product_Type(
                                                      allTranslations
                                                          .text("all_food")
                                                          .toString(),
                                                      3)));
                                    },
                                    child: Text(
                                        allTranslations
                                            .text("see_all")
                                            .toString(),
                                        style: StylesText.style15RedAccentBold))
                              ],
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                        child: Container(
                          height: Dimension.getHeight(0.331),
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
    await Future.delayed(Duration(seconds: 2));

    final result_new_product = await Get_New_Products();
    final result_coffee = await Get_Coffee_Product();
    final result_tea = await Get_Tea_Products();
    final result_drinking = await Get_Drinking_Products();
    if (this.mounted) {
      setState(() {
        list_new_product.clear();
      });
    }
    final result_food = await Get_Food_Products();

    if (this.mounted) {
      setState(() {
        data_coffee = result_coffee;
        data_tea = result_tea;
        data_drinking = result_drinking;
        data_food = result_food;
        list_new_product = result_new_product;
      });
    }
  }
}
