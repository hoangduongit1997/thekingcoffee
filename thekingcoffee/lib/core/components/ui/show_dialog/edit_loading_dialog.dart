import 'package:flutter/material.dart';
import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/core/components/ui/show_dialog/edit_order_dialog.dart';
import 'package:thekingcoffee/core/utils/utils.dart';

class Edit_Loading_Order_Dialog {
  static void showEditDialog(
    BuildContext context,
    int id,
    String img,
    String name,
    int final_price,
    int origin_price,
    bool ishot,
    int hashot,
    final String note,
    final List<dynamic> size,
    final List<dynamic> toppings,
    List<dynamic> promotion,
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
                  child: Edit_Order_Dialog(
                      id,
                      img,
                      name,
                      final_price,
                      origin_price,
                      ishot,
                      hashot,
                      note,
                      size,
                      toppings,
                      promotion)),
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
                            "OK",
                            style: StylesText.style14While,
                          )),
                        ),
                        onPressed: () {
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
