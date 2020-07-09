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
import 'package:thekingcoffee/main.dart';

class PlaceholderMainWidget extends StatefulWidget {
  const PlaceholderMainWidget();
  @override
  State<StatefulWidget> createState() {
    return PlaceholderMainWidgetState();
  }
}

var listCoffee = [];
var listTea = [];
var listFood = [];
var listDrinking = [];

class PlaceholderMainWidgetState extends State<PlaceholderMainWidget> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  intDataHomeSlider() async {
    try {
      final result = await getNewProducts();
      final coffee = await isHasCoffeeProduct();
      final tea = await isHaveTeaProducts();
      final food = await isHaveFoodProducts();
      final drinking = await isHaveDrinkingProducts();
      if (this.mounted) {
        setState(() {
          listNewProduct = result;
          listCoffee = coffee;
          listTea = tea;
          listFood = food;
          listDrinking = drinking;
        });
      }
    } catch (e) {}
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
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => FindFood()))
                      .then((value) {
                    numberBloc.checkNumber();
                  });
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
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) =>
                                                SeeAllProductType(
                                                    allTranslations
                                                        .text("all_product")
                                                        .toString(),
                                                    0)))
                                        .then((value) {
                                      numberBloc.checkNumber();
                                    });
                                  },
                                  child: Text(
                                      allTranslations
                                          .text("all_product")
                                          .toString(),
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
                              child: listNewProduct == null ||
                                      listNewProduct.length == 0
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
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  SeeAllProductType(
                                                      allTranslations
                                                          .text("all_coffee")
                                                          .toString(),
                                                      2)))
                                          .then(
                                        (_) {
                                          numberBloc.checkNumber();
                                        },
                                      );
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
                                  child: listCoffee == null ||
                                          listCoffee.length == 0
                                      ? Container(
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  new AlwaysStoppedAnimation<
                                                      Color>(Colors.redAccent),
                                            ),
                                          ),
                                        )
                                      : HomeCardCoffee(),
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
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  SeeAllProductType(
                                                      allTranslations
                                                          .text("all_tea")
                                                          .toString(),
                                                      4)))
                                          .then((value) {
                                        numberBloc.checkNumber();
                                      });
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
                            child: listTea == null || listTea.length == 0
                                ? Container(
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                                Colors.redAccent),
                                      ),
                                    ),
                                  )
                                : HomeCardTea()),
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
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  SeeAllProductType(
                                                      allTranslations
                                                          .text("all_drinking")
                                                          .toString(),
                                                      1)))
                                          .then((value) {
                                        numberBloc.checkNumber();
                                      });
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
                            child: listDrinking == null ||
                                    listDrinking.length == 0
                                ? Container(
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                                Colors.redAccent),
                                      ),
                                    ),
                                  )
                                : HomeCardDrinking()),
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
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  SeeAllProductType(
                                                      allTranslations
                                                          .text("all_food")
                                                          .toString(),
                                                      3)))
                                          .then((value) {
                                        numberBloc.checkNumber();
                                      });
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
                          child: listFood == null || listFood.length == 0
                              ? Container(
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      valueColor:
                                          new AlwaysStoppedAnimation<Color>(
                                              Colors.redAccent),
                                    ),
                                  ),
                                )
                              : HomeCardFood(),
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

    final resultNewProduct = await getNewProducts();
    final resultCoffee = await getCoffeeProduct();
    final resultTea = await getTeaProducts();
    final resultDrinking = await getDrinkingProducts();
    if (this.mounted) {
      setState(() {
        listNewProduct = [];
      });
    }
    final resultFood = await getFoodProducts();

    if (this.mounted) {
      setState(() {
        dataCoffee = resultCoffee;
        dataTea = resultTea;
        dataDrinking = resultDrinking;
        dataFood = resultFood;
        listNewProduct = resultNewProduct;
      });
    }
  }
}
