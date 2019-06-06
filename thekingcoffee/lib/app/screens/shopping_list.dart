import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thekingcoffee/app/bloc/order_bloc.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/app/data/repository/order_repository.dart';
import 'package:thekingcoffee/app/screens/dashboard.dart';

import 'package:thekingcoffee/app/styles/styles.dart';

import 'package:thekingcoffee/core/components/ui/draw_left/draw_left.dart';
import 'package:thekingcoffee/core/components/ui/home_cart/home_cart_coffee.dart';

import 'package:thekingcoffee/core/components/ui/show_dialog/edit_loading_dialog.dart';

import 'package:thekingcoffee/core/utils/utils.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Shopping_List extends StatefulWidget {
  Shopping_ListState createState() => Shopping_ListState();
}

class Shopping_ListState extends State<Shopping_List> {
  TextEditingController address = new TextEditingController();
  int multy_topping = 0;
  @override
  void initState() {
    super.initState();
  }

  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  OrderBloc orderBloc = new OrderBloc();
  TextEditingController name = new TextEditingController(text: "Hoàng Dương");
  TextEditingController phone = new TextEditingController(text: "0798353751");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.8,
        backgroundColor: Colors.white,
        title: Text(
          "Shopping List",
          style: StylesText.style20BrownBold,
        ),
        actions: <Widget>[
          ListOrderProducts.isEmpty
              ? Container()
              : FlatButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                            title: new Text("Confirm",
                                style: StylesText.style18RedaccentBold),
                            content: new Text(
                              "Do you want to delete all shopping list ?",
                              style: StylesText.style15Black,
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("No"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              FlatButton(
                                child: Text("Yes"),
                                onPressed: () {
                                  setState(() {
                                    ListOrderProducts.clear();
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                  },
                  child: Icon(
                    Icons.delete_forever,
                    color: Colors.redAccent,
                  ))
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: ListOrderProducts.isEmpty
          ? Container(
              child: Center(
                  child:
                      Text("No information", style: StylesText.style16Brown)),
            )
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(2.0),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "Delivery information",
                        style: StylesText.style13BlackBold,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: StreamBuilder<Object>(
                            stream: orderBloc.nameStream,
                            builder: (context, snapshot) {
                              return TextField(
                                decoration: InputDecoration(
                                    errorText: snapshot.hasError
                                        ? snapshot.error
                                        : null,
                                    icon: Icon(Icons.account_circle)),
                                controller: name,
                                style: StylesText.style15Black,
                              );
                            })),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: StreamBuilder<Object>(
                            stream: orderBloc.phoneStream,
                            builder: (context, snapshot) {
                              return TextField(
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                    icon: Icon(Icons.phone),
                                    errorText: snapshot.hasError
                                        ? snapshot.error
                                        : null),
                                controller: phone,
                                style: StylesText.style15Black,
                              );
                            })),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: StreamBuilder<Object>(
                            stream: orderBloc.addressStream,
                            builder: (context, snapshot) {
                              return TextField(
                                onTap: () {
                                  final result =
                                      Navigator.of(context, rootNavigator: true)
                                          .pushNamed('/map');
                                  result.then((result) {
                                    setState(() {
                                      address.text = result as String;
                                    });
                                  });
                                },
                                decoration: InputDecoration(
                                    errorText: snapshot.hasError
                                        ? snapshot.error
                                        : null,
                                    icon: Icon(Icons.map),
                                    hintText: "Enter your address..."),
                                controller: address,
                                style: StylesText.style15Black,
                              );
                            })),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Container(
                            child: RefreshIndicator(
                          backgroundColor: Colors.white,
                          color: Colors.redAccent,
                          onRefresh: refreshPage,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: ListOrderProducts.length,
                            itemBuilder: (context, index) {
                              var list_multy_topping = ListOrderProducts[index]
                                  ['Toppings'] as List<dynamic>;
                              if (list_multy_topping != null) {
                                multy_topping = list_multy_topping.length;
                              }

                              return Slidable(
                                delegate: new SlidableDrawerDelegate(),
                                actionExtentRatio: 0.25,
                                child: GestureDetector(
                                  onTap: () {
                                    var product = ListOrderProducts[index];
                                    LoadingDialog_Order().showLoadingDialog(
                                      index,
                                      context,
                                      product['Id'],
                                      product['Name'],
                                      product['Img'],
                                      "",
                                      product['Original_Price'],
                                      product['Price'],
                                      1,
                                      1,
                                      product['ListTopping'],
                                      product['ListSize'],
                                      product['Promotion'],
                                      [],
                                      product['Size'],
                                      product['Toppings'],
                                      product['SelectedPromotion'],
                                      product['check_promotion_product'],
                                      product['Note'],
                                    );
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Container(
                                          height: Dimension.getHeight(0.135),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.grey[300]),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8.0))),
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
                                                          AlignmentDirectional
                                                              .topEnd,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  0, 0, 0, 0),
                                                          child: Container(
                                                            height: Dimension
                                                                .getHeight(
                                                                    0.13),
                                                            width: Dimension
                                                                .getWidth(0.25),
                                                            decoration:
                                                                new BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              border: new Border
                                                                      .all(
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              child:
                                                                  CachedNetworkImage(
                                                                imageUrl: Config
                                                                        .ip +
                                                                    ListOrderProducts[
                                                                            index]
                                                                        ['Img'],
                                                                fit:
                                                                    BoxFit.fill,
                                                                placeholder: (context,
                                                                        url) =>
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
                                                      ],
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  5, 0, 0, 0),
                                                          child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: Row(
                                                                children: <
                                                                    Widget>[
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.fromLTRB(
                                                                            5,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      ListOrderProducts[
                                                                              index]
                                                                          [
                                                                          'Name'],
                                                                      style: StylesText
                                                                          .style15Black,
                                                                    ),
                                                                  ),
                                                                ],
                                                              )),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            ListOrderProducts[
                                                                            index]
                                                                        [
                                                                        'Size'] ==
                                                                    null
                                                                ? IgnorePointer(
                                                                    ignoring:
                                                                        true,
                                                                    child: Opacity(
                                                                        opacity: 0.0,
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.fromLTRB(
                                                                              10,
                                                                              10,
                                                                              0,
                                                                              10),
                                                                          child:
                                                                              Text("Size: " + "M"),
                                                                        )),
                                                                  )
                                                                : Padding(
                                                                    padding:
                                                                        const EdgeInsets.fromLTRB(
                                                                            10,
                                                                            10,
                                                                            0,
                                                                            10),
                                                                    child: Text(
                                                                        "Size: " +
                                                                            ListOrderProducts[index]['Size']['Name'].toString()),
                                                                  ),
                                                            ListOrderProducts[
                                                                            index][
                                                                        'Toppings'] ==
                                                                    null
                                                                ? Container()
                                                                : Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            50,
                                                                        top: 0,
                                                                        right:
                                                                            0,
                                                                        bottom:
                                                                            0),
                                                                    child: multy_topping >
                                                                            1
                                                                        ? Text(
                                                                            "Topping: " +
                                                                                ListOrderProducts[index]['Toppings'][0]['Name'] +
                                                                                "...",
                                                                          )
                                                                        : Text(
                                                                            "Topping: " +
                                                                                ListOrderProducts[index]['Toppings'][0]['Name'],
                                                                          ))
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  10, 0, 0, 0),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Text("Quanlity: " +
                                                                  ListOrderProducts[
                                                                              index]
                                                                          [
                                                                          'Quantity']
                                                                      .toString()),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        170,
                                                                        0,
                                                                        0,
                                                                        0),
                                                                child: Text(
                                                                  ListOrderProducts[
                                                                              index]
                                                                          [
                                                                          'Price']
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .red),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ]))),
                                ),
                                secondaryActions: <Widget>[
                                  new IconSlideAction(
                                      caption: 'Delete',
                                      color: Colors.red,
                                      icon: Icons.delete,
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                15.0))),
                                                title: new Text("Confirm",
                                                    style: StylesText
                                                        .style18RedaccentBold),
                                                content: new Text(
                                                  "Do you want to delete " +
                                                      ListOrderProducts[index]
                                                              ['Name']
                                                          .toString() +
                                                      "?",
                                                  style:
                                                      StylesText.style15Black,
                                                ),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    child: Text("No"),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  FlatButton(
                                                    child: Text("Yes"),
                                                    onPressed: () {
                                                      setState(() {
                                                        ListOrderProducts
                                                            .removeAt(index);
                                                      });
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            });
                                      }),
                                ],
                              );
                            },
                          ),
                        ))),
                  ],
                ),
              ),
            ),
      drawer: Drawer(
        child: HomeMenu(),
      ),
      bottomNavigationBar: ListOrderProducts.isEmpty
          ? Container(
              child: Center(
                  child:
                      Text("No information", style: StylesText.style16Brown)),
            )
          : new Container(
              height: Dimension.getHeight(0.05),
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => DashBoard()));
                    },
                    child: Text(
                      "Continue shopping",
                      style: StylesText.style14BrownBold,
                    ),
                    color: Colors.white,
                  )),
                  Expanded(
                    child: MaterialButton(
                        onPressed: () async {
                          if (orderBloc.isValidInfo(
                                  name.text.trim().toString(),
                                  phone.text.trim().toString(),
                                  address.text.trim().toString()) ==
                              true) {
                            if (await PostOrder(phone.text.trim().toString(),
                                    address.text.trim().toString()) ==
                                true) {}
                          }
                        },
                        child: Text(
                          "Purchase ",
                          style: StylesText.style14While,
                        ),
                        color: Colors.redAccent),
                  )
                ],
              ),
            ),
    );
  }

  Future<void> refreshPage() async {
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      build(context);
    });
  }
}
