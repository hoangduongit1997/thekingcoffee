import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/app/data/model/size.dart';
import 'package:thekingcoffee/app/styles/styles.dart';

import 'package:thekingcoffee/core/components/lib/radius_size/radius_size.dart';
import 'package:thekingcoffee/core/components/ui/home_cart/home_cart.dart';
import 'package:thekingcoffee/core/utils/utils.dart';

class Order_Dialog extends StatefulWidget {
  final String img;
  final String name;
  final String desc;
  final String price;
  final String topping;
  final String size;
  Order_Dialog(
      this.img, this.name, this.desc, this.price, this.size, this.topping);
  Order_DialogState createState() => Order_DialogState();
}

class Order_DialogState extends State<Order_Dialog> {
  
  int number = 1;
  int money = 0;
   var topping=[];
  String radioValue = 'First'; 
   RadioBuilder<String, double> simpleBuilder;
  Order_DialogState() {
    simpleBuilder = (BuildContext context, List<double> animValues,
        Function updateState, String value) {
      final alpha = (animValues[0] * 255).toInt();
      return GestureDetector(
          onTap: () {
            setState(() {
              radioValue = value;
            
            });
            print(value);
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
    List<Widget> getList() {
  List<Widget> childs = [];

  for (Size_Product i in size) {
    childs.add(
       CustomRadio<String, double>(
                value: i.name,
                groupValue: radioValue,
                duration: Duration(milliseconds: 500),
                animsBuilder: (AnimationController controller) => [
                  CurvedAnimation(
                    parent: controller,
                    curve: Curves.easeInOut
                  )
                ],
                builder: simpleBuilder
              ),
    );
  return childs;
}
  }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.redAccent),
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
                                    imageUrl: Config.ip + widget.img,
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
                              child: Text(
                                widget.name,
                                style: StylesText.style20BrownBold,
                                softWrap: true,
                              ),
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
                              child: Text(widget.price.toString(),
                                  style: StylesText.style16BrownBold),
                            )
                          ],
                        ),
                      )
                    ],
                  ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child:
                          Text(widget.desc, style: StylesText.style13Blugray),
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
                   
                    
                    
                  ],
                ),
              ),

             
              topping.isEmpty
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child:
                                Text("Topping", style: StylesText.style18Black),
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
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      alignment: AlignmentDirectional.centerStart,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.fromLTRB(30, 0, 0,0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                (money+int.tryParse(widget.price)).toString(),
                                style: StylesText.style20BrownBold,
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(200, 0, 0, 0),
                                child: IconButton(
                                  icon: Icon(Icons.arrow_back_ios,
                                      color: Colors.brown),
                                  onPressed: () {
                                    setState(() {
                                      number--;
                                      money -=int.tryParse(widget.price);
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                child: Text(number.toString()),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                child: IconButton(
                                  icon: Icon(Icons.arrow_forward_ios,
                                      color: Colors.brown),
                                  onPressed: () {
                                    setState(() {
                                      number++;
                                      money += int.tryParse(widget.price);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
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
