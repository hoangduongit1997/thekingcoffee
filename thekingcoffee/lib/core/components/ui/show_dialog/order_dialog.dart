import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/app/data/model/size.dart';
import 'package:thekingcoffee/app/styles/styles.dart';
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
  int t=0;
  var topping = [];
  var selectedsize ;
  var size_product=[];
  int selectedRadioTile;
  List<Widget> createRadioListUsers() {
  List<Widget> widgets = [];
  widgets.add(Text("Size",style: StylesText.style13BrownBold,));
  for (var user in size_product) {
    widgets.add(
      Expanded(child:RadioListTile(
        value: user,
        groupValue: selectedsize,
        title: Text(user['Name'],style: StylesText.style13BrownBold,),
        onChanged: (currentUser) {
          money-=t;
          money+=int.tryParse(user['PlusMonney'].toString());
          t=int.tryParse(user['PlusMonney'].toString());
          
         setSelectedSize(currentUser);
        },
        selected:  selectedsize == user,
        activeColor: Colors.redAccent,
      ), ),

    );
  }
  return widgets;
}
  @override
  void initState() {
    super.initState();
     size_product=size;
     print("Size"+size_product.toString());
  }

  setSelectedSize(var size_p) {
    setState(() {
      selectedsize =size_p;
    });
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
             size_product.isEmpty?Container():Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Column(
                 children: <Widget>[
                   Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: createRadioListUsers(),)
                 ], 
                )
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
                            child: Text(
                              "Topping",
                              style: StylesText.style16Brown,
                            ),
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
                      child: Text(
                        "Money",
                        style: StylesText.style16Brown,
                      ),
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
                          padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                (money + int.tryParse(widget.price)).toString(),
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
                                padding:
                                    const EdgeInsets.fromLTRB(200, 0, 0, 0),
                                child: IconButton(
                                  icon: Icon(Icons.arrow_back_ios,
                                      color: Colors.brown),
                                  onPressed: () {
                                    setState(() {
                                      number--;
                                      money -= int.tryParse(widget.price);
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
