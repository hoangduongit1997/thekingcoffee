import 'package:flutter/material.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/app/data/repository/get_history.dart';
import 'package:thekingcoffee/app/screens/dashboard.dart';
import 'package:thekingcoffee/app/screens/helper/dashboard_helper/placeholder_home.dart';
import 'package:thekingcoffee/app/screens/history_order_detail.dart';
import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/core/components/ui/draw_left/draw_left.dart';
import 'package:thekingcoffee/core/utils/utils.dart';

class History extends StatefulWidget {
  History({Key key}) : super(key: key);

  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  var data_history = [];
  int length = 0;

  intData() async {
    final result = await Get_History();
    if (this.mounted) {
      setState(() {
        if (result != null) {
          data_history = result;
          length = data_history.length;
        }
      });
    }
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
          "History",
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
      body: data_history == null || data_history.length == 0
          ? Container(
              child: Center(child: Text("No information")),
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => History_Order_Detail(
                                data_history[index]['DetailedOrder'],
                                data_history[index]['Id'],
                                data_history[index]['Address'],
                                data_history[index]['Phone'],
                                data_history[index]['Total'],
                                data_history[index]['Time_Ordered'],
                              )));
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
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                "Oder " +
                                                    data_history[index]['Id']
                                                        .toString(),
                                                style:
                                                    StylesText.style15BlackBold,
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
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 0, 0),
                                                  child: data_history[index]
                                                              ['State'] ==
                                                          "1"
                                                      ? Text(
                                                          "Done",
                                                          style: StylesText
                                                              .style15Red,
                                                        )
                                                      : Text(
                                                          "Processing",
                                                          style: StylesText
                                                              .style15Red,
                                                        )),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 0, 0),
                                                  child: Text(
                                                    data_history[index]['Total']
                                                        .toString(),
                                                    style:
                                                        StylesText.style15Red,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Container(
                                          alignment: Alignment.topLeft,
                                          child: Row(
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 0),
                                                child: Text(
                                                  data_history[index]
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
      drawer: Drawer(
        child: HomeMenu(),
      ),
    );
  }
}
