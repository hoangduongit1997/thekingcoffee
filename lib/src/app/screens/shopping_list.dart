import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:thekingcoffee/main.dart';
import 'package:thekingcoffee/src/app/core/components/lib/change_language/change_language.dart';
import 'package:thekingcoffee/src/app/core/components/widgets/draw_left/draw_left.dart';
import 'package:thekingcoffee/src/app/core/components/widgets/drawline.dart';
import 'package:thekingcoffee/src/app/core/components/widgets/home_cart/home_cart_coffee.dart';
import 'package:thekingcoffee/src/app/core/components/widgets/show_dialog/coupon_dialog.dart';
import 'package:thekingcoffee/src/app/core/components/widgets/show_dialog/edit_loading_dialog.dart';
import 'package:thekingcoffee/src/app/core/components/widgets/show_dialog/loading_dialog.dart';
import 'package:thekingcoffee/src/app/core/components/widgets/show_dialog/payment_dialog.dart';
import 'package:thekingcoffee/src/app/core/components/widgets/show_dialog/show_message_dialog.dart';
import 'package:thekingcoffee/src/app/core/config.dart';
import 'package:thekingcoffee/src/app/core/utils.dart';
import 'package:thekingcoffee/src/app/core/validation.dart';
import 'package:thekingcoffee/src/app/model/get_place_item.dart';
import 'package:thekingcoffee/src/app/streams/order_bloc.dart';
import 'package:thekingcoffee/src/app/streams/place_bloc.dart';
import 'package:thekingcoffee/src/app/theme/styles.dart';

class ShoppingList extends StatefulWidget {
  ShoppingListState createState() => ShoppingListState();
}

enum SingingCharacter { lafayette, jefferson }
int feeShip = 0;
TextEditingController address = new TextEditingController();

