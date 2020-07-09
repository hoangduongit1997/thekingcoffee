import 'package:flutter/material.dart';
import 'package:thekingcoffee/src/app/core/components/lib/change_language/change_language.dart';
import 'package:thekingcoffee/src/app/core/components/widgets/show_dialog/show_message_dialog.dart';
import 'package:thekingcoffee/src/app/core/config.dart';
import 'package:thekingcoffee/src/app/core/utils.dart';
import 'package:thekingcoffee/src/app/streams/order_bloc.dart';
import 'package:thekingcoffee/src/app/theme/styles.dart';
import 'loading_dialog.dart';

class PaymentDialog extends StatefulWidget {
  final String phone;
  final String address;
  final int estiamte;
  PaymentDialog(this.phone, this.address, this.estiamte);
  @override
  State<StatefulWidget> createState() {
    return PaymentDialogState();
  }
}

enum SingingCharacter { Change_Points, Cast }

class PaymentDialogState extends State<PaymentDialog> {
  OrderBloc orderBloc = new OrderBloc();
  SingingCharacter _character = SingingCharacter.Change_Points;
  @override
  void dispose() {
    orderBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      title: Text(
        allTranslations.text("Payment_method").toString(),
        style: StylesText.style18BrownBold,
      ),
      content: Container(
          height: Dimension.getHeight(0.2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RadioListTile<SingingCharacter>(
                subtitle: Text(
                  allTranslations.text("Pay_with_your_points").toString(),
                  style: StylesText.style11BrownNormal,
                ),
                activeColor: Colors.redAccent,
                title: Text(
                  allTranslations.text("Change_Points").toString(),
                  style: StylesText.style15Black,
                ),
                value: SingingCharacter.Change_Points,
                groupValue: _character,
                onChanged: (SingingCharacter value) {
                  this.setState(() {
                    print(value.toString());
                    _character = value;
                  });
                },
              ),
              RadioListTile<SingingCharacter>(
                activeColor: Colors.redAccent,
                subtitle: Text(
                  allTranslations.text("Pay_with_money").toString(),
                  style: StylesText.style11BrownNormal,
                ),
                title: Text(
                  allTranslations.text("Cash").toString(),
                  style: StylesText.style15Black,
                ),
                value: SingingCharacter.Cast,
                groupValue: _character,
                onChanged: (SingingCharacter value) {
                  this.setState(() {
                    print(value.toString());
                    _character = value;
                  });
                },
              ),
            ],
          )),
      actions: <Widget>[
        FlatButton(
          child: Container(
            width: Dimension.getWidth(0.28),
            height: Dimension.getHeight(0.04),
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
          onPressed: () async {
            if (_character == SingingCharacter.Cast) {
              LoadingDialog.showLoadingDialog(
                  context, allTranslations.text("splash_screen").toString());
              if (await api.postOrder(widget.phone, widget.address, false) ==
                  true) {
                LoadingDialog.hideLoadingDialog(context);
                Navigator.of(context).pop(true);
                MsgDialog.showMsgDialog(
                    context,
                    allTranslations.text("Information").toString(),
                    allTranslations.text("order_suc").toString());
              } else {
                LoadingDialog.hideLoadingDialog(context);
                MsgDialog.showMsgDialog(
                    context,
                    allTranslations.text("Information").toString(),
                    allTranslations.text("error").toString());
              }
            } else if (_character == SingingCharacter.Change_Points) {
              LoadingDialog.showLoadingDialog(
                  context, allTranslations.text("splash_screen").toString());
              if (await api.postOrder(widget.phone, widget.address, true) ==
                  true) {
                LoadingDialog.hideLoadingDialog(context);
                Navigator.of(context).pop(true);
                MsgDialog.showMsgDialog(
                    context,
                    allTranslations.text("Information").toString(),
                    allTranslations.text("order_suc").toString());
              } else {
                LoadingDialog.hideLoadingDialog(context);
                MsgDialog.showMsgDialog(
                    context,
                    allTranslations.text("Information").toString(),
                    allTranslations.text("error").toString());
              }
            }
          },
        ),
      ],
    );
  }
}
