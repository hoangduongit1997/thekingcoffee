import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/app/data/repository/find_food.dart';
import 'package:thekingcoffee/app/screens/dashboard.dart';
import 'package:thekingcoffee/app/screens/helper/dashboard_helper/placeholder_home.dart';
import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/core/components/lib/change_language/change_language.dart';
import 'package:thekingcoffee/core/components/ui/home_cart/home_cart_coffee.dart';
import 'package:thekingcoffee/core/components/ui/show_dialog/loading_dialog.dart';
import 'package:thekingcoffee/core/components/ui/show_dialog/loading_dialog_order.dart';
import 'package:thekingcoffee/core/components/widgets/drawline.dart';
import 'package:thekingcoffee/core/components/widgets/favorite.dart';
import 'package:thekingcoffee/core/components/widgets/rating.dart';
import 'package:thekingcoffee/core/utils/utils.dart';

class FindFood extends StatefulWidget {
  FindFood({Key key}) : super(key: key);

  _FindFoodState createState() => _FindFoodState();
}

class _FindFoodState extends State<FindFood> {
  int promotion_product = 0;
  var promotion_list_product = [];
  TextEditingController food = new TextEditingController();
  var search_result = [];
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
            Navigator.of(context, rootNavigator: true)
                .push(MaterialPageRoute(builder: (context) => DashBoard()));
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
                        promotion_product = 0;
                        promotion_list_product = [];
                        length = 0;
                        search_result = [];
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
                    LoadingDialog.showLoadingDialog(context, "Loading");
                    if (str.length > 0) {
                      final resutl = await Find_Food(str);
                      setState(() {
                        if (resutl != null) {
                          search_result = resutl;
                          length = search_result.length;
                          LoadingDialog.hideLoadingDialog(context);
                        } else {
                          length = 0;
                          LoadingDialog.hideLoadingDialog(context);
                        }
                      });
                    } else {
                      LoadingDialog.hideLoadingDialog(context);
                      Fluttertoast.showToast(
                          msg: "No information found",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIos: 1,
                          backgroundColor: Colors.redAccent,
                          textColor: Colors.white,
                          fontSize: 16.0);
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
                                promotion_list_product = search_result[index]
                                    ['Sale'] as List<dynamic>;
                                promotion_product =
                                    promotion_list_product.length;

                                return GestureDetector(
                                  onTap: () {
                                    LoadingDialog_Order.showLoadingDialog(
                                        context,
                                        search_result[index]['Id'],
                                        search_result[index]['Name'],
                                        search_result[index]['File_Path'],
                                        search_result[index]['Description'],
                                        search_result[index]['Price'],
                                        search_result[index]['IsHot'],
                                        search_result[index]['IsHot'],
                                        search_result[index]['Toppings'],
                                        search_result[index]['Size'],
                                        search_result[index]['Sale'],
                                        ListOrderProducts);
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
                                                                            imageUrl: Config.ip + search_result[index]['File_Path'],
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
                                                                      Favorite(
                                                                        color: Colors
                                                                            .red,
                                                                      ),
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
                                                                search_result[
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
                                                                            double.tryParse(search_result[index]['Start'].toString()),
                                                                        color: Colors
                                                                            .orange,
                                                                        borderColor:
                                                                            Colors.grey,
                                                                        starCount:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                          search_result[index]['Start']
                                                                              .toString(),
                                                                          style:
                                                                              StylesText.style13BrownNormal)
                                                                    ],
                                                                  ),
                                                                  search_result[index]
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
                                                                painter:
                                                                    Drawhorizontalline(
                                                                        false,
                                                                        0.0,
                                                                        300.0,
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
                                                                        search_result[index]['Price']
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
                                                                    child: promotion_list_product ==
                                                                                null ||
                                                                            promotion_list_product.length ==
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
                                                                                        promotion_product.toString() + " discount",
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
                                                                                  promotion_product.toString() + " discount",
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
    await Future.delayed(Duration(seconds: 2));

    final resutl = await Find_Food(food.text);
    setState(() {
      if (resutl != null) {
        search_result = resutl;
        length = search_result.length;
      } else {
        length = 0;
      }
    });
  }
}
