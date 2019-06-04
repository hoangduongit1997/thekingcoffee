import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:thekingcoffee/app/config/config.dart';

import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/core/components/ui/home_cart/home_cart_coffee.dart';
import 'package:thekingcoffee/core/components/ui/home_cart/home_cart_coffee.dart'
    as prefix0;
import 'package:thekingcoffee/core/components/ui/show_dialog/loading_dialog.dart';
import 'package:thekingcoffee/core/components/ui/show_dialog/show_message_dialog.dart';
import 'package:thekingcoffee/core/components/widgets/drawline.dart';
import 'package:thekingcoffee/core/utils/utils.dart';

class Order_Dialog extends StatefulWidget {
  final int id;
  final String img;
  final String name;
  final String desc;
  final int price;
  final int ishot;
  final int hashot;
  final List<dynamic> toppings;
  final List<dynamic> size;
  final List<dynamic> promotion;
  Order_Dialog(this.id, this.img, this.name, this.desc, this.price, this.ishot,
      this.hashot, this.size, this.toppings, this.promotion);
  Order_DialogState createState() => Order_DialogState();
}

class Order_DialogState extends State<Order_Dialog> {
  TextEditingController note = new TextEditingController();
  var product = selectedProduct;
  int number = 1;
  int money;
  bool checked_hot = false;
  var selectedsize;
  var selecttopping = false;
  var lstSelectedTopping = [];
  int selectedRadioTile;
  var selectedPromotion;
  var list_promotion_product = [];

  int final_price_promotion_product = 0;

  var check_promotion_product = [];

  List<Widget> createRadioListSize() {
    List<Widget> widgets = [];
    widgets.add(Text(
      "Size",
      style: StylesText.style16Brown,
    ));
    for (var item in widget.size) {
      widgets.add(Expanded(
        child: RadioListTile(
          dense: true,
          value: item,
          groupValue: selectedsize,
          title: Text(
            item['Name'],
            style: StylesText.style13BrownBold,
          ),
          onChanged: (value) {
            money -= selectedsize['PlusMonney'];
            setState(() {
              money += value['PlusMonney'];
            });
            selectedProduct['Price'] = money;
            selectedsize = value;
            selectedProduct['Size'] = selectedsize;
          },
          selected: selectedsize == item,
          activeColor: Colors.redAccent,
        ),
      ));
    }
    return widgets;
  }

