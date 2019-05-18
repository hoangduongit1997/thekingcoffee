import 'package:flutter/material.dart';

class See_All_Product extends StatefulWidget {
  See_All_Product({Key key}) : super(key: key);

  _See_All_ProductState createState() => _See_All_ProductState();
}

class _See_All_ProductState extends State<See_All_Product> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            // child: ListView.builder(
            //   scrollDirection: Axis.vertical,
            //   shrinkWrap: true,
            //   physics: const ClampingScrollPhysics(),
            //   itemCount:
            // ),
            child: Text("a")),
      ),
    );
  }
}
