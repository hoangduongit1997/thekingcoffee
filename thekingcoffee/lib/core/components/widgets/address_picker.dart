import 'package:flutter/material.dart';
import 'package:thekingcoffee/app/data/model/get_place_item.dart';
import 'package:thekingcoffee/app/screens/address_picker_page.dart';
import 'package:thekingcoffee/app/screens/map.dart';
import 'package:thekingcoffee/core/components/lib/change_language/change_language.dart';

class AddressPicker extends StatefulWidget {
  final Function(Get_Place_Item, bool) onSelected;

  AddressPicker(this.onSelected);

  @override
  _AddressPickerState createState() => _AddressPickerState();
}

class _AddressPickerState extends State<AddressPicker> {
  Get_Place_Item fromAddress;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Color(0x88999999),
              offset: Offset(0, 5),
              blurRadius: 5.0,
            ),
          ]),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 50,
            child: FlatButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RidePickerPage(
                            fromAddress == null ? "" : fromAddress.address,
                            (place, isFrom) {
                          widget.onSelected(place, isFrom);
                          fromAddress = place;
                          // setState(() {
                          //   final_address = fromAddress.address;
                          // });
                        }, true)));
              },
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: <Widget>[
                    SizedBox(
                      width: 40,
                      height: 50,
                      child: Center(
                        child: Icon(
                          Icons.location_on,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      width: 40,
                      height: 50,
                      child: Center(child: Icon(Icons.close)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 40, right: 50),
                      child: Text(
                        fromAddress == null
                            ? allTranslations.text("enter_address").toString()
                            : fromAddress.address,
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(fontSize: 16, color: Color(0xff323643)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
