import 'package:flutter/material.dart';
import 'package:thekingcoffee/app/styles/styles.dart';

class MsgDialog {
  static void showMsgDialog(BuildContext context, String title, String msg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(
              title,
              style: StylesText.style20BrownBold,
            ),
            content: Text(
              msg,
              style: StylesText.style13BrownNormal,
            ),
            actions: [
              new FlatButton(
                child: Text("OK", style: StylesText.style16Red300Bold),
                onPressed: () {
                  Navigator.of(context).pop(MsgDialog);
                },
              ),
            ],
          ),
    );
  }
}
