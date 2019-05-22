import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:http/http.dart' as http;
import 'package:thekingcoffee/app/screens/helper/dashboard_helper/placeholder_home.dart';
import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/core/components/ui/home_cart/home_cart_coffee.dart';
import 'package:thekingcoffee/core/components/ui/show_dialog/loading_dialog_order.dart';
import 'package:thekingcoffee/core/components/widgets/drawline.dart';
import 'package:thekingcoffee/core/components/widgets/favorite.dart';
import 'package:thekingcoffee/core/components/widgets/rating.dart';
import 'package:thekingcoffee/core/utils/utils.dart';

class CarouselWithIndicator extends StatefulWidget {
  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
}

int promotion_new_product = 0;
var promotion_list_new_product = [];
BuildContext context_order;

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;
  static int starCount = 5;

  @override
  Widget build(context) {
    context_order = context;
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]),
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        CarouselSlider(
          items: child,
          autoPlay: false,
          viewportFraction: 1.0,
          autoPlayInterval: Duration(seconds: 7),
          enlargeCenterPage: false,
          aspectRatio: 2.0,
          onPageChanged: (index) {
            setState(() {
              _current = index;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: Map_Object.map_home_cart<Widget>(
            list_new_products,
            (index, url) {
              return Container(
                width: Dimension.getWidth(0.01),
                height: Dimension.getHeight(0.008),
                margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        _current == index ? Colors.redAccent : Colors.red[100]),
              );
            },
          ),
        ),
      ]),
    );
  }

  final List child = Map_Object.map_home_cart<Widget>(
    list_new_products,
    (index, i) {
      promotion_list_new_product =
          list_new_products[index]['Promotion'] as List<dynamic>;
      promotion_new_product = promotion_list_new_product.length;
      return Container(
          child: GestureDetector(
        onTap: () {
          LoadingDialog_Order.showLoadingDialog(
              context_order,
              list_new_products[index]['Id'],
              list_new_products[index]['Name'],
              list_new_products[index]['File_Path'],
              list_new_products[index]['Description'],
              list_new_products[index]['IsHot'],
              list_new_products[index]['Price'],
              list_new_products[index]['Toppings'],
              list_new_products[index]['Size'],
              list_new_products[index]['Promotion'],
              ListOrderProducts);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          child: Stack(children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Row(
                          children: <Widget>[
                            Container(
                                height: Dimension.getHeight(0.23),
                                width: Dimension.getWidth(0.45),
                                child: Stack(
                                  alignment: AlignmentDirectional.topEnd,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: CachedNetworkImage(
                                          imageUrl: Config.ip +
                                              list_new_products[index]
                                                  ['File_Path'],
                                          fit: BoxFit.cover,
                                          height: Dimension.getHeight(0.3),
                                          width: Dimension.getWidth(0.5),
                                          placeholder: (context, url) =>
                                              new SizedBox(
                                                child: Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                  valueColor:
                                                      new AlwaysStoppedAnimation<
                                                              Color>(
                                                          Colors.redAccent),
                                                )),
                                              )),
                                    ),
                                    Favorite(
                                      color: Colors.red,
                                    ),
                                  ],
                                )),
                          ],
                        ))
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Center(
                        child: Container(
                          width: Dimension.getWidth(0.48),
                          child: Text(list_new_products[index]['Name'],
                              style: StylesText.style20BrownBold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                      child: Row(
                        children: <Widget>[
                          StarRating(
                            size: 13.0,
                            rating: double.tryParse(
                                list_new_products[index]['Start'].toString()),
                            color: Colors.orange,
                            borderColor: Colors.grey,
                            starCount: starCount,
                          ),
                          Text(list_new_products[index]['Start'].toString(),
                              style: StylesText.style13BrownNormal)
                        ],
                      ),
                    ),
                    promotion_list_new_product == null ||
                            promotion_list_new_product.length == 0
                        ? IgnorePointer(
                            ignoring: true,
                            child: Opacity(
                              opacity: 0.0,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.fastfood,
                                        color: Colors.redAccent),
                                    Text(
                                        promotion_new_product.toString() +
                                            " discount",
                                        style: StylesText.style13BrownNormal)
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.fastfood, color: Colors.redAccent),
                                Text(
                                    promotion_new_product.toString() +
                                        " discount",
                                    style: StylesText.style13BrownNormal)
                              ],
                            ),
                          ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Container(
                          child: CustomPaint(
                              painter: Drawhorizontalline(
                                  false, 0.0, 200.0, Colors.blueGrey, 0.2)),
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 30, 0, 0),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.redAccent,
                              radius: 12.0,
                              child: Icon(
                                Icons.monetization_on,
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Text(
                                list_new_products[index]['Price'].toString(),
                                style: StylesText.style16BrownBold),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ]),
        ),
      ));
    },
  ).toList();
}

class CarouselDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Container(
                child: CarouselWithIndicator(),
              )),
        ),
      ),
    );
  }
}
