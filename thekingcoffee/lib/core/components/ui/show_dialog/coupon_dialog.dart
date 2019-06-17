import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thekingcoffee/app/bloc/coupon_bloc.dart';
import 'package:thekingcoffee/app/data/repository/check_coupon.dart';
import 'package:thekingcoffee/app/screens/shopping_list.dart';

import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/core/components/lib/change_language/change_language.dart';

import 'package:thekingcoffee/core/utils/utils.dart';

class Coupon_Dialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Coupon_Dialog_State();
  }
}

class Coupon_Dialog_State extends State<Coupon_Dialog> {
  TextEditingController counpon_code;
  Coupon_Bloc coupon_bloc;
  @override
  void initState() {
    coupon_bloc = new Coupon_Bloc();
    counpon_code = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    coupon_bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      title: Text(
        allTranslations.text("Coupon_code").toString(),
        style: StylesText.style18BrownBold,
      ),
      content: Container(
          height: Dimension.getHeight(0.15),
          width: Dimension.getWidth(0.8),
          child: Center(
              child: Container(
            width: Dimension.getWidth(0.65),
            child: StreamBuilder<Object>(
                stream: coupon_bloc.coupon_stream,
                builder: (context, snapshot) {
                  return TextField(
                    controller: counpon_code,
                    decoration: InputDecoration(
                        errorText: snapshot.hasError ? snapshot.error : null,
                        hintText:
                            allTranslations.text("enter_coupon").toString(),
                        border: new OutlineInputBorder(
                            borderSide:
                                new BorderSide(color: Colors.redAccent))),
                  );
                }),
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
                      allTranslations.text("cancel").toString(),
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
                      allTranslations.text("Apply").toString(),
                      style: StylesText.style14While,
                    )),
                  ),
                  onPressed: onApplyCode,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Future onApplyCode() async {
    if (coupon_bloc.isValidInfo(counpon_code.text.toString().trim())) {
      if (await Check_Coupon(counpon_code.text.toString().trim()) == 1) {
        print("dung roi");

        Navigator.of(context).pop(true);
      } else {
        Fluttertoast.showToast(
            msg: allTranslations.text("error").toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
            fontSize: 16.0);
        print("loi roi");
        Navigator.of(context).pop();
      }
    }
  }
}
