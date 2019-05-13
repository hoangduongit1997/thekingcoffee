import 'package:flutter/material.dart';
import 'package:thekingcoffee/app/styles/styles.dart';

class LoadingDialog {
  static void showLoadingDialog(BuildContext context, String msg) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => new Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              color: Color(0xffffffff),
              height: 100,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new CircularProgressIndicator(
                    valueColor:
                        new AlwaysStoppedAnimation<Color>(Colors.redAccent),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: new Text(
                      msg,
                      style: StylesText.style20Brown,
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  static hideLoadingDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop(LoadingDialog);
  }
}
