import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thekingcoffee/src/app/core/change_language.dart';
import 'package:thekingcoffee/src/app/core/utils.dart';
import 'package:thekingcoffee/src/app/model/get_place_item.dart';
import 'package:thekingcoffee/src/app/streams/place_bloc.dart';
import 'package:thekingcoffee/src/app/theme/styles.dart';

class RidePickerPage extends StatefulWidget {
  final String selectedAddress;
  final Function(GetPlaceItem, bool) onSelected;
  final bool _isFromAddress;
  RidePickerPage(this.selectedAddress, this.onSelected, this._isFromAddress);

  @override
  _RidePickerPageState createState() => _RidePickerPageState();
}

class _RidePickerPageState extends State<RidePickerPage> {
  TextEditingController _addressController;
  var placeBloc = PlaceBloc();

  @override
  void initState() {
    _addressController = TextEditingController(text: widget.selectedAddress);
    super.initState();
  }

  @override
  void dispose() {
    placeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: FlatButton(
            child: Icon(
              Icons.arrow_back,
              color: Colors.brown,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.white,
          title: Text(
            allTranslations.text("enter_address").toString(),
            style: StylesText.style20BrownBold,
          ),
        ),
        body: Container(
          color: Color(0xfff8f8f8),
          child: SingleChildScrollView(
            child: RefreshIndicator(
                backgroundColor: Colors.white,
                color: Colors.redAccent,
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          width: double.infinity,
                          height: 60,
                          child: Stack(
                            alignment: AlignmentDirectional.centerStart,
                            children: <Widget>[
                              SizedBox(
                                width: 40,
                                height: 60,
                                child: Center(
                                    child: Icon(
                                  Icons.location_on,
                                  color: Colors.redAccent,
                                )),
                              ),
                              Positioned(
                                right: 0.0,
                                top: 0.0,
                                width: 40,
                                height: 60,
                                child: Center(
                                  child: FlatButton(
                                    onPressed: () {
                                      _addressController.clear();
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 40, right: 50),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: allTranslations
                                        .text("enter_address")
                                        .toString(),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.redAccent),
                                    ),
                                  ),
                                  controller: _addressController,
                                  textInputAction: TextInputAction.search,
                                  onSubmitted: (str) {
                                    placeBloc.searchPlace(str);
                                  },
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xff323643)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
                      width: double.infinity,
                      height: Dimension.getHeight(0.8),
                      child: StreamBuilder(
                          stream: placeBloc.placeStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              print(snapshot.data.toString());
                              if (snapshot.data == "Search") {
                                return Center(
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            Colors.redAccent),
                                  ),
                                );
                              }

                              print(snapshot.data.toString());
                              List<GetPlaceItem> places = snapshot.data;
                              return ListView.separated(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      leading: Icon(Icons.location_city,
                                          color: Colors.grey),
                                      title: Text(places.elementAt(index).name),
                                      subtitle:
                                          Text(places.elementAt(index).address),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        widget.onSelected(
                                            places.elementAt(index),
                                            widget._isFromAddress);
                                      },
                                    );
                                  },
                                  separatorBuilder: (context, index) => Divider(
                                        height: 1,
                                        color: Color(0xfff5f5f5),
                                      ),
                                  itemCount: places.length);
                            } else {
                              return Container();
                            }
                          }),
                    )
                  ],
                ),
                onRefresh: onrefresh),
          ),
        ));
  }

  Future<void> onrefresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      placeBloc.searchPlace(_addressController.text);
    });
  }
}
