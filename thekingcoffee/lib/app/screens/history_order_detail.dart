import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/app/data/repository/get_history.dart';
import 'package:thekingcoffee/app/screens/helper/dashboard_helper/placeholder_home.dart';
import 'package:thekingcoffee/app/screens/history.dart';
import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/core/components/ui/home_cart/home_cart_coffee.dart';
import 'package:thekingcoffee/core/utils/utils.dart';

class History_Order_Detail extends StatefulWidget {
  int order_code;
  var list_detailed_product = [];
  History_Order_Detail(this.list_detailed_product, this.order_code);
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History_Order_Detail> {
  @override
  void initState() {
    Config.isHideNavigation = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.5,
            title: Text(
              "Order " + widget.order_code.toString(),
              style: StylesText.style20BrownBold,
            ),
            leading: FlatButton(
              onPressed: () {
                Config.isHideNavigation = false;
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => History()));
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.brown,
              ),
            ),
          ),
          resizeToAvoidBottomInset: false,
          body: Container(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
            color: Colors.blueGrey,
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: widget.list_detailed_product.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      height: Dimension.getHeight(0.15),
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[300]),
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
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
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Container(
                                      height: Dimension.getHeight(0.13),
                                      width: Dimension.getWidth(0.25),
                                      decoration: new BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        border:
                                            new Border.all(color: Colors.grey),
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: CachedNetworkImage(
                                          imageUrl: Config.ip +
                                              widget
                                                  .list_detailed_product[index]
                                                          ['DetailedProduct']
                                                      ['File_Path']
                                                  .toString(),
                                          fit: BoxFit.fill,
                                          placeholder: (context, url) =>
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
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                    child: Container(
                                        alignment: Alignment.topLeft,
                                        child: Row(
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      5, 0, 0, 0),
                                              child: Text(
                                                widget.list_detailed_product[
                                                        index]
                                                    ['DetailedProduct']['Name'],
                                                style: StylesText.style15Black,
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ));
  }
}
