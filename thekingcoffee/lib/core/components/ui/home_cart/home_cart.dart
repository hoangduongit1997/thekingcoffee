import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/app/data/model/topping.dart';
import 'package:thekingcoffee/app/data/repository/get_data_all_product.dart';
import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/core/components/ui/show_dialog/loading_dialog_order.dart';
import 'package:thekingcoffee/core/components/widgets/drawline.dart';
import 'package:thekingcoffee/core/components/widgets/favorite.dart';
import 'package:thekingcoffee/core/components/widgets/rating.dart';
import 'package:thekingcoffee/core/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Home_Card_State extends StatefulWidget {
  Home_Card_State({Key key}) : super(key: key);

  _Home_CardState createState() => _Home_CardState();
}
var size=[];
var data = [];
var topping=[];
int lenght = 0;

class _Home_CardState extends State<Home_Card_State> {
  intDataHomeScreen() async {
    final result = await Get_Data_All_Product();
    setState(() {
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
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: Dimension.getHeight(0.41),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: lenght,
                          itemBuilder: (BuildContext context, int index) {
                            if (data == null) {
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
                                                          imageUrl: Config.ip +
                                                              data[index]
                                                                  ['File_Path'],
                                                          fit: BoxFit.fill,
                                                          placeholder:
                                                              (context, url) =>
                                                                  new SizedBox(
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          CircularProgressIndicator(
                                                                        valueColor:
                                                                            new AlwaysStoppedAnimation(Colors.redAccent),
                                                                      ),
                                                                    ),
                                                                  ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Favorite(
                                                    color: Colors.grey,
                                                  ),
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
                                                    Text(
                                                      data[index]['Name'],
                                                      style: StylesText
                                                          .style17BrownBold,
                                                    ),
                                                  ],
                                                ),
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 0),
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
                                                    data[index]['Start']
                                                        .toString(),
                                                    style: StylesText
                                                        .style13BrownNormal)
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                5, 10, 50, 0),
                                            child: Container(
                                                child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                CustomPaint(
                                                    painter: Drawhorizontalline(
                                                        false)),
                                              ],
                                            )),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 0),
                                            child: Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(0.0),
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white,
                                                    foregroundColor:
                                                        Colors.redAccent,
                                                    radius: 12.0,
                                                    child: Icon(
                                                      Icons.monetization_on,
                                                      color: Colors.redAccent,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          5, 0, 0, 0),
                                                  child: Text(
                                                      data[index]['Price']
                                                          .toString(),
                                                      style: StylesText
                                                          .style16BrownBold),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
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
                                                            Icons.access_alarms,
                                                            color: Colors
                                                                .redAccent,
                                                          ),
                                                          Text(
                                                            "1h30p",
                                                            style: StylesText
                                                                .style12Brown300,
                                                          )
                                                        ],
                                                      ),
                                                      Container(
                                                        width:
                                                            Dimension.getWidth(
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
                                                              "4 servings",
                                                              style: StylesText
                                                                  .style12Brown300,
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
                                    size=data[index]['Size'],
                                    topping=data[index]['Toppings'],
                                   
                                        LoadingDialog_Order.showLoadingDialog(
                                          context,
                                          data[index]['Name'].toString(),
                                          data[index]['File_Path'].toString(),
                                          data[index]['Description'].toString(),
                                          data[index]['Price'].toString(),
                                          data[index]['Toppings'].toString(),
                                          data[index]['Size'].toString(),

                                          
                                        ),
                                       
                                      });
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
