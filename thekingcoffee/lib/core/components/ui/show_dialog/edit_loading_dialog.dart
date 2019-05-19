import 'dart:core';

import 'package:flutter/material.dart';
import 'package:thekingcoffee/core/components/ui/home_cart/home_cart_coffee.dart';
import 'package:thekingcoffee/core/components/ui/home_cart/home_cart_coffee.dart'
    as prefix0;
import 'package:thekingcoffee/core/components/ui/show_dialog/edit_order_dialog.dart';
import 'package:thekingcoffee/core/components/ui/show_dialog/order_dialog.dart';
import 'package:thekingcoffee/core/utils/utils.dart';

class Edit_LoadingDialog_Order {
  bool isEdit = false;
  static void showLoadingDialog(
    BuildContext context,
    int id,
    String name,
    String img,
    String descript,
    int price,
    List<dynamic> topping,
    var selectedTopping,
    List<dynamic> size,
    var selectedSize,
    int estimatePrice,
    int quantity,
    List<Object> orders,
  ) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              contentPadding: EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              content: Container(
                  height: Dimension.getHeight(0.5),
                  width: Dimension.getWidth(1.5),
                  child: Edit_Order_Dialog(id,img,name,descript,price,topping,selectedTopping,size,selectedSize,estimatePrice,quantity)),
              actions: <Widget>[
                FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    print(ListOrderProducts.toString());
                    selectedProduct = {}; //reset sản phẩm chọn
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }
}
