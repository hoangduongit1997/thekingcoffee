import 'package:flutter/material.dart';
import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/core/utils/utils.dart';

class MsgDialog {
  static void showMsgDialog(BuildContext context, String title, String msg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(

            contentPadding: const EdgeInsets.all(0.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            title: Text(
              title,
              style: StylesText.style20BrownBold,
            ),
            content: Container(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
              child: Text(
                msg,
                style: StylesText.style14BrownNormal,
              ),
            )),
            actions: [
              FlatButton(
                child: Container(
                  width: Dimension.getWidth(0.28),
                  height: Dimension.getHeight(0.04),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
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
            ],
          ),
    );
  }
}
