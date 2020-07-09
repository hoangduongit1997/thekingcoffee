import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oktoast/oktoast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:thekingcoffee/src/app/core/change_language.dart';
import 'package:thekingcoffee/src/app/core/config.dart';
import 'package:thekingcoffee/src/app/core/utils.dart';
import 'package:thekingcoffee/src/app/core/widgets/drawline.dart';
import 'package:thekingcoffee/src/app/core/widgets/favorite.dart';
import 'package:thekingcoffee/src/app/core/widgets/home_cart/home_cart_coffee.dart';
import 'package:thekingcoffee/src/app/core/widgets/rating.dart';
import 'package:thekingcoffee/src/app/core/widgets/show_dialog/loading_dialog_order.dart';
import 'package:thekingcoffee/src/app/theme/styles.dart';

class HomeCardDrinking extends StatefulWidget {
  HomeCardDrinking({Key key}) : super(key: key);

  _HomeCardDrinkingState createState() => _HomeCardDrinkingState();
}

var size = [];
var dataDrinking = [];
var topping = [];
var sanpham;
int lenght = 0;
int promotionDrinking = 0;
var promotionListDrinking = [];

class _HomeCardDrinkingState extends State<HomeCardDrinking> {
  intDataDrinkingScreen() async {
    try {
      final result = await api.getDrinkingProducts();
      if (this.mounted) {
        if (result != null) {
          setState(() {
            dataDrinking = result;
            lenght = dataDrinking.length;
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
                  child: dataDrinking == null || dataDrinking.length == 0
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.redAccent),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: lenght,
                          itemBuilder: (BuildContext context, int index) {
                            promotionListDrinking = dataDrinking[index]
                                ['Promotion'] as List<dynamic>;
                            promotionDrinking = promotionListDrinking.length;

                            if (dataDrinking == null) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return new GestureDetector(
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.grey[300]),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.0))),
                                      margin: EdgeInsets.only(right: 12),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Stack(
                                                alignment:
                                                    AlignmentDirectional.topEnd,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 0, 0, 0),
                                                    child: Container(
                                                      height:
                                                          Dimension.getHeight(
                                                              0.18),
                                                      width: Dimension.getWidth(
                                                          0.51),
                                                      decoration:
                                                          new BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        border: new Border.all(
                                                            color: Colors.grey),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: domainAPI +
                                                              dataDrinking[
                                                                      index]
                                                                  ['File_Path'],
                                                          fit: BoxFit.fill,
                                                          placeholder:
                                                              (context, url) =>
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
                                                  isLogin == true
                                                      ? dataDrinking[index][
                                                                  'IsAvailable'] ==
                                                              true
                                                          ? Favorite(
                                                              Colors.red,
                                                              dataDrinking[
                                                                      index]
                                                                  ['Loved'],
                                                              dataDrinking[
                                                                  index]['Id'])
                                                          : SvgPicture.asset(
                                                              "assets/icons/sold.svg",
                                                              width: Dimension
                                                                  .getWidth(
                                                                      0.05),
                                                              height: Dimension
                                                                  .getHeight(
                                                                      0.05))
                                                      : Container(
                                                          child: dataDrinking[
                                                                          index]
                                                                      [
                                                                      'IsAvailable'] ==
                                                                  false
                                                              ? SvgPicture.asset(
                                                                  "assets/icons/sold.svg",
                                                                  width: Dimension
                                                                      .getWidth(
                                                                          0.05),
                                                                  height: Dimension
                                                                      .getHeight(
                                                                          0.05))
                                                              : Container(),
                                                        )
                                                ],
                                              ),
                                            ],
                                          ),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 10, 0, 0),
                                              child: Container(
                                                width: Dimension.getWidth(0.51),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Container(
                                                      width: Dimension.getWidth(
                                                          0.51),
                                                      child: Text(
                                                        dataDrinking[index]
                                                            ['Name'],
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: StylesText
                                                            .style17BrownBold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 0),
                                            child: Container(
                                              width: Dimension.getWidth(0.51),
                                              child: Row(
                                                children: <Widget>[
                                                  Stack(
                                                    alignment:
                                                        AlignmentDirectional
                                                            .centerStart,
                                                    children: <Widget>[
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          StarRating(
                                                            size: 13.0,
                                                            rating: double.tryParse(
                                                                dataDrinking[
                                                                            index]
                                                                        ['Star']
                                                                    .toString()),
                                                            color:
                                                                Colors.orange,
                                                            borderColor:
                                                                Colors.grey,
                                                            starCount: 5,
                                                          ),
                                                          Text(
                                                              dataDrinking[
                                                                          index]
                                                                      ['Star']
                                                                  .toString(),
                                                              style: StylesText
                                                                  .style13BrownNormal)
                                                        ],
                                                      ),
                                                      dataDrinking[index]
                                                                  ['IsHot'] ==
                                                              1
                                                          ? Container(
                                                              width: Dimension
                                                                  .getWidth(
                                                                      0.51),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: <
                                                                    Widget>[
                                                                  SvgPicture
                                                                      .asset(
                                                                    'assets/icons/hot_tea.svg',
                                                                    height: Dimension
                                                                        .getHeight(
                                                                            0.035),
                                                                    width: Dimension
                                                                        .getHeight(
                                                                            0.1),
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
                                                  const EdgeInsets.fromLTRB(
                                                      0, 2, 0, 0),
                                              child: Container(
                                                child: CustomPaint(
                                                    painter: Drawhorizontalline(
                                                        false,
                                                        0.0,
                                                        Dimension.getWidth(
                                                            0.51),
                                                        Colors.blueGrey[300],
                                                        0.5)),
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 0),
                                            child: Container(
                                              width: Dimension.getWidth(0.51),
                                              child: Row(
                                                children: <Widget>[
                                                  Stack(
                                                    alignment:
                                                        AlignmentDirectional
                                                            .centerStart,
                                                    children: <Widget>[
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Icon(
                                                            Icons
                                                                .monetization_on,
                                                            color: Colors
                                                                .redAccent,
                                                          ),
                                                          Text(
                                                            dataDrinking[index]
                                                                    ['Price']
                                                                .toString(),
                                                            style: StylesText
                                                                .style13BrownBold,
                                                          )
                                                        ],
                                                      ),
                                                      promotionListDrinking ==
                                                                  null ||
                                                              promotionListDrinking
                                                                      .length ==
                                                                  0
                                                          ? IgnorePointer(
                                                              ignoring: true,
                                                              child: Opacity(
                                                                  opacity: 0.0,
                                                                  child:
                                                                      Container(
                                                                    width: Dimension
                                                                        .getWidth(
                                                                            0.51),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: <
                                                                          Widget>[
                                                                        Icon(
                                                                          Icons
                                                                              .fastfood,
                                                                          color:
                                                                              Colors.redAccent,
                                                                        ),
                                                                        Text(
                                                                          promotionDrinking.toString() +
                                                                              " " +
                                                                              allTranslations.text("discount").toString(),
                                                                          style:
                                                                              StylesText.style13BrownBold,
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )),
                                                            )
                                                          : Container(
                                                              width: Dimension
                                                                  .getWidth(
                                                                      0.51),
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
                                                                    promotionDrinking
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
                                    if (dataDrinking[index]['IsAvailable'] ==
                                        false) {
                                      showToast(
                                        allTranslations
                                            .text("out_of_stock")
                                            .toString(),
                                      );
                                    } else {
                                      LoadingDialogOrder.showLoadingDialog(
                                          context,
                                          dataDrinking[index]['Id'],
                                          dataDrinking[index]['Name'],
                                          dataDrinking[index]['File_Path'],
                                          dataDrinking[index]['Description'],
                                          dataDrinking[index]['Price'],
                                          dataDrinking[index]['IsHot'],
                                          dataDrinking[index]['IsHot'],
                                          dataDrinking[index]['Toppings'],
                                          dataDrinking[index]['Size'],
                                          dataDrinking[index]['Promotion'],
                                          listOrderProducts);
                                    }
                                  });
                            }
                          })),
            ),
          ],
        ),
      ),
    );
  }
}
