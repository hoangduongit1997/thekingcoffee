import 'package:flutter/material.dart';
import 'package:thekingcoffee/app/styles/styles.dart';

import 'package:thekingcoffee/core/components/ui/show_dialog/order_dialog.dart';

import 'package:thekingcoffee/core/utils/utils.dart';

class LoadingDialog_Order {
  static void showLoadingDialog(BuildContext context, String name, String img,
      String descript, String price, String topping, String size) {
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
                  child:
                      Order_Dialog(img, name, descript, price, size, topping)),
              actions: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 0, left: 0, bottom: 0, right: 73),
                      child: Container(
                        height: Dimension.getHeight(0.055),
                        width: Dimension.getWidth(0.4),
                        decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        child: FlatButton(
                          child: Text(
                            'Add to cart',
                            style: StylesText.style14While,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ));
  }
}
