
import 'package:flutter/material.dart';
import 'package:thekingcoffee/app/bloc/place_bloc.dart';
import 'package:thekingcoffee/app/data/model/get_place_item.dart';

class RidePickerPage extends StatefulWidget {
  final String selectedAddress;
  final Function(Get_Place_Item, bool) onSelected;
  final bool _isFromAddress;
  RidePickerPage(this.selectedAddress, this.onSelected, this._isFromAddress);

  @override
  _RidePickerPageState createState() => _RidePickerPageState();
}

class _RidePickerPageState extends State<RidePickerPage> {
  var _addressController;
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
    return  Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Enter your address"),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Color(0xfff8f8f8),
        child: SingleChildScrollView(
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
                          child: Icon(Icons.location_on,color: Colors.redAccent,)
                        ),
                      ),
                      Positioned(
                        right: 0.0,
                        top: 0.0,
                        width: 40,
                        height: 60,
                        child: Center(
                          child: FlatButton(
                              onPressed: () {
                                _addressController.text = "";
                              },
                              child: Icon(Icons.close,color: Colors.redAccent,),
                        ),
                      ),),
                      Padding(
                        padding: EdgeInsets.only(left: 40, right: 50),
                        child: TextField(
                          controller: _addressController,
                          textInputAction: TextInputAction.search,
                          onChanged: (str) {
                            placeBloc.searchPlace(str);
                          },
                          style:
                              TextStyle(fontSize: 16, color: Color(0xff323643)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: SingleChildScrollView(
                child:  StreamBuilder(
                  stream: placeBloc.placeStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data.toString());
                      if (snapshot.data == "Search") {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      print(snapshot.data.toString());
                      List<Get_Place_Item> places = snapshot.data;
                      return 
                        ListView.separated(
                          shrinkWrap: true,
                          
                          itemBuilder: (context, index) {
                            return ListTile(
                              
                              title: Text(places.elementAt(index).name),
                              subtitle: Text(places.elementAt(index).address),
                              onTap: () {
                                Navigator.of(context).pop();
                                widget.onSelected(places.elementAt(index),
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
             
            )
          ],
        ),
        )
        
      ),
    );
    
   
  }
}
