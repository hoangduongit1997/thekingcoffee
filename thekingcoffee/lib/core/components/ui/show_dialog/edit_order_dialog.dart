import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/app/screens/dashboard.dart';

import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/core/components/lib/change_language/change_language.dart';

import 'package:thekingcoffee/core/components/ui/show_dialog/show_message_dialog.dart';
import 'package:thekingcoffee/core/components/widgets/drawline.dart';
import 'package:thekingcoffee/core/utils/utils.dart';

class Order_Dialog extends StatefulWidget {
  Function(String, Object) callback;

  final int id;
  final String img;
  final String name;
  final String desc;
  final int original_price;
  final int price;
  final int ishot;
  final int hashot;
  final List<dynamic> toppings;
  final List<dynamic> size;
  final List<dynamic> promotion;
  final Map<String, dynamic> selectedSize;
  final List<dynamic> selectedToppings;
  final Map<String, dynamic> selectedPromotion;
  final List<dynamic> check_promotion_product;
  final String note_item;
  int quantity;
  Order_Dialog(
      this.callback,
      this.id,
      this.img,
      this.name,
      this.desc,
      this.original_price,
      this.price,
      this.ishot,
      this.hashot,
      this.size,
      this.toppings,
      this.promotion,
      this.selectedSize,
      this.selectedToppings,
      this.selectedPromotion,
      this.check_promotion_product,
      this.note_item,
      this.quantity);
  Order_DialogState createState() => Order_DialogState();
}

class Order_DialogState extends State<Order_Dialog> {
  TextEditingController note = new TextEditingController();

  int number;
  double origin_price;
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
            // selectedProduct['Price'] = money;
            widget.callback('Price', money);
            selectedsize = value;
            // selectedProduct['Size'] = selectedsize;
            widget.callback('Size', selectedsize);
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
          // selectedProduct['Toppings'] = lstSelectedTopping;
          // selectedProduct['Price'] = money;
          widget.callback('Toppings', lstSelectedTopping);
          widget.callback('Price', money);
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

            // selectedProduct['Price'] = money;
            // selectedProduct['SelectedPromotion'] = selectedPromotion;
            widget.callback('Price', money);
            widget.callback('SelectedPromotion', selectedPromotion);
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
                                        allTranslations
                                            .text("Price")
                                            .toString(),
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
                                        allTranslations.text("Sell").toString(),
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
          // selectedProduct['check_promotion_product'] = check_promotion_product;
          // selectedProduct['Price'] = money;
          // selectedProduct['selectedDetailedSaleForProduct'] =
          //     check_promotion_product;

