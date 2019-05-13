import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/app/data/repository/get_data_all_product.dart';
import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/core/components/ui/home_cart/home_cart.dart';
import 'package:thekingcoffee/core/components/ui/slider_card/slide_recipes.dart';
import 'package:thekingcoffee/core/utils/utils.dart';
import 'package:http/http.dart' as http;

class PlaceholderMainWidget extends StatefulWidget {
  const PlaceholderMainWidget();
  @override
  State<StatefulWidget> createState() {
    return PlaceholderMainWidgetState();
  }
}
var data=[];


class PlaceholderMainWidgetState extends State<PlaceholderMainWidget> {
  intDataHomeSlider()async{
 final result = await Get_Data_All_Product();
 setState(() {
    data=result;
    });
}
@override
  void initState() {
    this.intDataHomeSlider();
    super.initState();
  }

//xoa pull request 12
  @override
  Widget build(BuildContext context) {
    return data.length==0||data==null
        ? Center(
            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.redAccent),),
          )
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primaryColor: Colors.orangeAccent),
            home: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0.0,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.format_list_bulleted),
                    color: Colors.brown,
                    splashColor: Colors.brown,
                    onPressed: onpresssetting,
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    color: Colors.brown,
                    splashColor: Colors.brown,
                    onPressed: onpresssetting,
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
                          child: Text("All Recipes",
                              style: StylesText.style20BrownNomorlRaleway),
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
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
                                  Text("Recipes of the week",
                                      style:
                                          StylesText.style17BrownBoldlRaleway),
                                  Text("See all",
                                      style: StylesText.style15RedAccentBold)
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
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
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
                                  Text("Appetizer",
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
                              height: Dimension.getHeight(0.45),
                              width: double.infinity,
                              child: Home_Card_State()),
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
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
                                  Text("Main diskes",
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
                            height: Dimension.getHeight(0.45),
                            width: double.infinity,
                            child: Home_Card_State(),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
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
                                  Text("Soup",
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
                              height: Dimension.getHeight(0.45),
                              width: double.infinity,
                              child: Home_Card_State()),
                        )
                      ],
                    ),
                  )),
            ),
          );
  }

  void onpresssetting() {}
}
