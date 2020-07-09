import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oktoast/oktoast.dart';
import 'package:thekingcoffee/src/app/core/components/lib/change_language/change_language.dart';
import 'package:thekingcoffee/src/app/core/components/widgets/drawline.dart';
import 'package:thekingcoffee/src/app/core/components/widgets/favorite.dart';
import 'package:thekingcoffee/src/app/core/components/widgets/home_cart/home_cart_coffee.dart';
import 'package:thekingcoffee/src/app/core/components/widgets/rating.dart';
import 'package:thekingcoffee/src/app/core/components/widgets/show_dialog/loading_dialog.dart';
import 'package:thekingcoffee/src/app/core/components/widgets/show_dialog/loading_dialog_order.dart';
import 'package:thekingcoffee/src/app/core/config.dart';
import 'package:thekingcoffee/src/app/core/utils.dart';
import 'package:thekingcoffee/src/app/theme/styles.dart';

class FindFood extends StatefulWidget {
  FindFood({Key key}) : super(key: key);

  _FindFoodState createState() => _FindFoodState();
}

class _FindFoodState extends State<FindFood> {
  int promotionProduct = 0;
  var promotionListProduct = [];
  TextEditingController food = new TextEditingController();
  var searchResult = [];
  int length = 0;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        leading: FlatButton(
          child: Icon(
            Icons.arrow_back,
            color: Colors.brown,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.transparent,
        title: Container(
          width: double.infinity,
          height: Dimension.getHeight(0.1),
          child: Stack(
            alignment: AlignmentDirectional.centerStart,
            children: <Widget>[
              Positioned(
                right: 0.0,
                top: 0.0,
                width: 40,
                height: 60,
                child: Center(
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        promotionProduct = 0;
                        promotionListProduct = [];
                        length = 0;
                        searchResult = [];
                        food.clear();
                      });
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 0, right: 50),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: allTranslations.text("search").toString(),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent),
                    ),
                  ),
                  controller: food,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (str) async {
                    LoadingDialog.showLoadingDialog(context,
                        allTranslations.text("splash_screen").toString());
                    if (str.length > 0) {
                      final resutl = await api.findFood(str);
                      setState(() {
                        if (resutl != null) {
                          searchResult = resutl;
                          length = searchResult.length;
                          LoadingDialog.hideLoadingDialog(context);
                        } else {
                          length = 0;
                          LoadingDialog.hideLoadingDialog(context);
                        }
                      });
                    } else {
                      LoadingDialog.hideLoadingDialog(context);
                      showToast(
                        allTranslations.text("no_info").toString(),
                      );
                    }
                  },
                  style: StylesText.style15Black,
                ),
              ),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.grey[300],
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  color: Colors.white,
                  child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
                          width: double.infinity,
                          height: Dimension.getHeight(0.9),
                          child: Container(
                              child: RefreshIndicator(
                            backgroundColor: Colors.white,
                            color: Colors.redAccent,
                            child: ListView.builder(
                              itemCount: length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                promotionListProduct = searchResult[index]
                                    ['Sale'] as List<dynamic>;
                                promotionProduct = promotionListProduct.length;

                                return GestureDetector(
                                  onTap: () {
                                    if (searchResult[index]['IsAvailable'] ==
                                        false) {
                                      showToast(
                                        allTranslations
                                            .text("out_of_stock")
                                            .toString(),
                                      );
                                    } else {
                                      LoadingDialogOrder.showLoadingDialog(
                                          context,
                                          searchResult[index]['Id'],
                                          searchResult[index]['Name'],
                                          searchResult[index]['File_Path'],
                                          searchResult[index]['Description'],
                                          searchResult[index]['Price'],
                                          searchResult[index]['IsHot'],
                                          searchResult[index]['IsHot'],
                                          searchResult[index]['Toppings'],
                                          searchResult[index]['Size'],
                                          searchResult[index]['Sale'],
                                          listOrderProducts);
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Container(
                                        height: Dimension.getHeight(0.168),
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 5, 5, 5),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.grey[300]),
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
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  0, 0, 0, 0),
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
                                                                            BorderRadius.circular(8.0),
                                                                        child: CachedNetworkImage(
                                                                            imageUrl: domainAPI + searchResult[index]['File_Path'],
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
                                                                      isLogin ==
                                                                              true
                                                                          ? searchResult[index]['IsAvailable'] == true
                                                                              ? Favorite(Colors.red, searchResult[index]['Loved'], searchResult[index]['Id'])
                                                                              : SvgPicture.asset("assets/icons/sold.svg", width: Dimension.getWidth(0.05), height: Dimension.getHeight(0.05))
                                                                          : Container(
                                                                              child: searchResult[index]['IsAvailable'] == false ? SvgPicture.asset("assets/icons/sold.svg", width: Dimension.getWidth(0.05), height: Dimension.getHeight(0.05)) : Container(),
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                5, 0, 0, 0),
                                                        child: Center(
                                                          child: Container(
                                                            width: Dimension
                                                                .getWidth(0.62),
                                                            child: Text(
                                                                searchResult[
                                                                        index]
                                                                    ['Name'],
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: StylesText
                                                                    .style20BrownBold),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                0, 10, 0, 5),
                                                        child: Container(
                                                          width: Dimension
                                                              .getWidth(0.62),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Stack(
                                                                alignment:
                                                                    AlignmentDirectional
                                                                        .centerStart,
                                                                children: <
                                                                    Widget>[
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: <
                                                                        Widget>[
                                                                      StarRating(
                                                                        size:
                                                                            13.0,
                                                                        rating:
                                                                            double.tryParse(searchResult[index]['Star'].toString()),
                                                                        color: Colors
                                                                            .orange,
                                                                        borderColor:
                                                                            Colors.grey,
                                                                        starCount:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                          searchResult[index]['Star']
                                                                              .toString(),
                                                                          style:
                                                                              StylesText.style13BrownNormal)
                                                                    ],
                                                                  ),
                                                                  searchResult[index]
                                                                              [
                                                                              'IsHot'] ==
                                                                          1
                                                                      ? Container(
                                                                          width:
                                                                              Dimension.getWidth(0.62),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
                                                                            children: <Widget>[
                                                                              SvgPicture.asset(
                                                                                'assets/icons/hot_tea.svg',
                                                                                height: Dimension.getHeight(0.035),
                                                                                width: Dimension.getHeight(0.1),
                                                                                color: Colors.redAccent,
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
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  0, 5, 0, 0),
                                                          child: Container(
                                                            child: CustomPaint(
                                                                painter: Drawhorizontalline(
                                                                    false,
                                                                    0.0,
                                                                    Dimension
                                                                        .getWidth(
                                                                            1.0),
                                                                    Colors
                                                                        .blueGrey,
                                                                    0.5)),
                                                          )),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                0, 15, 0, 0),
                                                        child: Container(
                                                          width: Dimension
                                                              .getWidth(0.63),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Stack(
                                                                alignment:
                                                                    AlignmentDirectional
                                                                        .centerStart,
                                                                children: <
                                                                    Widget>[
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
                                                                        searchResult[index]['Price']
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
                                                                                        promotionProduct.toString() + " discount",
                                                                                        style: StylesText.style13BrownBold,
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                )),
                                                                          )
                                                                        : Container(
                                                                            width:
                                                                                Dimension.getWidth(0.51),
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              children: <Widget>[
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
                                );
                              },
                            ),
                            onRefresh: refreshPage,
                          )))))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> refreshPage() async {
    await Future.delayed(Duration(seconds: 1));
    searchResult = [];
    final resutl = await api.findFood(food.text);
    if (this.mounted) {
      setState(() {
        if (resutl != null) {
          searchResult = resutl;
          length = searchResult.length;
        } else {
          length = 0;
        }
      });
    }
  }
}
