import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:thekingcoffee/app/config/config.dart';

import 'package:thekingcoffee/app/data/repository/get_drinking_products.dart';
import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/core/components/lib/change_language/change_language.dart';
import 'package:thekingcoffee/core/components/ui/home_cart/home_cart_coffee.dart';
import 'package:thekingcoffee/core/components/ui/show_dialog/loading_dialog_order.dart';
import 'package:thekingcoffee/core/components/widgets/drawline.dart';
import 'package:thekingcoffee/core/components/widgets/favorite.dart';
import 'package:thekingcoffee/core/components/widgets/rating.dart';
import 'package:thekingcoffee/core/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Home_Card_Drinking extends StatefulWidget {
  Home_Card_Drinking({Key key}) : super(key: key);

  _Home_Card_Drinking_State createState() => _Home_Card_Drinking_State();
}

var size = [];
var data_drinking = [];
var topping = [];
var sanpham;
int lenght = 0;
int promotion_drinking = 0;
var promotion_list_drinking = [];

class _Home_Card_Drinking_State extends State<Home_Card_Drinking> {
  intDataDrinkingScreen() async {
    try {
      final result = await Get_Drinking_Products();
      if (this.mounted) {
        if (result != null) {
          setState(() {
            data_drinking = result;
            lenght = data_drinking.length;
          });
        }
      }
    } catch (e) {}
  }

