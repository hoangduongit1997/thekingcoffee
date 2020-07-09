import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oktoast/oktoast.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/app/data/repository/get_food_products.dart';
import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/core/components/lib/change_language/change_language.dart';
import 'package:thekingcoffee/core/components/ui/home_cart/home_cart_coffee.dart';
import 'package:thekingcoffee/core/components/ui/show_dialog/loading_dialog_order.dart';
import 'package:thekingcoffee/core/components/widgets/drawline.dart';
import 'package:thekingcoffee/core/components/widgets/favorite.dart';
import 'package:thekingcoffee/core/components/widgets/rating.dart';
import 'package:thekingcoffee/core/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeCardFood extends StatefulWidget {
  HomeCardFood({Key key}) : super(key: key);

  _HomeCardFoodState createState() => _HomeCardFoodState();
}

var size = [];
var dataFood = [];
var topping = [];
var sanpham;
int lenght = 0;
int promotionFood = 0;
var promotionListFood = [];

class _HomeCardFoodState extends State<HomeCardFood> {
  intDataFoodScreen() async {
    try {
      final result = await getFoodProducts();

      if (this.mounted) {
        if (result != null)
          setState(() {
            dataFood = result;
            lenght = dataFood.length;
          });
      }
    } catch (e) {}
  }

  @override
  void initState() {
    this.intDataFoodScreen();
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
                child: dataFood == null || dataFood.length == 0
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.redAccent),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: lenght,
                        itemBuilder: (BuildContext context, int index) {
                          promotionListFood =
                              dataFood[index]['Promotion'] as List<dynamic>;
                          promotionFood = promotionListFood.length;

                          if (dataFood == null) {
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
                                                        imageUrl: Config.ip +
                                                            dataFood[index]
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
                                                Config.isLogin == true
                                                    ? dataFood[index]
                                                                [
                                                                'IsAvailable'] ==
                                                            true
                                                        ? Favorite(
                                                            Colors.red,
                                                            dataFood[index]
                                                                ['Loved'],
                                                            dataFood[index]
                                                                ['Id'])
                                                        : SvgPicture.asset(
                                                            "assets/icons/sold.svg",
                                                            width: Dimension
                                                                .getWidth(0.05),
                                                            height: Dimension
                                                                .getHeight(
                                                                    0.05))
                                                    : Container(
                                                        child: dataFood[index][
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
                                                      dataFood[index]['Name'],
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
                                                              .tryParse(dataFood[
                                                                          index]
                                                                      ['Star']
                                                                  .toString()),
                                                          color: Colors.orange,
                                                          borderColor:
                                                              Colors.grey,
                                                          starCount: 5,
                                                        ),
                                                        Text(
                                                            dataFood[index]
                                                                    ['Star']
                                                                .toString(),
                                                            style: StylesText
                                                                .style13BrownNormal)
                                                      ],
                                                    ),
                                                    dataFood[index]['IsHot'] ==
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
                                                          dataFood[index]
                                                                  ['Price']
                                                              .toString(),
                                                          style: StylesText
                                                              .style13BrownBold,
                                                        )
                                                      ],
                                                    ),
                                                    promotionListFood == null ||
                                                            promotionListFood
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
                                                                        promotionFood.toString() +
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
                                                                  promotionFood
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
                                  if (dataFood[index]['IsAvailable'] == false) {
                                    showToast(
                                      allTranslations
                                          .text("out_of_stock")
                                          .toString(),
                                    );
                                  } else {
                                    LoadingDialogOrder.showLoadingDialog(
                                        context,
                                        dataFood[index]['Id'],
                                        dataFood[index]['Name'],
                                        dataFood[index]['File_Path'],
                                        dataFood[index]['Description'],
                                        dataFood[index]['Price'],
                                        dataFood[index]['IsHot'],
                                        dataFood[index]['IsHot'],
                                        dataFood[index]['Toppings'],
                                        dataFood[index]['Size'],
                                        dataFood[index]['Promotion'],
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