class ShoppingListState extends State<ShoppingList> {
  int multyTopping = 0;
  int estimate = 0;
  int userPoint = 0;
  String fullName = "";
  String phoneNumber = "";
  getInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (this.mounted) {
      setState(() {
        fullName = pref.getString('name');
        phoneNumber = pref.getString('phone');
      });
    }
  }

  flusTotalMoney() {
    for (var item in listOrderProducts) {
      setState(() {
        estimate += item['Price'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getInfo();
    flusTotalMoney();
    name = new TextEditingController(text: fullName.toString());
    phone = new TextEditingController(text: phoneNumber.toString());
  }

  var placeBloc = PlaceBloc();
  OrderBloc orderBloc = new OrderBloc();
  TextEditingController name;
  TextEditingController phone;
  bool isCheckedAddress = false;
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
              listOrderProducts.isEmpty
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
                                    onPressed: () async {
                                      setState(() {
                                        estimate = 0;
                                        feeShip = 0;
                                        address.clear();

                                        listOrderProducts = [];
                                        numberBloc.checkNumber();
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
            child: listOrderProducts.isEmpty
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
                                                  enableInteractiveSelection:
                                                      false,
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
                                                    isCheckedAddress = false;
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
                                            GetPlaceItem item;
                                            final result = Navigator.of(context,
                                                    rootNavigator: true)
                                                .pushNamed('/map');
                                            result.then((result) async {
                                              item = result;
                                              LoadingDialog.showLoadingDialog(
                                                  context,
                                                  allTranslations
                                                      .text("splash_screen")
                                                      .toString());
                                              int temp = await api.getFeeShip(
                                                  item.lat, item.lng);
                                              setState(() {
                                                feeShip = temp;

                                                address.text = item.address;
                                              });
                                              LoadingDialog.hideLoadingDialog(
                                                  context);
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
                        isCheckedAddress == false
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
                                              List<GetPlaceItem> places =
                                                  snapshot.data;
                                              return Container(
                                                  // width: double.infinity,
                                                  // height:
                                                  //     Dimension.getHeight(0.4),
                                                  child: ConstrainedBox(
                                                constraints: new BoxConstraints(
                                                  minHeight:
                                                      Dimension.getHeight(0.1),
                                                  minWidth: double.infinity,
                                                  maxHeight:
                                                      Dimension.getHeight(0.3),
                                                  maxWidth: double.infinity,
                                                ),
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
                                                          LoadingDialog
                                                              .showLoadingDialog(
                                                                  context,
                                                                  allTranslations
                                                                      .text(
                                                                          "splash_screen")
                                                                      .toString());
                                                          feeShip = 0;
                                                          int temp = await api
                                                              .getFeeShip(
                                                                  places
                                                                      .elementAt(
                                                                          index)
                                                                      .lat,
                                                                  places
                                                                      .elementAt(
                                                                          index)
                                                                      .lng);

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
                                                            feeShip = temp;
                                                            address.text =
                                                                places
                                                                    .elementAt(
                                                                        index)
                                                                    .address;
                                                            places.clear();
                                                            isCheckedAddress =
                                                                true;
                                                          });
                                                          LoadingDialog
                                                              .hideLoadingDialog(
                                                                  context);
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
                                              ));
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
                                      itemCount: listOrderProducts.length,
                                      itemBuilder: (context, index) {
                                        var listMultyTopping =
                                            listOrderProducts[index]['Toppings']
                                                as List<dynamic>;
                                        if (listMultyTopping != null) {
                                          multyTopping =
                                              listMultyTopping.length;
                                        }

                                        return Slidable(
                                          actionPane:
                                              SlidableDrawerActionPane(),
                                          actionExtentRatio: 0.25,
                                          child: GestureDetector(
                                            onTap: () {
                                              var product =
                                                  listOrderProducts[index];
                                              LoadingDialogOrder()
                                                  .showLoadingDialog(
                                                      index,
                                                      context,
                                                      product['Id'],
                                                      product['Name'],
                                                      product['Img'],
                                                      "",
                                                      product['Original_Price'],
                                                      product['Price'],
                                                      product['IsHot'],
                                                      product['HasHot'],
                                                      product['ListTopping'],
                                                      product['ListSize'],
                                                      product['Promotion'],
                                                      [],
                                                      product['Size'],
                                                      product['Toppings'],
                                                      product[
                                                          'SelectedPromotion'],
                                                      product[
                                                          'checkPromotionProduct'],
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
                                                                              domainAPI + listOrderProducts[index]['Img'],
                                                                          fit: BoxFit
                                                                              .fill,
                                                                          placeholder: (context, url) =>
                                                                              new SizedBox(
                                                                            child:
                                                                                Center(
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
                                                                                  listOrderProducts[index]['Name'],
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
                                                                      listOrderProducts[index]['Size'] ==
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
                                                                              child: Text("Size: " + listOrderProducts[index]['Size']['Name'].toString()),
                                                                            ),
                                                                      listOrderProducts[index]['Toppings'] ==
                                                                              null
                                                                          ? Container()
                                                                          : Padding(
                                                                              padding: const EdgeInsets.only(left: 50, top: 0, right: 0, bottom: 0),
                                                                              child: multyTopping > 1
                                                                                  ? Text(
                                                                                      "Topping: " + listOrderProducts[index]['Toppings'][0]['Name'] + "...",
                                                                                    )
                                                                                  : Text(
                                                                                      "Topping: " + listOrderProducts[index]['Toppings'][0]['Name'],
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
                                                                            listOrderProducts[index]['Quantity'].toString()),
                                                                        Padding(
                                                                          padding: const EdgeInsets.fromLTRB(
                                                                              170,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                          child:
                                                                              Text(
                                                                            listOrderProducts[index]['Price'].toString() +
                                                                                " VNĐ",
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
                                                                listOrderProducts[
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
                                                                  estimate -=
                                                                      listOrderProducts[
                                                                              index]
                                                                          [
                                                                          'Price'];
                                                                  listOrderProducts
                                                                      .removeAt(
                                                                          index);
                                                                  numberBloc
                                                                      .checkNumber();
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
                                  estimate.toString() + " VNĐ",
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
                                  feeShip.toString() + " VNĐ",
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
                                  (feeShip + estimate).toString() + " VNĐ",
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
            child: listOrderProducts.isEmpty
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
                                        (estimate + feeShip).toString() +
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
                                            builder: (_) => CouponDialog())
                                        .then((value) => setState(() {
                                              if (value != null) {
                                                estimate = 0;
                                                flusTotalMoney();
                                                build(context);
                                              }
                                            }));
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
                                    if ((await Validation
                                            .isConnectedNetwork() ==
                                        false)) {
                                      LoadingDialog.hideLoadingDialog(context);
                                      MsgDialog.showMsgDialog(
                                          context,
                                          allTranslations.text("Information"),
                                          allTranslations.text("no_network"));
                                    } else if ((await api
                                                .checkEnoughPoint(estimate)) ==
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
                                          builder: (_) => PaymentDialog(
                                              phone.text.trim().toString(),
                                              address.text.trim().toString(),
                                              estimate)).then(
                                          (value) => setState(() {
                                                if (value != null) {
                                                  listOrderProducts = [];
                                                  feeShip = 0;
                                                  address.clear();
                                                  numberBloc.checkNumber();
                                                } else {}
                                              }));
                                    } else {
                                      if (orderBloc.isValidInfo(
                                              name.text.trim().toString(),
                                              phone.text.trim().toString(),
                                              address.text.trim().toString()) ==
                                          true) {
                                        if (await api.postOrder(
                                                phone.text.trim().toString(),
                                                address.text.trim().toString(),
                                                false) ==
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
                                            estimate = 0;
                                            listOrderProducts = [];
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
    int total = listOrderProducts.fold(0, (t, e) => t + e['Price']);
    setState(() {
      build(context);
      estimate = total;
    });
  }
}
