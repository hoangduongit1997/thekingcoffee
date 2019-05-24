import 'dart:core';

import 'package:flutter/material.dart';
import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/core/components/ui/home_cart/home_cart_coffee.dart';
import 'package:thekingcoffee/core/components/ui/home_cart/home_cart_coffee.dart'
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
    int ishot,
    List<dynamic> topping,
    List<dynamic> size,
    List<dynamic> promotion,
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
                  height: Dimension.getHeight(0.55),
                  width: Dimension.getWidth(1.5),
                  child: Order_Dialog(
                      id, img, name, descript, price,ishot, size, topping,promotion)),
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
                            "Add to cart",
                            style: StylesText.style14While,
                          )),
                        ),
                        onPressed: () {
                          var lst_index;
                          if (selectedProduct['Size'] == null) {
                            lst_index = ListOrderProducts.where(
                                    (t) => t['Id'] == selectedProduct['Id'])
                                .toList();
                          } else {
                            lst_index = ListOrderProducts.where((t) =>
                                t['Id'] == selectedProduct['Id'] &&
                                t['Size']['Id'] ==
                                    selectedProduct['Size']['Id']).toList();
                          }

                          bool isAlready = false;
                          int position = -1;
                          if (selectedProduct['Toppings'] == null &&
                              ListOrderProducts.length > 0 &&
                              lst_index.length > 0) {
                            ListOrderProducts[
                                    ListOrderProducts.indexOf(lst_index.first)]
                                ['Quantity'] += selectedProduct['Quantity'];
                            selectedProduct = {}; //reset sản phẩm chọn
                            Navigator.of(context).pop();
                            return;
                          }
                          if (lst_index != null && lst_index.length > 0) {
                            for (int index = 0;
                                index < lst_index.length;
                                index++) {
                              //tim vi tri trung

                              var temp =
                                  lst_index[index]['Toppings'] as List<dynamic>;
                              if (temp != null &&
                                  temp.length ==
                                      (selectedProduct['Toppings']
                                              as List<dynamic>)
                                          .length) {
                                for (var item in selectedProduct['Toppings']) {
                                  var element = temp.firstWhere(
                                      (t) => t['Id'] == item['Id'],
                                      orElse: () => null);
                                  if (element != null) {
                                    isAlready = true;
                                    position = ListOrderProducts.indexOf(
                                        lst_index[index]);
                                    //position = index;
                                  } else {
                                    // isAlready = false;
                                    break;
                                  }
                                }
                              }
                            }
                          }
                          if (isAlready && position > -1) {
                            ListOrderProducts[position]['Quantity'] +=
                                selectedProduct['Quantity'];
                          } else {
                            ListOrderProducts.add(selectedProduct);
                          }
                          print(ListOrderProducts.toString());
                          selectedProduct = {}; //reset sản phẩm chọn
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                )
              ],
            ));
  }
}
