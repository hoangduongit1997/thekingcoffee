import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:thekingcoffee/src/app/core/change_language.dart';
import 'package:thekingcoffee/src/app/core/config.dart';
import 'package:thekingcoffee/src/app/core/utils.dart';
import 'package:thekingcoffee/src/app/core/widgets/rating.dart';
import 'package:thekingcoffee/src/app/core/widgets/show_dialog/show_message_dialog.dart';
import 'package:thekingcoffee/src/app/theme/styles.dart';

class HistoryOrderDetail extends StatefulWidget {
  int orderCode;
  var listDetailedProduct = [];
  String phonenumber;
  String address;
  String total;
  String time;
  int start = 0;
  int status;

  HistoryOrderDetail(this.listDetailedProduct, this.orderCode, this.address,
      this.phonenumber, this.total, this.time, this.start, this.status);
  _HistoryOrderDetailState createState() => _HistoryOrderDetailState();
}

class _HistoryOrderDetailState extends State<HistoryOrderDetail> {
  TextEditingController _rateComment;
  @override
  void initState() {
    super.initState();
    _rateComment = new TextEditingController();
  }

  bool stateRating = false;
  List<Widget> addRatingComment() {
    List<Widget> widgets = [];
    widgets.add(Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: TextField(
            decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.redAccent),
                ),
                hintText: allTranslations.text("comment").toString()),
            keyboardType: TextInputType.multiline,
            controller: _rateComment,
            maxLines: null,
          ),
        ),
        FlatButton(
          onPressed: sendRate,
          child: Container(
            width: Dimension.getWidth(0.8),
            height: Dimension.getHeight(0.05),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: Colors.orangeAccent),
            child: Center(
                child: Text(
              allTranslations.text("submit").toString(),
              style: StylesText.style14While,
            )),
          ),
        )
      ],
    ));
    return widgets;
  }

  double rating = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          title: Text(
            allTranslations.text("order").toString() +
                " " +
                widget.orderCode.toString(),
            style: StylesText.style20BrownBold,
          ),
          leading: FlatButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.brown,
            ),
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                padding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
                color: Colors.grey[300],
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    widget.status == 3
                        ? Container(
                            child: widget.start == 0 || widget.start == null
                                ? Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.0))),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 5, 0, 0),
                                            child: Text(
                                              allTranslations
                                                  .text("thank")
                                                  .toString(),
                                              style: StylesText
                                                  .style18BrownBoldRaleway,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: StarRating(
                                              size: 50.0,
                                              rating: rating,
                                              onRatingChanged: (rating) {
                                                setState(() {
                                                  stateRating = true;
                                                  this.rating = rating;
                                                });
                                              },
                                              color: Colors.orange,
                                              borderColor: Colors.orangeAccent,
                                              starCount: 5,
                                            ),
                                          ),
                                          stateRating == false
                                              ? Container()
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 2, 0, 0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children:
                                                        addRatingComment(),
                                                  ),
                                                )
                                        ],
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 0),
                                          child: Text(
                                            allTranslations
                                                .text("thank_ordered")
                                                .toString(),
                                            style: StylesText
                                                .style18BrownBoldRaleway,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: StarRating(
                                            size: 50.0,
                                            rating: widget.start.toDouble(),
                                            color: Colors.orange,
                                            borderColor: Colors.orangeAccent,
                                            starCount: 5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          )
                        : Container(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(2, 5, 2, 2),
                              child: Container(
                                  width: double.infinity,
                                  child: Text(
                                    allTranslations
                                        .text("detaied_order")
                                        .toString(),
                                    style: StylesText.style15BrownNormalRaleway,
                                  )),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(8.0, 5, 8.0, 2),
                              child: Container(
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Icon(
                                      Icons.phone_android,
                                      color: Colors.redAccent,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                      child: Text(
                                        widget.phonenumber.toString(),
                                        style: StylesText.style15Black,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(8.0, 5, 8.0, 2),
                              child: Container(
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Icon(
                                      Icons.map,
                                      color: Colors.redAccent,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                      child: Container(
                                        width: Dimension.getWidth(0.85),
                                        child: Text(
                                          widget.address.toString(),
                                          style: StylesText.style15Black,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(8.0, 5, 8.0, 2),
                              child: Container(
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Icon(
                                      Icons.access_time,
                                      color: Colors.redAccent,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                      child: Container(
                                        width: Dimension.getWidth(0.85),
                                        child: Text(
                                          widget.time.toString(),
                                          style: StylesText.style15Black,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Container(
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 2),
                              child: Container(
                                width: double.infinity,
                                child: Text(
                                  allTranslations
                                      .text("list_detailed_order")
                                      .toString(),
                                  style: StylesText.style15BrownNormalRaleway,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 2),
                              child: Container(
                                width: double.infinity,
                                constraints: new BoxConstraints(
                                  minHeight: Dimension.getHeight(0.12),
                                  minWidth: double.infinity,
                                  maxHeight: Dimension.getHeight(0.32),
                                  maxWidth: double.infinity,
                                ),
                                child: ListView.builder(
                                  itemCount: widget.listDetailedProduct.length,
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Container(
                                          height: Dimension.getHeight(0.12),
                                          padding: const EdgeInsets.all(5.0),
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
                                                              .getHeight(0.1),
                                                          width: Dimension
                                                              .getWidth(0.2),
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
                                                              imageUrl: domainAPI +
                                                                  widget
                                                                      .listDetailedProduct[
                                                                          index]
                                                                          [
                                                                          'DetailedProduct']
                                                                          [
                                                                          'File_Path']
                                                                      .toString(),
                                                              fit: BoxFit.fill,
                                                              placeholder: (context,
                                                                      url) =>
                                                                  new SizedBox(
                                                                child: Center(
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    valueColor:
                                                                        new AlwaysStoppedAnimation(
                                                                            Colors.redAccent),
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
                                                        MainAxisAlignment.start,
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
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .fromLTRB(
                                                                          5,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: <
                                                                        Widget>[
                                                                      Padding(
                                                                        padding: const EdgeInsets.fromLTRB(
                                                                            5,
                                                                            0,
                                                                            0,
                                                                            10),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              Dimension.getWidth(0.65),
                                                                          child:
                                                                              Text(
                                                                            widget.listDetailedProduct[index]['DetailedProduct']['Name'],
                                                                            style:
                                                                                StylesText.style15Black,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .fromLTRB(
                                                                          5,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  child:
                                                                      Container(
                                                                    width: Dimension
                                                                        .getWidth(
                                                                            0.51),
                                                                    child: Row(
                                                                      children: <
                                                                          Widget>[
                                                                        Stack(
                                                                          alignment:
                                                                              AlignmentDirectional.centerStart,
                                                                          children: <
                                                                              Widget>[
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: <Widget>[
                                                                                Text(widget.listDetailedProduct[index]['Quantity'].toString(), style: StylesText.style13BrownNormal)
                                                                              ],
                                                                            ),
                                                                            Container(
                                                                              width: Dimension.getWidth(0.51),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                                children: <Widget>[
                                                                                  Text(
                                                                                    widget.listDetailedProduct[index]['Price'].toString(),
                                                                                    style: StylesText.style15Red,
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            )
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
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
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 0, 20),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                      allTranslations
                                              .text("total_money")
                                              .toString() +
                                          ": ",
                                      style:
                                          StylesText.style15BrownNormalRaleway),
                                  Text(
                                    widget.total.toString(),
                                    style: StylesText.style15Red,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )));
  }

  void sendRate() async {
    if ((await api.rateOrder(widget.orderCode.toString(), rating,
            _rateComment.text.toString()) ==
        true)) {
      Navigator.of(context).pop(true);
      MsgDialog.showMsgDialog(
          context,
          allTranslations.text("Information").toString(),
          allTranslations.text("thank_ordered").toString());
    } else {
      MsgDialog.showMsgDialog(
          context,
          allTranslations.text("Information").toString(),
          allTranslations.text("error").toString());
    }
  }
}
