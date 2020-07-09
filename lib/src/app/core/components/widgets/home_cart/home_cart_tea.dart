import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oktoast/oktoast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:thekingcoffee/src/app/core/components/lib/change_language/change_language.dart';
import 'package:thekingcoffee/src/app/core/components/widgets/drawline.dart';
import 'package:thekingcoffee/src/app/core/components/widgets/favorite.dart';
import 'package:thekingcoffee/src/app/core/components/widgets/home_cart/home_cart_coffee.dart';
import 'package:thekingcoffee/src/app/core/components/widgets/rating.dart';
import 'package:thekingcoffee/src/app/core/components/widgets/show_dialog/loading_dialog_order.dart';
import 'package:thekingcoffee/src/app/core/config.dart';
import 'package:thekingcoffee/src/app/core/utils.dart';
import 'package:thekingcoffee/src/app/theme/styles.dart';

class HomeCardTea extends StatefulWidget {
  HomeCardTea({Key key}) : super(key: key);

  _HomeCardTeaState createState() => _HomeCardTeaState();
}

var size = [];
var dataTea = [];
var topping = [];
var sanpham;
int lenght = 0;
int promotionTea = 0;
var promotionListTea = [];

class _HomeCardTeaState extends State<HomeCardTea> {
  intDataTeaScreen() async {
    try {
      final result = await api.getTeaProducts();
      if (this.mounted) {
        if (result != null) {
          setState(() {
            dataTea = result;
            lenght = dataTea.length;
          });
        }
      }
    } catch (e) {}
  }

  @override
  void initState() {
    this.intDataTeaScreen();
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
                child: dataTea == null || dataTea.length == 0
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.redAccent),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: lenght,
                        itemBuilder: (BuildContext context, int index) {
                          promotionListTea =
                              dataTea[index]['Promotion'] as List<dynamic>;
                          promotionTea = promotionListTea.length;

                          if (dataTea == null) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return new GestureDetector(
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border:
                                            Border.all(color: Colors.grey[300]),
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
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 0, 0),
                                                  child: Container(
                                                    height: Dimension.getHeight(
                                                        0.18),
                                                    width: Dimension.getWidth(
                                                        0.51),
                                                    decoration:
                                                        new BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      border: new Border.all(
                                                          color: Colors.grey),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      child: CachedNetworkImage(
                                                        imageUrl: domainAPI +
                                                            dataTea[index]
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
                                                    ? dataTea[index][
                                                                'IsAvailable'] ==
                                                            true
                                                        ? Favorite(
                                                            Colors.red,
                                                            dataTea[index]
                                                                ['Loved'],
                                                            dataTea[index]
                                                                ['Id'])
                                                        : SvgPicture.asset(
                                                            "assets/icons/sold.svg",
                                                            width: Dimension
                                                                .getWidth(0.05),
                                                            height: Dimension
                                                                .getHeight(
                                                                    0.05))
                                                    : Container(
                                                        child: dataTea[index][
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
                                            padding: const EdgeInsets.fromLTRB(
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
                                                      dataTea[index]['Name'],
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                                          rating: double
                                                              .tryParse(dataTea[
                                                                          index]
                                                                      ['Star']
                                                                  .toString()),
                                                          color: Colors.orange,
                                                          borderColor:
                                                              Colors.grey,
                                                          starCount: 5,
                                                        ),
                                                        Text(
                                                            dataTea[index]
                                                                    ['Star']
                                                                .toString(),
                                                            style: StylesText
                                                                .style13BrownNormal)
                                                      ],
                                                    ),
                                                    dataTea[index]['IsHot'] == 1
                                                        ? Container(
                                                            width: Dimension
                                                                .getWidth(0.51),
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
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 2, 0, 0),
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
                                                          Icons.monetization_on,
                                                          color:
                                                              Colors.redAccent,
                                                        ),
                                                        Text(
                                                          dataTea[index]
                                                                  ['Price']
                                                              .toString(),
                                                          style: StylesText
                                                              .style13BrownBold,
                                                        )
                                                      ],
                                                    ),
                                                    promotionListTea == null ||
                                                            promotionListTea
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
                                                                        color: Colors
                                                                            .redAccent,
                                                                      ),
                                                                      Text(
                                                                        promotionTea.toString() +
                                                                            " " +
                                                                            allTranslations.text("discount").toString(),
                                                                        style: StylesText
                                                                            .style13BrownBold,
                                                                      )
                                                                    ],
                                                                  ),
                                                                )),
                                                          )
                                                        : Container(
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
                                                                  promotionTea
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
                                  if (dataTea[index]['IsAvailable'] == false) {
                                    showToast(
                                      allTranslations
                                          .text("out_of_stock")
                                          .toString(),
                                    );
                                  } else {
                                    LoadingDialogOrder.showLoadingDialog(
                                        context,
                                        dataTea[index]['Id'],
                                        dataTea[index]['Name'],
                                        dataTea[index]['File_Path'],
                                        dataTea[index]['Description'],
                                        dataTea[index]['Price'],
                                        dataTea[index]['IsHot'],
                                        dataTea[index]['IsHot'],
                                        dataTea[index]['Toppings'],
                                        dataTea[index]['Size'],
                                        dataTea[index]['Promotion'],
                                        listOrderProducts);
                                  }
                                });
                          }
                        }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
