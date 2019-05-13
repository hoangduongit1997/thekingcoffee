import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/app/styles/styles.dart';

import 'package:thekingcoffee/core/components/lib/radius_size/radius_size.dart';
import 'package:thekingcoffee/core/utils/utils.dart';

class Order_Dialog extends StatefulWidget {
 final String img;
final String name;
final String desc;
final String price;
final String topping;
final String size;
Order_Dialog(this.img,this.name,this.desc,this.price,this.size,this.topping);
  _Order_DialogState createState() => _Order_DialogState();
}

class _Order_DialogState extends State<Order_Dialog> {
  var topping=[];
  String radioValue = 'First';
  _Order_DialogState() {
    simpleBuilder = (BuildContext context, List<double> animValues,
        Function updateState, String value) {
      final alpha = (animValues[0] * 255).toInt();
      return GestureDetector(
          onTap: () {
            setState(() {
              radioValue = value;
            });
          },
          child: Container(
              padding: EdgeInsets.all(18),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor.withAlpha(alpha),
                  border: Border.all(
                    color:
                        Theme.of(context).primaryColor.withAlpha(255 - alpha),
                    width: 2.0,
                  )),
              child: Text(
                value,
                style:
                    Theme.of(context).textTheme.body1.copyWith(fontSize: 15.0),
              )));
    };
  }

  RadioBuilder<String, double> simpleBuilder;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.redAccent
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                              height: Dimension.getHeight(0.15),
                              width: Dimension.getWidth(0.3),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: CachedNetworkImage(
                                    imageUrl: Config.ip +
                                      widget.img,
                                    fit: BoxFit.cover,
                                    height: Dimension.getHeight(0.3),
                                    width: Dimension.getWidth(0.5),
                                    placeholder: (context, url) => new SizedBox(
                                          child: Center(
                                              child: CircularProgressIndicator(
                                            valueColor:
                                                new AlwaysStoppedAnimation<
                                                    Color>(Colors.redAccent),
                                          )),
                                        )),
                              )))
                    ],
                  ),
                  Expanded(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(2, 10, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.all(2.0),
                              child: Text(widget.name, style: StylesText.style20BrownBold,softWrap: true,),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(2, 10, 0, 0),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.redAccent,
                                radius: 12.0,
                                child: Icon(
                                  Icons.monetization_on,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child:
                                  Text(widget.price.toString(), style: StylesText.style16BrownBold),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                  )
                  
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(widget.desc, style: StylesText.style13Blugray),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("Size", style: StylesText.style18Black),
                    CustomRadio<String, double>(
                        value: 'Small',
                        groupValue: radioValue,
                        duration: Duration(milliseconds: 200),
                        animsBuilder: (AnimationController controller) => [
                              CurvedAnimation(
                                  parent: controller, curve: Curves.easeInOut)
                            ],
                        builder: simpleBuilder),
                    CustomRadio<String, double>(
                        value: 'Normal',
                        groupValue: radioValue,
                        duration: Duration(milliseconds: 200),
                        animsBuilder: (AnimationController controller) => [
                              CurvedAnimation(
                                  parent: controller, curve: Curves.easeInOut)
                            ],
                        builder: simpleBuilder),
                     CustomRadio<String, double>(
                        value: 'Big',
                        groupValue: radioValue,
                        duration: Duration(milliseconds: 200),
                        animsBuilder: (AnimationController controller) => [
                              CurvedAnimation(
                                  parent: controller, curve: Curves.easeInOut)
                            ],
                        builder: simpleBuilder),
                  ],
                ),
              ),
             topping.isEmpty?Container():Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Text("Topping", style: StylesText.style18Black),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Text("Money", style: StylesText.style18Black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
