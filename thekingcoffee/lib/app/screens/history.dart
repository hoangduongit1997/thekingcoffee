import 'package:flutter/material.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/app/data/repository/get_history.dart';
import 'package:thekingcoffee/app/screens/helper/dashboard_helper/placeholder_home.dart';
import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/core/utils/utils.dart';

class History extends StatefulWidget {
  History({Key key}) : super(key: key);

  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  var data_history = [];
  intData() async {
    final result = await Get_History();
    setState(() {
      data_history = result;
    });
  }
  @override
  void initState() {
    intData();
    Config.isHideNavigation = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.5,
            title: Text(
              "History",
              style: StylesText.style20BrownBold,
            ),
            leading: FlatButton(
              onPressed: () {
                Config.isHideNavigation = false;
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => PlaceholderMainWidget()));
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.brown,
              ),
            ),
          ),
          resizeToAvoidBottomInset: false,
          body: data_history.isEmpty
              ? Container(
                  child: Center(child: Text("No information")),
                )
              : Container(
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
                  color: Colors.grey[300],
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: data_history.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          print("Ban chon don hang: "+index.toString()); 
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            height: Dimension.getHeight(0.15),
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Stack(
                                      alignment: AlignmentDirectional.topEnd,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                          child: Container(
                                            height: Dimension.getHeight(0.13),
                                            width: Dimension.getWidth(0.25),
                                            decoration: new BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              border: new Border.all(
                                                  color: Colors.white),
                                            ),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Icon(
                                                  Icons.store,
                                                  color: Colors.redAccent,
                                                  size: 50.0,
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 10),
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            child: Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 0, 0),
                                                  child: Text(
                                                    "Đơn hàng " +
                                                        data_history[index]
                                                                ['Id']
                                                            .toString(),
                                                    style: StylesText
                                                        .style15BlackBold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                         Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 10),
                                          child: Container(
                                            alignment: Alignment.topLeft,
    
                                            child: Container(
                                              width: MediaQuery.of(context).size.width-Dimension.getWidth(0.33),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.fromLTRB(
                                                            0, 0, 0, 0),
                                                    child:data_history[index]['State']=="1"?Text(
                                                      "Đã hoàn thành",
                                                      style: StylesText
                                                          .style15Red,
                                                    ):Text(
                                                      "Đang xử lý",
                                                      style: StylesText
                                                          .style15Red,
                                                    )
                                                  ),
                                                   Padding(
                                                    padding:
                                                        const EdgeInsets.fromLTRB(
                                                            0, 0, 0, 0),
                                                    child:Text(
                                                      data_history[index]['Price'].toString(),
                                                      style: StylesText
                                                          .style15Red,
                                                    )
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                          child: Container(
                                              alignment: Alignment.topLeft,
                                              child: Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 0, 0, 0),
                                                    child: Text(
                                                      data_history[index]
                                                          ['Time_Ordered'],
                                                      style: StylesText
                                                          .style15Black,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ));
  }
}
