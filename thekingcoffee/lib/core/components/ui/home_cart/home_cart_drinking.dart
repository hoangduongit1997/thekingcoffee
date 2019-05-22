import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thekingcoffee/app/config/config.dart';

import 'package:thekingcoffee/app/data/repository/get_drinking_products.dart';
import 'package:thekingcoffee/app/styles/styles.dart';
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
var data = [];
var topping = [];
var sanpham;
int lenght = 0;
int promotion_drinking=0;
var promotion_list_drinking=[];

class _Home_Card_Drinking_State extends State<Home_Card_Drinking> {
  intDataHomeScreen() async {
    final result = await Get_Drinking_Products();
    setState(() {
      //cho nay bi loi
      data = result;
      lenght = data.length;
    });
  }

  @override
  void initState() {
    this.intDataHomeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: Dimension.getHeight(0.35),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: lenght,
                      itemBuilder: (BuildContext context, int index) {
                        
                          promotion_list_drinking=data[index]['Promotion'] as List<dynamic>;
                        promotion_drinking=promotion_list_drinking.length;
                       
                         
                        if (data == null) {
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
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                                  height:
                                                      Dimension.getHeight(0.18),
                                                  width:
                                                      Dimension.getWidth(0.51),
                                                  decoration: new BoxDecoration(
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
                                                          data[index]
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
                                                                            Colors.redAccent),
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
                                                    data[index]['Name'],
                                                    style: StylesText
                                                        .style17BrownBold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 5),
                                        child: Row(
                                          children: <Widget>[
                                            StarRating(
                                              size: 13.0,
                                              rating: double.tryParse(
                                                  data[index]['Start']
                                                      .toString()),
                                              color: Colors.orange,
                                              borderColor: Colors.grey,
                                              starCount: 5,
                                            ),
                                            Text(
                                                data[index]['Start'].toString(),
                                                style: StylesText
                                                    .style13BrownNormal)
                                          ],
                                        ),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 0),
                                          child: Container(
                                            child: CustomPaint(
                                                painter: Drawhorizontalline(
                                                    false,
                                                    0.0,
                                                    215.0,
                                                    Colors.blueGrey,
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
                                                        data[index]['Price']
                                                            .toString(),
                                                        style: StylesText
                                                            .style13BrownBold,
                                                      )
                                                    ],
                                                  ),
                                                  promotion_list_drinking==null||promotion_list_drinking.length==0?IgnorePointer(
                                                   ignoring: true,
                                                   child: Opacity(
                                                     opacity: 0.0,
                                                     child: Container(
                                                    width: Dimension.getWidth(
                                                        0.51),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: <Widget>[
                                                        Icon(
                                                          Icons.fastfood,
                                                          color:
                                                              Colors.redAccent,
                                                        ),
                                                        Text(
                                                          promotion_drinking.toString()+" discount",
                                                          style: StylesText
                                                              .style13BrownBold,
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                   ),
                                                 ) :Container(
                                                    width: Dimension.getWidth(
                                                        0.51),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: <Widget>[
                                                        Icon(
                                                          Icons.fastfood,
                                                          color:
                                                              Colors.redAccent,
                                                        ),
                                                        Text(
                                                          promotion_drinking.toString()+" discount",
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
                                        data[index]['Id'],
                                        data[index]['Name'],
                                        data[index]['File_Path'],
                                        data[index]['Description'],
                                        data[index]['Price'],
                                        data[index]['IsHot'],
                                        
                                        data[index]['Toppings'],
                                        data[index]['Size'],
                                         data[index]['Promotion'],
                                        ListOrderProducts),
                                  });
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
