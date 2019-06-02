import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:thekingcoffee/app/config/config.dart';

import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/core/components/ui/draw_left/draw_left.dart';
import 'package:thekingcoffee/core/utils/utils.dart';

class EarnPoint extends StatefulWidget {
  _EarnPointState createState() => _EarnPointState();
}

class _EarnPointState extends State<EarnPoint> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Your code", style: StylesText.style20BrownBold),
          elevation: 0.5,
          backgroundColor: Colors.white,
          leading: FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.brown,
              )),
        ),
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: BarCodeImage(
                data: Config.id_user.toString(),
                codeType: BarCodeType.Code93,
                lineWidth: 5.0,
                barHeight: Dimension.getHeight(0.3),
                hasText: true,
                onError: (error) {
                  print('error = $error');
                },
              )),
        ),
        drawer: Drawer(
          child: HomeMenu(),
        ),
      ),
    );
  }
}
