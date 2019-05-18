import 'dart:core';

import 'package:flutter/material.dart';
import 'package:thekingcoffee/core/components/ui/home_cart/home_cart.dart';
import 'package:thekingcoffee/core/components/ui/home_cart/home_cart.dart'
    as prefix0;
import 'package:thekingcoffee/core/components/ui/show_dialog/order_dialog.dart';
import 'package:thekingcoffee/core/utils/utils.dart';

class LoadingDialog_Order {
  static void showLoadingDialog(
      BuildContext context,
      int id,
      String name,
      String img,
      String descript,
      int price,
      List<dynamic> topping,
      List<dynamic> size,
      List<Object> orders) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              contentPadding: EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              content: Container(
                  height: Dimension.getHeight(0.5),
                  width: Dimension.getWidth(1.5),
                  child: Order_Dialog(
                      id, img, name, descript, price, size, topping)),
              actions: <Widget>[
                FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    var lst_index = ListOrderProducts.where((t) =>
                        t['Id'] == selectedProduct['Id'] &&
                        t['Size'] == selectedProduct['Size']).toList();
                    bool isAlready = false;
                    int position = -1;
                    if (lst_index != null && lst_index.length > 0) {
                      for (int index = 0; index < lst_index.length; index++) {
                        //tim vi tri trung
                        // if (index > -1) {
                        var temp = ListOrderProducts[index]['Toppings']
                            as List<dynamic>;
                        if (temp.length ==
                            (selectedProduct['Toppings'] as List<dynamic>)
                                .length) {
                          for (var item in selectedProduct['Toppings']) {
                            var element = temp.firstWhere(
                                (t) => t['Id'] == item['Id'],
                                orElse: () => null);
                            if (element != null) {
                              isAlready = true;
                              position = index;
                            } else {
                              // isAlready = false;
                              break;
                            }
                          }
                        }
                      }
                    }
                    if (isAlready && position > -1) {
                      ListOrderProducts[position]['Quantity']++;
                    } else {
                      ListOrderProducts.add(selectedProduct);
                    }
                    selectedProduct = {}; //reset sản phẩm chọn
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }
}
