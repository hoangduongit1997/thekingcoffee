import 'package:flutter/material.dart';

import 'package:thekingcoffee/app/styles/styles.dart';

import 'package:thekingcoffee/core/utils/utils.dart';

class Coupon_Dialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Coupon_Dialog_State();
  }
}

class Coupon_Dialog_State extends State<Coupon_Dialog> {
  TextEditingController counpon_code;
  @override
  void initState() {
    counpon_code = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      title: Text(
        'Coupon Code',
        style: StylesText.style18BrownBold,
      ),
      content: Container(
          height: Dimension.getHeight(0.15),
          width: Dimension.getWidth(0.8),
          child: Center(
              child: Container(
            width: Dimension.getWidth(0.65),
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Enter",
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.redAccent))),
            ),
          ))),
      actions: <Widget>[
        Container(
          width: Dimension.getWidth(0.762),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  child: Container(
                    width: Dimension.getWidth(0.28),
                    height: Dimension.getHeight(0.06),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
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
                FlatButton(
                  child: Container(
                    width: Dimension.getWidth(0.28),
                    height: Dimension.getHeight(0.06),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        color: Colors.redAccent),
                    child: Center(
                        child: Text(
                      "Apply",
                      style: StylesText.style14While,
                    )),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
