import 'dart:core';

import 'package:flutter/material.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/app/screens/login.dart';
import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/core/components/ui/home_cart/home_cart_coffee.dart';
import 'package:thekingcoffee/core/components/ui/home_cart/home_cart_coffee.dart'
    as prefix0;
import 'package:thekingcoffee/core/components/ui/show_dialog/edit_order_dialog2019.dart';
import 'package:thekingcoffee/core/utils/utils.dart';

class LoadingDialog_Order {
  Map<String,Object> selectedProduct=new Map();

    void setValueSelectedProduct(String key, Object value){
    var map={key:value};
    selectedProduct.addAll(map);
  }

  void showLoadingDialog(
    int index,
    BuildContext context,
    int id,
    String name,
    String img,
    String descript,
    int price,
    int ishot,
    int hashot,
    List<dynamic> topping,
    List<dynamic> size,
    List<dynamic> promotion,
    List<Object> orders,
    Map<String,dynamic> selectedSize,
    List<dynamic> selectedToppings,
    Map<String,dynamic> selectedPromotion,
    List<dynamic> check_promotion_product
  ) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              contentPadding: EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              content: Container(
                  height: Dimension.getHeight(0.55),
                  width: Dimension.getWidth(1.5),
                  child: Order_Dialog2019(this.setValueSelectedProduct,id, img, name, descript, price, ishot,
                      hashot, size, topping, promotion,selectedSize,selectedToppings,selectedPromotion,check_promotion_product)),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: FlatButton(
                        child: Container(
                          width: Dimension.getWidth(0.32),
                          height: Dimension.getHeight(0.06),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              color: Colors.brown),
                          child: Center(
                              child: Text(
                            "Cancel",
                            style: StylesText.style14While,
                          )),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: FlatButton(
                        child: Container(
                          width: Dimension.getWidth(0.32),
                          height: Dimension.getHeight(0.06),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              color: Colors.redAccent),
                          child: Center(
                              child: Text(
                            "Save change",
                            style: StylesText.style14While,
                          )),
                        ),
                        onPressed: () {
                          if (Config.islogin == 0) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0))),
                                    title: new Text("Confirm",
                                        style: StylesText.style18RedaccentBold),
                                    content: new Text(
                                      "You need to login to continute !",
                                      style: StylesText.style15Black,
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("Cancel"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      FlatButton(
                                        child: Text("OK"),
                                        onPressed: () {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginWithPass()));
                                        },
                                      ),
                                    ],
                                  );
                                });
                          } else {
                            ListOrderProducts[index]=this.selectedProduct;
                            selectedProduct = {}; //reset sản phẩm chọn
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                    ),
                  ],
                )
              ],
            ));
  }
}
