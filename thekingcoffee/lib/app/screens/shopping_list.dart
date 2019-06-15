import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thekingcoffee/app/bloc/order_bloc.dart';
import 'package:thekingcoffee/app/bloc/place_bloc.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/app/data/model/get_place_item.dart';
import 'package:thekingcoffee/app/data/repository/check_enought_point.dart';
import 'package:thekingcoffee/app/data/repository/order_repository.dart';

import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/core/components/lib/change_language/change_language.dart';

import 'package:thekingcoffee/core/components/ui/draw_left/draw_left.dart';
import 'package:thekingcoffee/core/components/ui/home_cart/home_cart_coffee.dart';
import 'package:thekingcoffee/core/components/ui/show_dialog/coupon_dialog.dart';

import 'package:thekingcoffee/core/components/ui/show_dialog/edit_loading_dialog.dart';
import 'package:thekingcoffee/core/components/ui/show_dialog/loading_dialog.dart';
import 'package:thekingcoffee/core/components/ui/show_dialog/payment_dialog.dart';
import 'package:thekingcoffee/core/components/ui/show_dialog/show_message_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:thekingcoffee/core/components/widgets/drawline.dart';
import 'package:thekingcoffee/core/utils/utils.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Shopping_List extends StatefulWidget {
  Shopping_ListState createState() => Shopping_ListState();
}

enum SingingCharacter { lafayette, jefferson }

class Shopping_ListState extends State<Shopping_List> {
  SingingCharacter _character = SingingCharacter.lafayette;

  TextEditingController address = new TextEditingController();
  int multy_topping = 0;
  int total_money = 0;
  int user_point = 0;