          widget.callback('check_promotion_product', check_promotion_product);
          widget.callback('Price', money);
          widget.callback(
              'selectedDetailedSaleForProduct', check_promotion_product);
        },
        activeColor: Colors.redAccent,
      )));
    }
    return widgets_promotion_product;
  }

  @override
  void initState() {
    super.initState();
    note.text = widget.note_item.trim();
    number = widget.quantity;
    money = widget.price;
    if (widget.size.length > 0) {
      money += widget.size[0]['PlusMonney'];
    }
    origin_price = widget.price / widget.quantity;
    // if (widget.size != null && widget.size.length > 0) {
    //   selectedsize = widget.size[0];
    // }
    if (widget.selectedSize != null) {
      selectedsize = widget.selectedSize;
    }
    if (widget.selectedToppings != null) {
      lstSelectedTopping = widget.selectedToppings;
    }
    if (widget.selectedPromotion != null) {
      selectedPromotion = widget.selectedPromotion;
      list_promotion_product = selectedPromotion['SaleForProducts'];
    }
    if (widget.check_promotion_product != null) {
      check_promotion_product = widget.check_promotion_product;
    }

    // selectedProduct['Price'] = money;
    widget.callback('Price', money);
    // selectedProduct['Id'] = widget.id;
    widget.callback('Id', widget.id);
    // selectedProduct['Img'] = widget.img;
    widget.callback('Img', widget.img);
    // selectedProduct['Name'] = widget.name;
    widget.callback('Name', widget.name);
    // selectedProduct['Size'] = selectedsize;
    widget.callback('Size', selectedsize);
    // selectedProduct['Quantity'] = number;
    widget.callback('Quantity', number);

    // //lay de list cart
    // selectedProduct['ListSize'] = widget.size;
    widget.callback('ListSize', widget.size);

    // selectedProduct['ListTopping'] = widget.toppings;
    widget.callback('ListTopping', widget.toppings);

    // selectedProduct['IsHot'] = false;
    widget.callback('IsHot', false);

    // selectedProduct['HasHot'] = widget.hashot;
    widget.callback('HasHot', widget.hashot);

    // selectedProduct['Original_Price'] = widget.price;
    widget.callback('Original_Price', widget.price);

    // selectedProduct['Note'] = "";
    widget.callback('Note', "");
    // selectedProduct['Promotion']=widget.promotion;
    widget.callback('Promotion', widget.promotion);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Container(
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
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Container(
                                        height: Dimension.getHeight(0.15),
                                        width: Dimension.getWidth(0.3),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
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
                                  padding:
                                      const EdgeInsets.fromLTRB(2, 0, 0, 15),
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
                                  padding:
                                      const EdgeInsets.fromLTRB(2, 20, 0, 0),
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
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 0, 0, 0),
                                        child: Text(
                                            widget.original_price.toString(),
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
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Container(
                              child: CustomPaint(
                                  painter: Drawhorizontalline(false, 180.0,
                                      220.0, Colors.blueGrey, 0.5)),
                            )),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                allTranslations.text("Note").toString(),
                                style: StylesText.style16Brown,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                child: Container(
                                  width: Dimension.getWidth(0.6),
                                  child: TextField(
                                    textInputAction: TextInputAction.done,
                                    controller: note,
                                    onEditingComplete: () {
                                      if (note.text.toString().length > 0) {
                                        widget.callback('Note', note.text);
                                        MsgDialog.showMsgDialog(
                                            context,
                                            allTranslations
                                                .text("Information")
                                                .toString(),
                                            allTranslations
                                                .text("edit_note")
                                                .toString());
                                      } else {
                                        MsgDialog.showMsgDialog(
                                            context,
                                            allTranslations
                                                .text("Information")
                                                .toString(),
                                            allTranslations
                                                .text("note_empty")
                                                .toString());
                                      }
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
                                      painter: Drawhorizontalline(false, 180.0,
                                          220.0, Colors.blueGrey, 0.5)),
                                )),
                        widget.size == null || widget.size.length == 0
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: createRadioListSize(),
                                    )
                                  ],
                                )),
                        widget.ishot == 1
                            ? Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Container(
                                  child: CustomPaint(
                                      painter: Drawhorizontalline(false, 180.0,
                                          220.0, Colors.blueGrey, 0.5)),
                                ))
                            : Container(),
                        widget.ishot == 1
                            ? Container(
                                width: Dimension.getWidth(1.0),
                                child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                            allTranslations
                                                .text("Kind")
                                                .toString(),
                                            style: StylesText.style16Brown),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 0, 0, 0),
                                          child: Container(
                                            width: Dimension.getWidth(0.5),
                                            child: CheckboxListTile(
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                              title: Text(
                                                allTranslations
                                                    .text("Hot")
                                                    .toString(),
                                                style: StylesText.style16Brown,
                                              ),
                                              value: checked_hot,
                                              onChanged: (bool value) {
                                                setState(() {
                                                  checked_hot = value;
                                                  // selectedProduct['IsHot'] =
                                                  //     checked_hot;
                                                  widget.callback(
                                                      'IsHot', checked_hot);
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
                                      painter: Drawhorizontalline(false, 180.0,
                                          220.0, Colors.blueGrey, 0.5)),
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
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 0),
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
                                      painter: Drawhorizontalline(false, 180.0,
                                          220.0, Colors.blueGrey, 0.5)),
                                )),
                        widget.promotion == null || widget.promotion.length == 0
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          allTranslations
                                              .text("discount_order")
                                              .toString(),
                                          style: StylesText.style16Brown,
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 0),
                                      child: Container(
                                        width: Dimension.getWidth(1.0),
                                        child: Center(
                                          child: Column(
                                            children:
                                                createRadioListPromotion(),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          allTranslations
                                              .text("Promotion_Products")
                                              .toString(),
                                          style: StylesText.style16Brown,
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 0),
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
                                  painter: Drawhorizontalline(false, 180.0,
                                      220.0, Colors.blueGrey, 0.5)),
                            )),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Text(
                                  allTranslations.text("Money").toString(),
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
                                    padding:
                                        const EdgeInsets.fromLTRB(30, 0, 0, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                          padding: const EdgeInsets.fromLTRB(
                                              180, 0, 0, 0),
                                          child: IconButton(
                                            icon: Icon(Icons.arrow_back_ios,
                                                color: Colors.brown),
                                            onPressed: () {
                                              setState(() {
                                                if (number == 1) {
                                                  
                                                  return;
                                                }
                                                number--;
                                                Config.item_shopping_list = number;
                                                money = origin_price.toInt() *
                                                    number;
                                              });

                                              widget.callback(
                                                  'Quantity', number);
                                              widget.callback('Price', money);
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              5, 0, 0, 0),
                                          child: Text(
                                            number.toString(),
                                            style: StylesText.style16Brown,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              5, 0, 0, 0),
                                          child: IconButton(
                                            icon: Icon(Icons.arrow_forward_ios,
                                                color: Colors.brown),
                                            onPressed: () {
                                              setState(() {
                                                number++;
                                                Config.item_shopping_list = number;
                                                money = origin_price.toInt() *
                                                    number;
                                              });

                                              widget.callback(
                                                  'Quantity', number);
                                              widget.callback('Price', money);
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
            )));
  }
}
