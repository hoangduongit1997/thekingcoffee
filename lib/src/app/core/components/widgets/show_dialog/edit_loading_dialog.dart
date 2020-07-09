import 'dart:core';
import 'package:flutter/material.dart';
import 'package:thekingcoffee/main.dart';
import 'package:thekingcoffee/src/app/core/components/lib/change_language/change_language.dart';
import 'package:thekingcoffee/src/app/core/components/widgets/home_cart/home_cart_coffee.dart';
import 'package:thekingcoffee/src/app/core/components/widgets/show_dialog/edit_order_dialog.dart';
import 'package:thekingcoffee/src/app/core/utils.dart';
import 'package:thekingcoffee/src/app/theme/styles.dart';

class LoadingDialogOrder {
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
      int originalPrice,
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
      List<dynamic> checkPromotionProduct,
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
                  child: OrderDialog(
                      this.setValueSelectedProduct,
                      id,
                      img,
                      name,
                      descript,
                      originalPrice,
                      price,
                      ishot,
                      hashot,
                      size,
                      topping,
                      promotion,
                      selectedSize,
                      selectedToppings,
                      selectedPromotion,
                      checkPromotionProduct,
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
                    listOrderProducts[index] = this.selectedProduct;
                    selectedProduct = {};
                    refreshListOrder();
                    numberBloc.checkNumber();
                    print(listOrderProducts.toString());
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
  }
}