  List<Widget> createCheckedBoxTopping() {
    List<Widget> widgets = [];
    for (var topping in widget.toppings) {
      widgets.add(Container(
          child: CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(
          topping['Name'].toString(),
          style: StylesText.style13BrownBold,
        ),
        value: lstSelectedTopping.firstWhere((t) => t['Id'] == topping['Id'],
                orElse: () => null) !=
            null,
        onChanged: (bool value) {
          var element = lstSelectedTopping
              .firstWhere((t) => t['Id'] == topping['Id'], orElse: () => null);
          var temp = lstSelectedTopping;
          int tempMoney = money;
          if (element != null) {
            temp.remove(element);

            tempMoney -= topping['Price'];
          } else {
            temp.add(topping);
            tempMoney += topping['Price'];
          }
          setState(() {
            money = tempMoney;
            lstSelectedTopping = temp;
          });
          selectedProduct['Toppings'] = lstSelectedTopping;
          selectedProduct['Price'] = money;
        },
        selected: selecttopping == topping,
        activeColor: Colors.redAccent,
      )));
    }
    return widgets;
  }

  List<Widget> createRadioListPromotion() {
    List<Widget> widgets_promotion = [];
    for (var promotion in widget.promotion) {
      widgets_promotion.add(Container(
        child: RadioListTile(
          dense: true,
          value: promotion,
          groupValue: selectedPromotion,
          title: Text(
            promotion['Sale']['Description'],
            style: StylesText.style13BrownBold,
          ),
          onChanged: (value) {
            list_promotion_product = [];
            list_promotion_product = promotion['SaleForProducts'];
            int oldMoney = 0, newMoney = 0;
            if (selectedPromotion != null) {
              oldMoney = ((widget.price -
                      (widget.price *
                          (selectedPromotion['PercentDiscount']) /
                          100) -
                      selectedPromotion['MoneyDiscount']))
                  .toInt();
            }

            newMoney = ((widget.price -
                    (widget.price * (value['PercentDiscount']) / 100) -
                    value['MoneyDiscount']))
                .toInt();
            setState(() {
              selectedPromotion = value;
              money = money + oldMoney - newMoney;
            });

            selectedsize = value;

            selectedProduct['Price'] = money;
            selectedProduct['SelectedPromotion'] = selectedPromotion;
          },
          selected: selectedPromotion == promotion,
          activeColor: Colors.redAccent,
        ),
      ));
    }
    return widgets_promotion;
  }

  List<Widget> createCheckBoxListPromotionProDuct() {
    List<Widget> widgets_promotion_product = [];
    for (var promotion_product in list_promotion_product) {
      final_price_promotion_product =
          promotion_product['DetailedSaleForProduct']['Price'] -
              promotion_product['MoneyDiscount'] -
              promotion_product['PriceDiscount'];
      widgets_promotion_product.add(Container(
          child: CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
          child: Container(
            width: Dimension.getWidth(1.0),
            height: Dimension.getHeight(0.115),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: CachedNetworkImage(
                          imageUrl: Config.ip +
                              promotion_product['DetailedSaleForProduct']
                                  ['File_Path'],
                          fit: BoxFit.cover,
                          height: Dimension.getHeight(0.1),
                          width: Dimension.getWidth(0.18),
                          placeholder: (context, url) => new SizedBox(
                                child: Center(
                                    child: CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Colors.redAccent),
                                )),
                              )),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        width: Dimension.getWidth(0.35),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                          child: Text(
                              promotion_product['DetailedSaleForProduct']
                                  ['Name'],
                              style: StylesText.style13BrownBold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 10, 0, 0),
                      child: Container(
                          width: Dimension.getWidth(0.35),
                          child: promotion_product['DetailedSaleForProduct']
                                      ['Price'] ==
                                  null
                              ? Container()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(2, 0, 0, 0),
                                      child: Text(
                                        "Price",
                                        style: StylesText.style13BrownNormal,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                      child: Text(
                                        promotion_product[
                                                    'DetailedSaleForProduct']
                                                ['Price']
                                            .toString(),
                                        style: StylesText
                                            .style13BrownNormalUnderline,
                                      ),
                                    ),
                                  ],
                                )),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 10, 0, 0),
                      child: Container(
                          width: Dimension.getWidth(0.35),
                          child: promotion_product['DetailedSaleForProduct']
                                      ['Price'] ==
                                  null
                              ? Container()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(2, 0, 0, 0),
                                      child: Text(
                                        "Sell",
                                        style: StylesText.style13BrownBold,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                      child: Text(
                                        final_price_promotion_product
                                            .toString(),
                                        style: StylesText.style13BrownBold,
                                      ),
                                    ),
                                  ],
                                )),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        value: check_promotion_product.firstWhere((t) => t == promotion_product,
                orElse: () => null) !=
            null,
        onChanged: (value) {
          var lstVal = [];
          int tempMoney = money;

          if (value) {
            lstVal.add(promotion_product);
            //tang tien
            tempMoney += final_price_promotion_product;
          } else {
            var temp = check_promotion_product
                .firstWhere((t) => t == promotion_product, orElse: () => null);
            lstVal.remove(temp);
            //tru bot tien
            tempMoney -= final_price_promotion_product;
          }
          setState(() {
            check_promotion_product = lstVal;
            money = tempMoney;
          });
          selectedProduct['check_promotion_product'] = check_promotion_product;
          selectedProduct['Price'] = money;
          selectedProduct['selectedDetailedSaleForProduct'] =
              check_promotion_product;
        },
        activeColor: Colors.redAccent,
      )));
    }
    return widgets_promotion_product;
  }

  @override
  void initState() {
    super.initState();
    money = widget.price;
    if (widget.size.length > 0) {
      money += widget.size[0]['PlusMonney'];
    }
    if (widget.size != null && widget.size.length > 0) {
      selectedsize = widget.size[0];
    }
    selectedProduct['Price'] = money;
    selectedProduct['Id'] = widget.id;
    selectedProduct['Img'] = widget.img;
    selectedProduct['Name'] = widget.name;
    selectedProduct['Size'] = selectedsize;
    selectedProduct['Quantity'] = number;
    //lay de list cart
    selectedProduct['ListSize'] = widget.size;
    selectedProduct['ListTopping'] = widget.toppings;
    selectedProduct['IsHot'] = false;
    selectedProduct['HasHot'] = widget.hashot;
    selectedProduct['Original_Price'] = widget.price;
    selectedProduct['Note'] = "";
    selectedProduct['Promotion'] = widget.promotion;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.redAccent),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Container(
                                  height: Dimension.getHeight(0.15),
                                  width: Dimension.getWidth(0.3),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: CachedNetworkImage(
                                        imageUrl: Config.ip + widget.img,
                                        fit: BoxFit.cover,
                                        height: Dimension.getHeight(0.3),
                                        width: Dimension.getWidth(0.5),
                                        placeholder: (context, url) =>
                                            new SizedBox(
                                              child: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                valueColor:
                                                    new AlwaysStoppedAnimation<
                                                            Color>(
                                                        Colors.redAccent),
                                              )),
                                            )),
                                  )))
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(2, 0, 0, 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: Dimension.getWidth(0.45),
                                  child: Text(
                                    widget.name,
                                    style: StylesText.style20BrownBold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(2, 20, 0, 0),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.redAccent,
                                    radius: 12.0,
                                    child: Icon(
                                      Icons.monetization_on,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                  child: Text(widget.price.toString(),
                                      style: StylesText.style16BrownBold),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Container(
                        child: CustomPaint(
                            painter: Drawhorizontalline(
                                false, 180.0, 220.0, Colors.blueGrey, 0.5)),
                      )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child:
                              Text(widget.desc, style: StylesText.style13Black),
                        )
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Container(
                        child: CustomPaint(
                            painter: Drawhorizontalline(
                                false, 180.0, 220.0, Colors.blueGrey, 0.5)),
                      )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Note",
                          style: StylesText.style16Brown,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Container(
                            width: Dimension.getWidth(0.62),
                            child: TextField(
                              textInputAction: TextInputAction.done,
                              controller: note,
                              onEditingComplete: () {
                                selectedProduct['Note'] = note.text;
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0))),
                                        title: new Text("Information",
                                            style: StylesText
                                                .style18RedaccentBold),
                                        content: new Text(
                                          "Add note successfull!",
                                          style: StylesText.style15Black,
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text("OK"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              },
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  widget.size == null || widget.size.length == 0
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Container(
                            child: CustomPaint(
                                painter: Drawhorizontalline(
                                    false, 180.0, 220.0, Colors.blueGrey, 0.5)),
                          )),
                  widget.size == null || widget.size.length == 0
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: createRadioListSize(),
                              )
                            ],
                          )),
                  widget.ishot == 1
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Container(
                            child: CustomPaint(
                                painter: Drawhorizontalline(
                                    false, 180.0, 220.0, Colors.blueGrey, 0.5)),
                          ))
                      : Container(),
                  widget.ishot == 1
                      ? Container(
                          width: Dimension.getWidth(1.0),
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text("Kind", style: StylesText.style16Brown),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                    child: Container(
                                      width: Dimension.getWidth(0.5),
                                      child: CheckboxListTile(
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        title: Text("Hot"),
                                        value: checked_hot,
                                        onChanged: (bool value) {
                                          setState(() {
                                            checked_hot = value;
                                            selectedProduct['IsHot'] =
                                                checked_hot;
                                          });
                                        },
                                        activeColor: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              )))
                      : Container(),
                  widget.toppings == null || widget.toppings.length == 0
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Container(
                            child: CustomPaint(
                                painter: Drawhorizontalline(
                                    false, 180.0, 220.0, Colors.blueGrey, 0.5)),
                          )),
                  widget.toppings == null || widget.toppings.length == 0
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    "Topping",
                                    style: StylesText.style16Brown,
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Container(
                                  width: Dimension.getWidth(1.0),
                                  child: Center(
                                    child: Column(
                                      children: createCheckedBoxTopping(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                  widget.promotion == null || widget.promotion.length == 0
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Container(
                            child: CustomPaint(
                                painter: Drawhorizontalline(
                                    false, 180.0, 220.0, Colors.blueGrey, 0.5)),
                          )),
                  widget.promotion == null || widget.promotion.length == 0
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Discount",
                                    style: StylesText.style16Brown,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Container(
                                  width: Dimension.getWidth(1.0),
                                  child: Center(
                                    child: Column(
                                      children: createRadioListPromotion(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                  list_promotion_product == null ||
                          list_promotion_product.length == 0
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Promotion Products",
                                    style: StylesText.style16Brown,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Container(
                                  width: Dimension.getWidth(1.0),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children:
                                          createCheckBoxListPromotionProDuct(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Container(
                        child: CustomPaint(
                            painter: Drawhorizontalline(
                                false, 180.0, 220.0, Colors.blueGrey, 0.5)),
                      )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Text(
                            "Money",
                            style: StylesText.style16Brown,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Stack(
                          alignment: AlignmentDirectional.centerStart,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    money.toString(),
                                    style: StylesText.style20BrownBold,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(190, 0, 0, 0),
                                    child: IconButton(
                                      icon: Icon(Icons.arrow_back_ios,
                                          color: Colors.brown),
                                      onPressed: () {
                                        setState(() {
                                          if (number == 1) {
                                            return;
                                          }
                                          number--;
                                          money -= widget.price;
                                        });
                                        selectedProduct['Quantity'] = number;
                                        selectedProduct['Price'] = money;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                    child: Text(number.toString()),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                    child: IconButton(
                                      icon: Icon(Icons.arrow_forward_ios,
                                          color: Colors.brown),
                                      onPressed: () {
                                        setState(() {
                                          number++;
                                          money += widget.price;
                                        });
                                        selectedProduct['Quantity'] = number;
                                        selectedProduct['Price'] = money;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
