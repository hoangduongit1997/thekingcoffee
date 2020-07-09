import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oktoast/oktoast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:thekingcoffee/src/app/core/components/lib/change_language/change_language.dart';
import 'package:thekingcoffee/src/app/core/components/widgets/drawline.dart';
import 'package:thekingcoffee/src/app/core/components/widgets/favorite.dart';
import 'package:thekingcoffee/src/app/core/components/widgets/rating.dart';
import 'package:thekingcoffee/src/app/core/components/widgets/show_dialog/loading_dialog_order.dart';
import 'package:thekingcoffee/src/app/core/config.dart';
import 'package:thekingcoffee/src/app/core/utils.dart';
import 'package:thekingcoffee/src/app/streams/bottom_navigation_bloc.dart';
import 'package:thekingcoffee/src/app/theme/styles.dart';

class HomeCardCoffee extends StatefulWidget {
  HomeCardCoffee({Key key}) : super(key: key);

  _HomeCardCoffeeState createState() => _HomeCardCoffeeState();
}

var dataCoffee = [];
int lenght = 0;
var selectedProduct = {};
var listOrderProducts = [];
var promotionListCoffee = [];
int promotionCoffee = 0;

class _HomeCardCoffeeState extends State<HomeCardCoffee> {
  BottomNavBarBloc _bottomNavBarBloc;

  intDataCoffeeScreen() async {
    try {
      final result = await api.getCoffeeProduct();
      if (this.mounted) {
        if (result != null) {
          setState(() {
            dataCoffee = result;
            lenght = dataCoffee.length;
          });
        }
      }
    } catch (e) {}
  }

  @override
  void initState() {
    _bottomNavBarBloc = new BottomNavBarBloc();
    this.intDataCoffeeScreen();
    super.initState();
  }

  @override
  void dispose() {
    _bottomNavBarBloc.close();
    super.dispose();
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
                child: dataCoffee == null || dataCoffee.length == 0
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.redAccent),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: lenght,
                        itemBuilder: (BuildContext context, int index) {
                          promotionListCoffee =
                              dataCoffee[index]['Promotion'] as List<dynamic>;
                          promotionCoffee = promotionListCoffee.length;

                          if (dataCoffee == null) {
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
                                                            dataCoffee[index]
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
                                                    ? dataCoffee[index][
                                                                'IsAvailable'] ==
                                                            true
                                                        ? Favorite(
                                                            Colors.red,
                                                            dataCoffee[index]
                                                                ['Loved'],
                                                            dataCoffee[index]
                                                                ['Id'])
                                                        : SvgPicture.asset(
                                                            "assets/icons/sold.svg",
                                                            width: Dimension
                                                                .getWidth(0.05),
                                                            height: Dimension
                                                                .getHeight(
                                                                    0.05))
                                                    : Container(
                                                        child: dataCoffee[index]
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
                                                      dataCoffee[index]['Name'],
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
                                                          rating: double.tryParse(
                                                              dataCoffee[index]
                                                                      ['Star']
                                                                  .toString()),
                                                          color: Colors.orange,
                                                          borderColor:
                                                              Colors.grey,
                                                          starCount: 5,
                                                        ),
                                                        Text(
                                                            dataCoffee[index]
                                                                    ['Star']
                                                                .toString(),
                                                            style: StylesText
                                                                .style13BrownNormal)
                                                      ],
                                                    ),
                                                    dataCoffee[index]
                                                                ['IsHot'] ==
                                                            1
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
                                                                          0.05),
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
                                                          dataCoffee[index]
                                                                  ['Price']
                                                              .toString(),
                                                          style: StylesText
                                                              .style13BrownBold,
                                                        )
                                                      ],
                                                    ),
                                                    promotionListCoffee ==
                                                                null ||
                                                            promotionListCoffee
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
                                                                        promotionCoffee.toString() +
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
                                                                  promotionCoffee
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
                                  if (dataCoffee[index]['IsAvailable'] ==
                                      false) {
                                    showToast(
                                      allTranslations
                                          .text("out_of_stock")
                                          .toString(),
                                    );
                                  } else {
                                    LoadingDialogOrder.showLoadingDialog(
                                        context,
                                        dataCoffee[index]['Id'],
                                        dataCoffee[index]['Name'],
                                        dataCoffee[index]['File_Path'],
                                        dataCoffee[index]['Description'],
                                        dataCoffee[index]['Price'],
                                        dataCoffee[index]['IsHot'],
                                        dataCoffee[index]['IsHot'],
                                        dataCoffee[index]['Toppings'],
                                        dataCoffee[index]['Size'],
                                        dataCoffee[index]['Promotion'],
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
