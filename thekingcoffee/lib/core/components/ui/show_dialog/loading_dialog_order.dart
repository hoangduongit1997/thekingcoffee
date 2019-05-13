import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/core/components/ui/show_dialog/order_dialog.dart';

import 'package:thekingcoffee/core/utils/utils.dart';

class LoadingDialog_Order {
  static void showLoadingDialog(BuildContext context, String name, String img,
      String descript, String price,String topping, String size) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          contentPadding:EdgeInsets.all(5.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              content: Container(
                  height: Dimension.getHeight(0.5),
                  width: Dimension.getWidth(1.0),
                  child: Order_Dialog(img,name,descript,price,size,topping)),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }
}
