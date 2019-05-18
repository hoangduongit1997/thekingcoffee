import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:thekingcoffee/app/screens/dashboard.dart';
import 'package:thekingcoffee/app/screens/map.dart';
import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/core/components/ui/draw_left/draw_left.dart';
import 'package:thekingcoffee/core/components/widgets/address_picker.dart';
import 'package:thekingcoffee/core/utils/utils.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Shopping_List extends StatefulWidget {
  Shopping_List({Key key}) : super(key: key);

  Shopping_ListState createState() => Shopping_ListState();
}

class Shopping_ListState extends State<Shopping_List> {
  static var Product_Shopping_List = [
    {
      "img": "http://207.148.71.41/storage/images/kingcoffee/coffee3.jpg",
      "name": "Tra dao",
      "price": 100,
      "quantity": 2,
    },
    {
      "img": "http://207.148.71.41/storage/images/kingcoffee/coffee3.jpg",
      "name": "Tra",
      "price": 100,
      "quantity": 2,
    },
    {
      "img": "http://207.148.71.41/storage/images/kingcoffee/coffee3.jpg",
      "name": "Tra dao",
      "price": 100,
      "quantity": 2,
    },
    {
      "img": "http://207.148.71.41/storage/images/kingcoffee/coffee3.jpg",
      "name": "Tra dao",
      "price": 100,
      "quantity": 2,
    }
  ];
  var fake_list = [];
  @override
  void initState() {
    fake_list = Product_Shopping_List;
    super.initState();
  }

  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController name = new TextEditingController(text: "Hoàng Dương");
  TextEditingController phone = new TextEditingController(text: "0798353751");
  TextEditingController address = new TextEditingController(
      text: final_address == "" ? null : final_address);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.redAccent),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: FlatButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => DashBoard()));
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.brown,
              )),
          backgroundColor: Colors.white,
          title: Text(
            "Shopping list",
            style: StylesText.style20BrownBold,
          ),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                          title: new Text("Confirm",
                              style: StylesText.style18RedaccentBold),
                          content: new Text(
                            "Do you want to delete all shopping list ?",
                            style: StylesText.style15Black,
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("No"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            FlatButton(
                              child: Text("Yes"),
                              onPressed: () {
                                setState(() {
                                  fake_list.clear();
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
                },
                child: Icon(
                  Icons.delete_forever,
                  color: Colors.redAccent,
                ))
          ],
        ),
        resizeToAvoidBottomInset: false,
        body: Product_Shopping_List.isEmpty
            ? Container(
                child: Center(
                    child:
                        Text("No information", style: StylesText.style16Brown)),
              )
            : SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextField(
                            decoration: InputDecoration(
                                icon: Icon(Icons.account_circle)),
                            controller: name,
                            style: StylesText.style16Brown,
                          )),
                      Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextField(
                            decoration:
                                InputDecoration(icon: Icon(Icons.phone)),
                            controller: phone,
                            style: StylesText.style16Brown,
                          )),
                      Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextField(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MapPage()));
                            },
                            decoration: InputDecoration(
                                icon: Icon(Icons.map),
                                hintText: "Enter your address..."),
                            controller: address,
                            style: StylesText.style16Brown,
                          )),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                          child: Container(
                            height: Dimension.getHeight(0.5),
                            width: double.infinity,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: fake_list.length,
                              itemBuilder: (context, index) {
                                return Slidable(
                                  delegate: new SlidableDrawerDelegate(),
                                  actionExtentRatio: 0.25,
                                  child: Container(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Container(
                                          height: Dimension.getHeight(0.135),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.grey[300]),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8.0))),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Stack(
                                                      alignment:
                                                          AlignmentDirectional
                                                              .topEnd,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  0, 0, 0, 0),
                                                          child: Container(
                                                            height: Dimension
                                                                .getHeight(
                                                                    0.13),
                                                            width: Dimension
                                                                .getWidth(0.25),
                                                            decoration:
                                                                new BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              border: new Border
                                                                      .all(
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              child:
                                                                  CachedNetworkImage(
                                                                imageUrl:
                                                                    fake_list[
                                                                            index]
                                                                        ['img'],
                                                                fit:
                                                                    BoxFit.fill,
                                                                placeholder: (context,
                                                                        url) =>
                                                                    new SizedBox(
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            CircularProgressIndicator(
                                                                          valueColor:
                                                                              new AlwaysStoppedAnimation(Colors.redAccent),
                                                                        ),
                                                                      ),
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  5, 0, 0, 0),
                                                          child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: Row(
                                                                children: <
                                                                    Widget>[
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.fromLTRB(
                                                                            5,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                        fake_list[index]
                                                                            [
                                                                            'name']),
                                                                  ),
                                                                ],
                                                              )),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      10,
                                                                      10,
                                                                      0,
                                                                      10),
                                                              child: Text("Size " +
                                                                  fake_list[index]
                                                                          [
                                                                          'price']
                                                                      .toString()),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      50,
                                                                      0,
                                                                      0,
                                                                      0),
                                                              child: Text("Topping " +
                                                                  fake_list[index]
                                                                          [
                                                                          'price']
                                                                      .toString()),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  10, 0, 0, 0),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Text("Quanlity " +
                                                                  fake_list[index]
                                                                          [
                                                                          'quantity']
                                                                      .toString()),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        170,
                                                                        0,
                                                                        0,
                                                                        0),
                                                                child: Text(
                                                                  fake_list[index]
                                                                          [
                                                                          'price']
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .red),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ]))),
                                  secondaryActions: <Widget>[
                                    new IconSlideAction(
                                        caption: 'Delete',
                                        color: Colors.red,
                                        icon: Icons.delete,
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  15.0))),
                                                  title: new Text("Confirm",
                                                      style: StylesText
                                                          .style18RedaccentBold),
                                                  content: new Text(
                                                    "Do you want to delete " +
                                                        fake_list[index]
                                                            ['name'] +
                                                        "?",
                                                    style:
                                                        StylesText.style15Black,
                                                  ),
                                                  actions: <Widget>[
                                                    FlatButton(
                                                      child: Text("No"),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                    FlatButton(
                                                      child: Text("Yes"),
                                                      onPressed: () {
                                                        setState(() {
                                                          fake_list
                                                              .removeAt(index);
                                                        });
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              });
                                        }),
                                  ],
                                );
                                // );
                              },
                            ),
                          )),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 5, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                "Total: ",
                                style: StylesText.style18BrownBold,
                              ),
                              Text(
                                "12000",
                                style: StylesText.style18Black,
                              )
                            ],
                          ))
                    ],
                  ),
                ),
              ),
        drawer: Drawer(
          child: HomeMenu(),
        ),
        bottomNavigationBar: fake_list.isEmpty
            ? Container(
                child: Center(
                    child:
                        Text("No information", style: StylesText.style16Brown)),
              )
            : new Container(
                height: Dimension.getHeight(0.05),
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => DashBoard()));
                      },
                      child: Text(
                        "Continue shopping",
                        style: StylesText.style14BrownBold,
                      ),
                      color: Colors.white,
                    )),
                    Expanded(
                      child: MaterialButton(
                          onPressed: () {},
                          child: Text(
                            "Purchase",
                            style: StylesText.style14While,
                          ),
                          color: Colors.redAccent),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
