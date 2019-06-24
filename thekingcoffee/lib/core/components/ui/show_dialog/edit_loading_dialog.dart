import 'dart:core';

import 'package:flutter/material.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/app/screens/dashboard.dart';

import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/core/components/lib/change_language/change_language.dart';
import 'package:thekingcoffee/core/components/ui/home_cart/home_cart_coffee.dart';
import 'package:thekingcoffee/core/components/ui/home_cart/home_cart_coffee.dart'
    as prefix0;
import 'package:thekingcoffee/core/components/ui/show_dialog/edit_order_dialog.dart';
import 'package:thekingcoffee/core/utils/utils.dart';

class LoadingDialog_Order {
  Map<String, Object> selectedProduct = new Map();

  void setValueSelectedProduct(String key, Object value) {
    var map = {key: value};
    selectedProduct.addAll(map);
  }

  void showLoadingDialog(
      int index,
      BuildContext context,
      int id,
      String name,
      String img,
      String descript,
      int original_price,
      int price,
      bool ishot,
      int hashot,
      List<dynamic> topping,
      List<dynamic> size,
      List<dynamic> promotion,
      List<Object> orders,
      Map<String, dynamic> selectedSize,
      List<dynamic> selectedToppings,
      Map<String, dynamic> selectedPromotion,
      List<dynamic> check_promotion_product,
      String note,
      int quantity,
      Function() refreshListOrder) {
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
                  child: Order_Dialog(
                      this.setValueSelectedProduct,
                      id,
                      img,
                      name,
                      descript,
                      original_price,
                      price,
                      ishot,
                      hashot,
                      size,
                      topping,
                      promotion,
                      selectedSize,
                      selectedToppings,
                      selectedPromotion,
                      check_promotion_product,
                      note,
                      quantity)),
              actions: <Widget>[
                FlatButton(
                  child: Container(
                    width: Dimension.getWidth(0.32),
                    height: Dimension.getHeight(0.06),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        color: Colors.brown),
                    child: Center(
                        child: Text(
                      allTranslations.text("cancel").toString(),
                      style: StylesText.style14While,
                    )),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Container(
                    width: Dimension.getWidth(0.32),
                    height: Dimension.getHeight(0.06),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        color: Colors.redAccent),
                    child: Center(
                        child: Text(
                      allTranslations.text("Save_change").toString(),
                      style: StylesText.style14While,
                    )),
                  ),
                  onPressed: () {
                    ListOrderProducts[index] = this.selectedProduct;
                    selectedProduct = {};
                    refreshListOrder();
                    Config.item_shopping_list= ListOrderProducts.fold(0, (t, e) => t + e['Quantity']);
                    print(ListOrderProducts.toString());
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
  }
}
