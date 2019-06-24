import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
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

class Home_Card_Food extends StatefulWidget {
  Home_Card_Food({Key key}) : super(key: key);

  _Home_Card_Food_State createState() => _Home_Card_Food_State();
}

var size = [];
var data_food = [];
var topping = [];
var sanpham;
int lenght = 0;
int promotion_food = 0;
var promotion_list_food = [];

class _Home_Card_Food_State extends State<Home_Card_Food> {
  intDataFoodScreen() async {
    final result = await Get_Food_Products();

    if (this.mounted) {
      if (result != null)
        setState(() {
          data_food = result;
          lenght = data_food.length;
        });
    }
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
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: lenght,
                  itemBuilder: (BuildContext context, int index) {
                    promotion_list_food =
                        data_food[index]['Promotion'] as List<dynamic>;
                    promotion_food = promotion_list_food.length;

                    if (data_food == null) {
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
                                                      data_food[index]
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
                                          Favorite(
                                            color: Colors.red,
                                          ),
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
                                                data_food[index]['Name'],
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
                                                        data_food[index]
                                                                ['Start']
                                                            .toString()),
                                                    color: Colors.orange,
                                                    borderColor: Colors.grey,
                                                    starCount: 5,
                                                  ),
                                                  Text(
                                                      data_food[index]['Start']
                                                          .toString(),
                                                      style: StylesText
                                                          .style13BrownNormal)
                                                ],
                                              ),
                                              data_food[index]['IsHot'] == 1
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
                                                    data_food[index]['Price']
                                                        .toString(),
                                                    style: StylesText
                                                        .style13BrownBold,
                                                  )
                                                ],
                                              ),
                                              promotion_list_food == null ||
                                                      promotion_list_food
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
                                                                  promotion_food
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
                                                            promotion_food
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
                          onTap: () => {
                                LoadingDialog_Order.showLoadingDialog(
                                    context,
                                    data_food[index]['Id'],
                                    data_food[index]['Name'],
                                    data_food[index]['File_Path'],
                                    data_food[index]['Description'],
                                    data_food[index]['Price'],
                                    data_food[index]['IsHot'],
                                    data_food[index]['IsHot'],
                                    data_food[index]['Toppings'],
                                    data_food[index]['Size'],
                                    data_food[index]['Promotion'],
                                    ListOrderProducts),
                              });
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
