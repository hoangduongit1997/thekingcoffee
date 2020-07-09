import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/app/data/repository/get_favorite_product.dart';

import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/core/components/lib/change_language/change_language.dart';
import 'package:thekingcoffee/core/components/ui/draw_left/draw_left.dart';
import 'package:thekingcoffee/core/components/ui/home_cart/home_cart_coffee.dart';
import 'package:thekingcoffee/core/components/ui/show_dialog/loading_dialog_order.dart';
import 'package:thekingcoffee/core/components/widgets/drawline.dart';
import 'package:thekingcoffee/core/components/widgets/favorite.dart';
import 'package:thekingcoffee/core/components/widgets/rating.dart';
import 'package:thekingcoffee/core/utils/utils.dart';

class FavoritePage extends StatefulWidget {
  FavoritePage({Key key}) : super(key: key);

  FavoritePageState createState() => FavoritePageState();
}

class FavoritePageState extends State<FavoritePage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  var data = [];
  static int starCount = 5;
  int promotionProduct = 0;
  var promotionListProduct = [];

  initData() async {
    var temp = [];
    final result = await getFavoriteProduct();
    if (result != null) {
      for (var item in result) {
        if (item['Loved'] == true) {
          temp.add(item);
        }
      }
      if (this.mounted) {
        setState(() {
          data = temp;
        });
      }
    }
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 0.8,
            title: Text(
              "Favorites",
              style: StylesText.style20BrownBold,
            ),
          ),
          resizeToAvoidBottomInset: false,
          body: data.length == 0 || data.isEmpty == true
              ? Container(
                  child: Center(
                      child: Text(
                    allTranslations.text("no_info").toString(),
                    style: StylesText.style16Brown,
                  )),
                )
              : Container(
                  padding: const EdgeInsets.all(5.0),
                  color: Colors.grey[300],
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  child: RefreshIndicator(
                    onRefresh: refreshPage,
                    backgroundColor: Colors.white,
                    color: Colors.redAccent,
                    child: ListView.builder(
                        itemCount: data.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          promotionListProduct =
                              data[index]['Promotion'] as List<dynamic>;
                          promotionProduct = promotionListProduct.length;
                          return GestureDetector(
                            onTap: () {
                              if (data[index]['IsAvailable'] == false) {
                                Fluttertoast.showToast(
                                    msg: allTranslations
                                        .text("out_of_stock")
                                        .toString(),
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.redAccent,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              } else {
                                LoadingDialogOrder.showLoadingDialog(
                                    context,
                                    data[index]['Id'],
                                    data[index]['Name'],
                                    data[index]['File_Path'],
                                    data[index]['Description'],
                                    data[index]['Price'],
                                    data[index]['IsHot'],
                                    data[index]['IsHot'],
                                    data[index]['Toppings'],
                                    data[index]['Size'],
                                    data[index]['Promotion'],
                                    listOrderProducts);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Center(
                                child: Container(
                                    height: Dimension.getHeight(0.168),
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border:
                                            Border.all(color: Colors.grey[300]),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0))),
                                    child: Center(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0)),
                                        child: Stack(children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(0, 0, 0, 0),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Container(
                                                              height: Dimension
                                                                  .getHeight(
                                                                      0.15),
                                                              width: Dimension
                                                                  .getWidth(
                                                                      0.3),
                                                              child: Stack(
                                                                alignment:
                                                                    AlignmentDirectional
                                                                        .topEnd,
                                                                children: <
                                                                    Widget>[
                                                                  ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                    child: CachedNetworkImage(
                                                                        imageUrl: Config.ip + data[index]['File_Path'],
                                                                        fit: BoxFit.cover,
                                                                        height: Dimension.getHeight(0.3),
                                                                        width: Dimension.getWidth(0.5),
                                                                        placeholder: (context, url) => new SizedBox(
                                                                              child: Center(
                                                                                  child: CircularProgressIndicator(
                                                                                valueColor: new AlwaysStoppedAnimation<Color>(Colors.redAccent),
                                                                              )),
                                                                            )),
                                                                  ),
                                                                  Config.isLogin ==
                                                                          true
                                                                      ? data[index]['IsAvailable'] ==
                                                                              true
                                                                          ? Favorite(
                                                                              Colors
                                                                                  .red,
                                                                              data[index][
                                                                                  'Loved'],
                                                                              data[index][
                                                                                  'Id'])
                                                                          : SvgPicture.asset(
                                                                              "assets/icons/sold.svg",
                                                                              width: Dimension.getWidth(0.05),
                                                                              height: Dimension.getHeight(0.05))
                                                                      : Container(
                                                                          child: data[index]['IsAvailable'] == false
                                                                              ? SvgPicture.asset("assets/icons/sold.svg", width: Dimension.getWidth(0.05), height: Dimension.getHeight(0.05))
                                                                              : Container(),
                                                                        )
                                                                ],
                                                              )),
                                                        ],
                                                      ))
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(5, 0, 0, 0),
                                                    child: Center(
                                                      child: Container(
                                                        width:
                                                            Dimension.getWidth(
                                                                0.62),
                                                        child: Text(
                                                            data[index]['Name'],
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: StylesText
                                                                .style20BrownBold),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 10, 0, 5),
                                                    child: Container(
                                                      width: Dimension.getWidth(
                                                          0.62),
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
                                                                children: <
                                                                    Widget>[
                                                                  StarRating(
                                                                    size: 13.0,
                                                                    rating: double.tryParse(data[index]
                                                                            [
                                                                            'Star']
                                                                        .toString()),
                                                                    color: Colors
                                                                        .orange,
                                                                    borderColor:
                                                                        Colors
                                                                            .grey,
                                                                    starCount:
                                                                        5,
                                                                  ),
                                                                  Text(
                                                                      data[index]
                                                                              [
                                                                              'Star']
                                                                          .toString(),
                                                                      style: StylesText
                                                                          .style13BrownNormal)
                                                                ],
                                                              ),
                                                              data[index]['IsHot'] ==
                                                                      1
                                                                  ? Container(
                                                                      width: Dimension
                                                                          .getWidth(
                                                                              0.62),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
                                                                        children: <
                                                                            Widget>[
                                                                          SvgPicture
                                                                              .asset(
                                                                            'assets/icons/hot_tea.svg',
                                                                            height:
                                                                                Dimension.getHeight(0.035),
                                                                            width:
                                                                                Dimension.getHeight(0.1),
                                                                            color:
                                                                                Colors.redAccent,
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
                                                      padding: const EdgeInsets
                                                          .fromLTRB(0, 5, 0, 0),
                                                      child: Container(
                                                        child: CustomPaint(
                                                            painter: Drawhorizontalline(
                                                                false,
                                                                0.0,
                                                                Dimension
                                                                    .getWidth(
                                                                        1.0),
                                                                Colors.blueGrey,
                                                                0.5)),
                                                      )),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 15, 0, 0),
                                                    child: Container(
                                                      width: Dimension.getWidth(
                                                          0.63),
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
                                                                children: <
                                                                    Widget>[
                                                                  Icon(
                                                                    Icons
                                                                        .monetization_on,
                                                                    color: Colors
                                                                        .redAccent,
                                                                  ),
                                                                  Text(
                                                                    data[index][
                                                                            'Price']
                                                                        .toString(),
                                                                    style: StylesText
                                                                        .style13BrownBold,
                                                                  )
                                                                ],
                                                              ),
                                                              Container(
                                                                width: Dimension
                                                                    .getWidth(
                                                                        0.63),
                                                                child: promotionListProduct ==
                                                                            null ||
                                                                        promotionListProduct.length ==
                                                                            0
                                                                    ? IgnorePointer(
                                                                        ignoring:
                                                                            true,
                                                                        child: Opacity(
                                                                            opacity: 0.0,
                                                                            child: Container(
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                                children: <Widget>[
                                                                                  Icon(
                                                                                    Icons.fastfood,
                                                                                    color: Colors.redAccent,
                                                                                  ),
                                                                                  Text(
                                                                                    promotionProduct.toString() + " " + allTranslations.text("discount").toString(),
                                                                                    style: StylesText.style13BrownBold,
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            )),
                                                                      )
                                                                    : Container(
                                                                        width: Dimension.getWidth(
                                                                            0.51),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                          children: <
                                                                              Widget>[
                                                                            Icon(
                                                                              Icons.fastfood,
                                                                              color: Colors.redAccent,
                                                                            ),
                                                                            Text(
                                                                              promotionProduct.toString() + " discount",
                                                                              style: StylesText.style13BrownBold,
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ]),
                                      ),
                                    )),
                              ),
                            ),
                          );
                        }),
                  )),
          drawer: Drawer(
            child: HomeMenu(),
          ),
        ));
  }

  Future<void> refreshPage() async {
    await Future.delayed(Duration(seconds: 1));
    await initData();

    if (this.mounted) {
      setState(() {
        build(context);
      });
    }
  }
}
