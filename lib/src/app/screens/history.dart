import 'package:flutter/material.dart';
import 'package:thekingcoffee/src/app/core/change_language.dart';
import 'package:thekingcoffee/src/app/core/config.dart';
import 'package:thekingcoffee/src/app/core/utils.dart';
import 'package:thekingcoffee/src/app/core/widgets/draw_left/draw_left.dart';
import 'package:thekingcoffee/src/app/screens/history_order_detail.dart';
import 'package:thekingcoffee/src/app/theme/styles.dart';

class History extends StatefulWidget {
  History({Key key}) : super(key: key);

  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  var dataHistory = [];
  int length = 0;

  intData() async {
    try {
      final result = await api.getHistory();
      if (this.mounted) {
        setState(() {
          if (result != null) {
            dataHistory = result;
            length = dataHistory.length;
          }
        });
      }
    } catch (e) {}
  }

  List<Widget> createStutusOrder(int index, int status) {
    List<Widget> widgets = [];
    if (status == 3) {
      widgets.add(Text(
        allTranslations.text("done").toString(),
        style: StylesText.style15Red,
      ));
    }
    if (status == -1) {
      widgets.add(Text(
        allTranslations.text("cancel").toString(),
        style: StylesText.style15Red,
      ));
    }
    if (status == 1) {
      widgets.add(Text(
        allTranslations.text("onprocess").toString(),
        style: StylesText.style15Red,
      ));
    }
    if (status == 2) {
      widgets.add(Text(
        allTranslations.text("shipping").toString(),
        style: StylesText.style15Red,
      ));
    }
    if (status == 0) {
      widgets.add(Text(
        allTranslations.text("no_process").toString(),
        style: StylesText.style15Red,
      ));
    }
    return widgets;
  }

  @override
  void initState() {
    intData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          allTranslations.text("history_order").toString(),
          style: StylesText.style20BrownBold,
        ),
        leading: FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.brown,
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        color: Colors.redAccent,
        onRefresh: onrefresh,
        child: dataHistory == null || dataHistory.length == 0
            ? Container(
                child: Center(
                  child: Text(
                    allTranslations.text("no_info").toString(),
                    style: StylesText.style13Black,
                  ),
                ),
              )
            : Container(
                padding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
                color: Colors.grey[300],
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemCount: length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (context) => HistoryOrderDetail(
                                      dataHistory[index]['DetailedOrder'],
                                      dataHistory[index]['Id'],
                                      dataHistory[index]['Address'],
                                      dataHistory[index]['Phone'],
                                      dataHistory[index]['Total'],
                                      dataHistory[index]['Time_Ordered'],
                                      dataHistory[index]['Star'],
                                      dataHistory[index]['Status'],
                                    )))
                            .then((value) => onrefresh());
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
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                                  allTranslations
                                                          .text("order")
                                                          .toString() +
                                                      " " +
                                                      dataHistory[index]['Id']
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                Dimension.getWidth(0.33),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Row(
                                                    children: createStutusOrder(
                                                        index,
                                                        dataHistory[index]
                                                            ['Status'])),
                                                // Padding(
                                                //     padding: const EdgeInsets
                                                //         .fromLTRB(0, 0, 0, 0),
                                                //     child:
                                                // dataHistory[index]
                                                //             ['State'] ==
                                                //         "1"
                                                //     ? Text(
                                                //         allTranslations
                                                //             .text("done")
                                                //             .toString(),
                                                //         style: StylesText
                                                //             .style15Red,
                                                //       )
                                                //     : Text(
                                                //         allTranslations
                                                //             .text("process")
                                                //             .toString(),
                                                //         style: StylesText
                                                //             .style15Red,
                                                //       )
                                                // ),
                                                Row(
                                                  children: <Widget>[
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                0, 0, 0, 0),
                                                        child: Text(
                                                          dataHistory[index]
                                                                  ['Total']
                                                              .toString(),
                                                          style: StylesText
                                                              .style15Red,
                                                        )),
                                                  ],
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
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 0, 0),
                                                  child: Text(
                                                    dataHistory[index]
                                                        ['Time_Ordered'],
                                                    style:
                                                        StylesText.style15Black,
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
      ),
      drawer: Drawer(
        child: HomeMenu(),
      ),
    );
  }

  Future<void> onrefresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      intData();
      build(context);
    });
  }
}