  @override
  void initState() {
    this.intDataDrinkingScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: Dimension.getHeight(0.33),
              child: Center(
                child: data_drinking==null||data_drinking.length==0?CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.redAccent),)  :ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: lenght,
                    itemBuilder: (BuildContext context, int index) {
                      promotion_list_drinking =
                          data_drinking[index]['Promotion'] as List<dynamic>;
                      promotion_drinking = promotion_list_drinking.length;

                      if (data_drinking == null) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return new GestureDetector(
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey[300]),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0))),
                                margin: EdgeInsets.only(right: 12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Stack(
                                          alignment: AlignmentDirectional.topEnd,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                              child: Container(
                                                height: Dimension.getHeight(0.18),
                                                width: Dimension.getWidth(0.51),
                                                decoration: new BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8.0),
                                                  border: new Border.all(
                                                      color: Colors.grey),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8.0),
                                                  child: CachedNetworkImage(
                                                    imageUrl: Config.ip +
                                                        data_drinking[index]
                                                            ['File_Path'],
                                                    fit: BoxFit.fill,
                                                    placeholder: (context, url) =>
                                                        new SizedBox(
                                                          child: Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                              valueColor:
                                                                  new AlwaysStoppedAnimation(
                                                                      Colors
                                                                          .redAccent),
                                                            ),
                                                          ),
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                           Config.isLogin==true?
                                     data_drinking[index]['IsAvailable'] ==
                                              true
                                          ? Favorite(Colors.red,
                                             data_drinking[index]['Loved'],data_drinking[index]['Id'])
                                          : SvgPicture.asset(
                                              "assets/icons/sold.svg",
                                              width: Dimension.getWidth(0.05),
                                              height: Dimension.getHeight(0.05)):Container(
                                                child: data_drinking[index]['IsAvailable'] ==
                                              false?SvgPicture.asset(
                                              "assets/icons/sold.svg",
                                              width: Dimension.getWidth(0.05),
                                              height: Dimension.getHeight(0.05)):Container(),)
                                          ],
                                        ),
                                      ],
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 0),
                                        child: Container(
                                          width: Dimension.getWidth(0.51),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                width: Dimension.getWidth(0.51),
                                                child: Text(
                                                  data_drinking[index]['Name'],
                                                  overflow: TextOverflow.ellipsis,
                                                  style:
                                                      StylesText.style17BrownBold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                      child: Container(
                                        width: Dimension.getWidth(0.51),
                                        child: Row(
                                          children: <Widget>[
                                            Stack(
                                              alignment: AlignmentDirectional
                                                  .centerStart,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    StarRating(
                                                      size: 13.0,
                                                      rating: double.tryParse(
                                                          data_drinking[index]
                                                                  ['Star']
                                                              .toString()),
                                                      color: Colors.orange,
                                                      borderColor: Colors.grey,
                                                      starCount: 5,
                                                    ),
                                                    Text(
                                                        data_drinking[index]
                                                                ['Star']
                                                            .toString(),
                                                        style: StylesText
                                                            .style13BrownNormal)
                                                  ],
                                                ),
                                                data_drinking[index]['IsHot'] == 1
                                                    ? Container(
                                                        width: Dimension.getWidth(
                                                            0.51),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: <Widget>[
                                                            SvgPicture.asset(
                                                              'assets/icons/hot_tea.svg',
                                                              height: Dimension
                                                                  .getHeight(
                                                                      0.035),
                                                              width: Dimension
                                                                  .getHeight(0.1),
                                                              color: Colors
                                                                  .redAccent,
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    : Container()
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                        padding:
                                            const EdgeInsets.fromLTRB(0, 2, 0, 0),
                                        child: Container(
                                          child: CustomPaint(
                                              painter: Drawhorizontalline(
                                                  false,
                                                  0.0,
                                                  Dimension.getWidth(0.51),
                                                  Colors.blueGrey[300],
                                                  0.5)),
                                        )),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                      child: Container(
                                        width: Dimension.getWidth(0.51),
                                        child: Row(
                                          children: <Widget>[
                                            Stack(
                                              alignment: AlignmentDirectional
                                                  .centerStart,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.monetization_on,
                                                      color: Colors.redAccent,
                                                    ),
                                                    Text(
                                                      data_drinking[index]
                                                              ['Price']
                                                          .toString(),
                                                      style: StylesText
                                                          .style13BrownBold,
                                                    )
                                                  ],
                                                ),
                                                promotion_list_drinking == null ||
                                                        promotion_list_drinking
                                                                .length ==
                                                            0
                                                    ? IgnorePointer(
                                                        ignoring: true,
                                                        child: Opacity(
                                                            opacity: 0.0,
                                                            child: Container(
                                                              width: Dimension
                                                                  .getWidth(0.51),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: <
                                                                    Widget>[
                                                                  Icon(
                                                                    Icons
                                                                        .fastfood,
                                                                    color: Colors
                                                                        .redAccent,
                                                                  ),
                                                                  Text(
                                                                    promotion_drinking
                                                                            .toString() +
                                                                        " " +
                                                                        allTranslations
                                                                            .text(
                                                                                "discount")
                                                                            .toString(),
                                                                    style: StylesText
                                                                        .style13BrownBold,
                                                                  )
                                                                ],
                                                              ),
                                                            )),
                                                      )
                                                    : Container(
                                                        width: Dimension.getWidth(
                                                            0.51),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: <Widget>[
                                                            Icon(
                                                              Icons.fastfood,
                                                              color: Colors
                                                                  .redAccent,
                                                            ),
                                                            Text(
                                                              promotion_drinking
                                                                      .toString() +
                                                                  " discount",
                                                              style: StylesText
                                                                  .style13BrownBold,
                                                            )
                                                          ],
                                                        ),
                                                      )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                            onTap: () {
                              if (data_drinking[index]['IsAvailable'] == false) {
                                Fluttertoast.showToast(
                                    msg: allTranslations
                                        .text("out_of_stock")
                                        .toString(),
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIos: 1,
                                    backgroundColor: Colors.redAccent,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              } else {
                                LoadingDialog_Order.showLoadingDialog(
                                    context,
                                    data_drinking[index]['Id'],
                                    data_drinking[index]['Name'],
                                    data_drinking[index]['File_Path'],
                                    data_drinking[index]['Description'],
                                    data_drinking[index]['Price'],
                                    data_drinking[index]['IsHot'],
                                    data_drinking[index]['IsHot'],
                                    data_drinking[index]['Toppings'],
                                    data_drinking[index]['Size'],
                                    data_drinking[index]['Promotion'],
                                    ListOrderProducts);
                              }
                            });
                      }
                    })
              ),
            ),
          ],
        ),
      ),
    );
  }
}