  flus_total_money() {
    for (var item in ListOrderProducts) {
      setState(() {
        total_money += item['Price'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    flus_total_money();
  }

  var placeBloc = PlaceBloc();
  OrderBloc orderBloc = new OrderBloc();
  TextEditingController name = new TextEditingController(text: "Hoàng Dương");
  TextEditingController phone = new TextEditingController(text: "0798353751");
  bool ischecked_address = false;
  @override
  void dispose() {
    placeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0.8,
            backgroundColor: Colors.white,
            title: Text(
              allTranslations.text("shopping_list").toString(),
              style: StylesText.style20BrownBold,
            ),
            actions: <Widget>[
              ListOrderProducts.isEmpty
                  ? Container()
                  : FlatButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0))),
                                title: new Text(
                                    allTranslations.text("confirm").toString(),
                                    style: StylesText.style18RedaccentBold),
                                content: new Text(
                                  allTranslations.text("do_you").toString(),
                                  style: StylesText.style15Black,
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Container(
                                      width: Dimension.getWidth(0.28),
                                      height: Dimension.getHeight(0.04),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0)),
                                          color: Colors.brown),
                                      child: Center(
                                          child: Text(
                                        allTranslations
                                            .text("cancel")
                                            .toString(),
                                        style: StylesText.style14While,
                                      )),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  FlatButton(
                                    child: Container(
                                        width: Dimension.getWidth(0.28),
                                        height: Dimension.getHeight(0.04),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0)),
                                            color: Colors.redAccent),
                                        child: Center(
                                          child: Text(
                                              allTranslations
                                                  .text("yes")
                                                  .toString(),
                                              style: StylesText.style14While),
                                        )),
                                    onPressed: () {
                                      setState(() {
                                        total_money = 0;
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
          body: SingleChildScrollView(
            child: ListOrderProducts.isEmpty
                ? Container()
                : Container(
                    padding: const EdgeInsets.all(2.0),
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.fromLTRB(2, 0, 2, 2),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  width: double.infinity,
                                  child: Container(
                                    color: Colors.grey[200],
                                    height: Dimension.getHeight(0.05),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Text(
                                          allTranslations
                                              .text("Delivery_information")
                                              .toString(),
                                          style: StylesText.style15Black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                          child: StreamBuilder<Object>(
                                              stream: orderBloc.nameStream,
                                              builder: (context, snapshot) {
                                                return TextField(
                                                  decoration: InputDecoration(
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .redAccent),
                                                      ),
                                                      errorText:
                                                          snapshot.hasError
                                                              ? snapshot.error
                                                              : null,
                                                      icon: Icon(
                                                        Icons.account_circle,
                                                      )),
                                                  controller: name,
                                                  style:
                                                      StylesText.style15Black,
                                                );
                                              })),
                                    ),
                                    Expanded(
                                      child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                          child: StreamBuilder<Object>(
                                              stream: orderBloc.phoneStream,
                                              builder: (context, snapshot) {
                                                return TextField(
                                                  keyboardType:
                                                      TextInputType.phone,
                                                  decoration: InputDecoration(
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .redAccent),
                                                      ),
                                                      icon: Icon(
                                                        Icons.phone,
                                                      ),
                                                      errorText:
                                                          snapshot.hasError
                                                              ? snapshot.error
                                                              : null),
                                                  controller: phone,
                                                  style:
                                                      StylesText.style15Black,
                                                );
                                              })),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 7,
                                      child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                          child: StreamBuilder<Object>(
                                              stream: orderBloc.addressStream,
                                              builder: (context, snapshot) {
                                                return TextField(
                                                  textInputAction:
                                                      TextInputAction.search,
                                                  autofocus: false,
                                                  textAlign: TextAlign.left,
                                                  decoration: InputDecoration(
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .redAccent),
                                                      ),
                                                      errorText:
                                                          snapshot.hasError
                                                              ? snapshot.error
                                                              : null,
                                                      icon: Icon(
                                                        Icons.map,
                                                      ),
                                                      hintText: allTranslations
                                                          .text("enter_address")
                                                          .toString()),
                                                  controller: address,
                                                  style:
                                                      StylesText.style15Black,
                                                  onSubmitted: (str) {
                                                    ischecked_address = false;
                                                    placeBloc.searchPlace(str);
                                                  },
                                                );
                                              })),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: FlatButton(
                                          splashColor: Colors.grey[300],
                                          child: SvgPicture.asset(
                                            "assets/icons/earth.svg",
                                            color: Colors.redAccent,
                                            width: Dimension.getWidth(0.08),
                                            height: Dimension.getHeight(0.08),
                                          ),
                                          onPressed: () {
                                            final result = Navigator.of(context,
                                                    rootNavigator: true)
                                                .pushNamed('/map');
                                            result.then((result) {
                                              setState(() {
                                                address.text = result as String;
                                              });
                                            });
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        ischecked_address == false
                            ? Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      color: Colors.grey[200],
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: StreamBuilder(
                                          stream: placeBloc.placeStream,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              if (snapshot.data == "Search") {
                                                return Container();
                                              }
                                              List<Get_Place_Item> places =
                                                  snapshot.data;
                                              return Container(
                                                width: double.infinity,
                                                height:
                                                    Dimension.getHeight(0.4),
                                                child: ListView.separated(
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return ListTile(
                                                        leading: Icon(
                                                            Icons.location_city,
                                                            color: Colors.grey),
                                                        title: Text(places
                                                            .elementAt(index)
                                                            .name),
                                                        subtitle: Text(places
                                                            .elementAt(index)
                                                            .address),
                                                        onTap: () async {
                                                          SharedPreferences
                                                              pref =
                                                              await SharedPreferences
                                                                  .getInstance();
                                                          await pref.setDouble(
                                                              "Lat",
                                                              places
                                                                  .elementAt(
                                                                      index)
                                                                  .lat);
                                                          await pref.setDouble(
                                                              "Lng",
                                                              places
                                                                  .elementAt(
                                                                      index)
                                                                  .lng);

                                                          setState(() {
                                                            address.text =
                                                                places
                                                                    .elementAt(
                                                                        index)
                                                                    .address;
                                                            places.clear();
                                                            ischecked_address =
                                                                true;
                                                          });
                                                        },
                                                      );
                                                    },
                                                    separatorBuilder: (context,
                                                            index) =>
                                                        Divider(
                                                          height: 1,
                                                          color:
                                                              Color(0xfff5f5f5),
                                                        ),
                                                    itemCount: places.length),
                                              );
                                            } else {
                                              return Container();
                                            }
                                          }),
                                    ),
                                  ],
                                ))
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    color: Colors.grey[200],
                                    height: Dimension.getHeight(0.05),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Text(
                                            allTranslations
                                                .text("List_detailed_order")
                                                .toString(),
                                            style: StylesText.style15Black),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Container(
                                      child: ConstrainedBox(
                                    constraints: new BoxConstraints(
                                      minHeight: Dimension.getHeight(0.1),
                                      minWidth: double.infinity,
                                      maxHeight: Dimension.getHeight(0.3),
                                      maxWidth: double.infinity,
                                    ),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: ListOrderProducts.length,
                                      itemBuilder: (context, index) {
                                        var list_multy_topping =
                                            ListOrderProducts[index]['Toppings']
                                                as List<dynamic>;
                                        if (list_multy_topping != null) {
                                          multy_topping =
                                              list_multy_topping.length;
                                        }

                                        return Slidable(
                                          delegate:
                                              new SlidableDrawerDelegate(),
                                          actionExtentRatio: 0.25,
                                          child: GestureDetector(
                                            onTap: () {
                                              var product =
                                                  ListOrderProducts[index];
                                              LoadingDialog_Order()
                                                  .showLoadingDialog(
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
                                                      product[
                                                          'SelectedPromotion'],
                                                      product[
                                                          'check_promotion_product'],
                                                      product['Note'],
                                                      product['Quantity'],
                                                      this.updateShoppingList);
                                            },
                                            child: Container(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Container(
                                                    height: Dimension.getHeight(
                                                        0.1),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            color: Colors
                                                                .grey[300]),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8.0))),
                                                    child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Row(
                                                            children: <Widget>[
                                                              Stack(
                                                                alignment:
                                                                    AlignmentDirectional
                                                                        .topEnd,
                                                                children: <
                                                                    Widget>[
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.fromLTRB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child:
                                                                        Container(
                                                                      height: Dimension
                                                                          .getHeight(
                                                                              0.08),
                                                                      width: Dimension
                                                                          .getWidth(
                                                                              0.15),
                                                                      decoration:
                                                                          new BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                        border: new Border.all(
                                                                            color:
                                                                                Colors.grey),
                                                                      ),
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                        child:
                                                                            CachedNetworkImage(
                                                                          imageUrl:
                                                                              Config.ip + ListOrderProducts[index]['Img'],
                                                                          fit: BoxFit
                                                                              .fill,
                                                                          placeholder: (context, url) =>
                                                                              new SizedBox(
                                                                                child: Center(
                                                                                  child: CircularProgressIndicator(
                                                                                    valueColor: new AlwaysStoppedAnimation(Colors.redAccent),
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
                                                                children: <
                                                                    Widget>[
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.fromLTRB(
                                                                            5,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child: Container(
                                                                        alignment: Alignment.topLeft,
                                                                        child: Row(
                                                                          children: <
                                                                              Widget>[
                                                                            Padding(
                                                                              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                                                              child: Container(
                                                                                width: Dimension.getWidth(0.7),
                                                                                child: Text(
                                                                                  ListOrderProducts[index]['Name'],
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  style: StylesText.style15Black,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        )),
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: <
                                                                        Widget>[
                                                                      ListOrderProducts[index]['Size'] ==
                                                                              null
                                                                          ? IgnorePointer(
                                                                              ignoring: true,
                                                                              child: Opacity(
                                                                                  opacity: 0.0,
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                                                                                    child: Text("Size: " + "M"),
                                                                                  )),
                                                                            )
                                                                          : Padding(
                                                                              padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                                                                              child: Text("Size: " + ListOrderProducts[index]['Size']['Name'].toString()),
                                                                            ),
                                                                      ListOrderProducts[index]['Toppings'] ==
                                                                              null
                                                                          ? Container()
                                                                          : Padding(
                                                                              padding: const EdgeInsets.only(left: 50, top: 0, right: 0, bottom: 0),
                                                                              child: multy_topping > 1
                                                                                  ? Text(
                                                                                      "Topping: " + ListOrderProducts[index]['Toppings'][0]['Name'] + "...",
                                                                                    )
                                                                                  : Text(
                                                                                      "Topping: " + ListOrderProducts[index]['Toppings'][0]['Name'],
                                                                                    ))
                                                                    ],
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.fromLTRB(
                                                                            10,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child: Row(
                                                                      children: <
                                                                          Widget>[
                                                                        Text(allTranslations.text("Quanlity").toString() +
                                                                            " " +
                                                                            ListOrderProducts[index]['Quantity'].toString()),
                                                                        Padding(
                                                                          padding: const EdgeInsets.fromLTRB(
                                                                              170,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                          child:
                                                                              Text(
                                                                            ListOrderProducts[index]['Price'].toString(),
                                                                            style:
                                                                                TextStyle(color: Colors.red),
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
                                                caption: allTranslations
                                                    .text("delete")
                                                    .toString(),
                                                color: Colors.red,
                                                icon: Icons.delete,
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      barrierDismissible: true,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          15.0))),
                                                          title: new Text(
                                                              allTranslations
                                                                  .text(
                                                                      "confirm")
                                                                  .toString(),
                                                              style: StylesText
                                                                  .style18RedaccentBold),
                                                          content: new Text(
                                                            allTranslations
                                                                    .text(
                                                                        "do_you_want")
                                                                    .toString() +
                                                                " " +
                                                                ListOrderProducts[
                                                                            index]
                                                                        ['Name']
                                                                    .toString() +
                                                                "?",
                                                            style: StylesText
                                                                .style15Black,
                                                          ),
                                                          actions: <Widget>[
                                                            FlatButton(
                                                              child: Container(
                                                                width: Dimension
                                                                    .getWidth(
                                                                        0.28),
                                                                height: Dimension
                                                                    .getHeight(
                                                                        0.04),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.all(Radius.circular(
                                                                            15.0)),
                                                                    color: Colors
                                                                        .brown),
                                                                child: Center(
                                                                    child: Text(
                                                                  allTranslations
                                                                      .text(
                                                                          "cancel")
                                                                      .toString(),
                                                                  style: StylesText
                                                                      .style14While,
                                                                )),
                                                              ),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                            FlatButton(
                                                              child: Container(
                                                                  width: Dimension
                                                                      .getWidth(
                                                                          0.28),
                                                                  height: Dimension
                                                                      .getHeight(
                                                                          0.04),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.all(Radius.circular(
                                                                              15.0)),
                                                                      color: Colors
                                                                          .redAccent),
                                                                  child: Center(
                                                                    child: Text(
                                                                        allTranslations
                                                                            .text(
                                                                                "yes")
                                                                            .toString(),
                                                                        style: StylesText
                                                                            .style14While),
                                                                  )),
                                                              onPressed: () {
                                                                setState(() {
                                                                  total_money -=
                                                                      ListOrderProducts[
                                                                              index]
                                                                          [
                                                                          'Price'];
                                                                  ListOrderProducts
                                                                      .removeAt(
                                                                          index);
                                                                });
                                                                Navigator.of(
                                                                        context)
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
                                  )),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text(
                                  allTranslations.text("estimate").toString(),
                                  style: StylesText.style14Black,
                                ),
                                Text(
                                  total_money.toString(),
                                  style: StylesText.style14Black,
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text(
                                  allTranslations
                                      .text("shipping_fee")
                                      .toString(),
                                  style: StylesText.style14Black,
                                ),
                                Text(
                                  total_money.toString(),
                                  style: StylesText.style14Black,
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: Container(
                              child: CustomPaint(
                                  painter: Drawhorizontalline(
                                      false,
                                      0.0,
                                      Dimension.getWidth(1.0),
                                      Colors.blueGrey[300],
                                      0.3)),
                            )),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text(
                                  allTranslations
                                      .text("total_money")
                                      .toString(),
                                  style: StylesText.style16BlackNormal,
                                ),
                                Text(
                                  total_money.toString(),
                                  style: StylesText.style16BlackNormal,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
          ),
          drawer: Drawer(
            child: HomeMenu(),
          ),
          bottomNavigationBar: Container(
            child: ListOrderProducts.isEmpty
                ? Container(
                    child: Center(
                        child: Text(allTranslations.text("no_info").toString(),
                            style: StylesText.style16Brown)),
                  )
                : new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                                child: OutlineButton(
                              splashColor: Colors.white,
                              borderSide: BorderSide(
                                color: Colors.redAccent,
                                style: BorderStyle.solid,
                                width: 0.8,
                              ),
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    allTranslations
                                            .text("total_money")
                                            .toString() +
                                        " " +
                                        total_money.toString() +
                                        " VND",
                                    style: StylesText.style13BrownBold,
                                  ),
                                ],
                              ),
                              color: Colors.white,
                            )),
                            Expanded(
                              child: OutlineButton(
                                  splashColor: Colors.grey[300],
                                  borderSide: BorderSide(
                                    color: Colors.redAccent,
                                    style: BorderStyle.solid,
                                    width: 0.8,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (_) => Coupon_Dialog());
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 5, 0),
                                        child: Icon(
                                          Icons.card_giftcard,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                      Text(
                                        allTranslations
                                            .text("Coupon_code")
                                            .toString(),
                                        style: StylesText.style13BrownBold,
                                      ),
                                    ],
                                  ),
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                              child: MaterialButton(
                                  onPressed: () async {
                                    LoadingDialog.showLoadingDialog(context,
                                        allTranslations.text("splash_screen"));
                                    if ((await check_enough_point(
                                                total_money)) ==
                                            true &&
                                        orderBloc.isValidInfo(
                                                name.text.trim().toString(),
                                                phone.text.trim().toString(),
                                                address.text
                                                    .trim()
                                                    .toString()) ==
                                            true) {
                                      LoadingDialog.hideLoadingDialog(context);
                                      showDialog(
                                              context: context,
                                              builder: (_) => Payment_Dialog(
                                                  phone.text.trim().toString(),
                                                  address.text
                                                      .trim()
                                                      .toString()))
                                          .then((value) => setState(() {
                                                if (value != null) {
                                                  ListOrderProducts.clear();
                                                } else {}
                                              }));
                                    } else {
                                      if (orderBloc.isValidInfo(
                                              name.text.trim().toString(),
                                              phone.text.trim().toString(),
                                              address.text.trim().toString()) ==
                                          true) {
                                        if (await PostOrder(
                                                phone.text.trim().toString(),
                                                address.text
                                                    .trim()
                                                    .toString()) ==
                                            true) {
                                          LoadingDialog.hideLoadingDialog(
                                              context);
                                          MsgDialog.showMsgDialog(
                                              context,
                                              allTranslations
                                                  .text("Information")
                                                  .toString(),
                                              allTranslations
                                                  .text("order_suc")
                                                  .toString());
                                          setState(() {
                                            total_money = 0;
                                            ListOrderProducts.clear();
                                          });
                                        }
                                      } else {
                                        LoadingDialog.hideLoadingDialog(
                                            context);
                                        MsgDialog.showMsgDialog(
                                            context,
                                            allTranslations
                                                .text("Information")
                                                .toString(),
                                            allTranslations
                                                .text("order_false")
                                                .toString());
                                      }
                                    }
                                  },
                                  child: Text(
                                    allTranslations.text("Purchase").toString(),
                                    style: StylesText.style16While,
                                  ),
                                  color: Colors.redAccent),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ));
  }

  void updateShoppingList() {
    int total = ListOrderProducts.fold(0, (t, e) => t + e['Price']);
    setState(() {
      build(context);
      total_money = total;
    });
  }
}
