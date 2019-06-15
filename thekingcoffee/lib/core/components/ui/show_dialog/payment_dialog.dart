import 'package:flutter/material.dart';
import 'package:thekingcoffee/app/bloc/order_bloc.dart';
import 'package:thekingcoffee/app/data/repository/order_repository.dart';
import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/core/components/ui/show_dialog/show_message_dialog.dart';
import 'package:thekingcoffee/core/utils/utils.dart';

import 'loading_dialog.dart';

class Payment_Dialog extends StatefulWidget {
  final String phone;
  final String address;
  Payment_Dialog(this.phone, this.address);
  @override
  State<StatefulWidget> createState() {
    return Payment_Dialog_State();
  }
}

enum SingingCharacter { Change_Points, Cast }

class Payment_Dialog_State extends State<Payment_Dialog> {
  OrderBloc orderBloc = new OrderBloc();
  SingingCharacter _character = SingingCharacter.Change_Points;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      title: Text(
        'Payment method',
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
                  "Pay with your points",
                  style: StylesText.style11BrownNormal,
                ),
                activeColor: Colors.redAccent,
                title: Text('Change Points'),
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
                  "Pay with money",
                  style: StylesText.style11BrownNormal,
                ),
                title: Text('Cash'),
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
              LoadingDialog.showLoadingDialog(context, "Loading...");
              if (await PostOrder(widget.phone, widget.address) == true) {
                LoadingDialog.hideLoadingDialog(context);
                Navigator.of(context).pop(true);
                MsgDialog.showMsgDialog(
                    context, "Information", "Order succesfull!");
              } else {
                LoadingDialog.hideLoadingDialog(context);
                MsgDialog.showMsgDialog(context, "Information", "Error!");
              }
            }
          },
        ),
      ],
    );
  }
}
