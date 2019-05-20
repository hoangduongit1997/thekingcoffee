import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:thekingcoffee/app/config/config.dart';

import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/core/components/ui/home_cart/home_cart_coffee.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:thekingcoffee/core/utils/utils.dart';

class Order_Dialog extends StatefulWidget {
  final int id;
  final String img;
  final String name;
  final String desc;
  final int price;
  final List<dynamic> toppings;
  final List<dynamic> size;
  Order_Dialog(this.id, this.img, this.name, this.desc, this.price, this.size,
      this.toppings);
  Order_DialogState createState() => Order_DialogState();
}

class Order_DialogState extends State<Order_Dialog> {
  var product = selectedProduct;
  int number = 1;
  int money;

  var selectedsize;
  var selecttopping = false;
  var lstSelectedTopping = [];
  int selectedRadioTile;

  List<Widget> createRadioListSize() {
    List<Widget> widgets = [];
    widgets.add(Text(
      "Size",
      style: StylesText.style16Brown,
    ));
    for (var item in widget.size) {
      widgets.add(Expanded(
        child: RadioListTile(
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
      widgets.add(Expanded(
          child: CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(
          topping['Name'].toString(),
          style: StylesText.style13Black,
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
            //tempMoney -= widget.price;
            tempMoney -= topping['Price'];
          } else {
            temp.add(topping);
            tempMoney += topping['Price'];
            //tempMoney += widget.price;
            //cong them tien
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
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(2, 0, 0, 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.all(2.0),
                                  child: Text(
                                    widget.name,
                                    style: StylesText.style20BrownBold,
                                    softWrap: true,
                                  ),
                                )
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
                      ))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Text(widget.desc,
                              style: StylesText.style13Blugray),
                        )
                      ],
                    ),
                  ),
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
                  widget.toppings == null || widget.toppings.length == 0
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: createCheckedBoxTopping()),
                              ),
                            ],
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                                          number--;
                                          money -= widget.price;
                                        });
                                        selectedProduct['Quantity'] = number;
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
