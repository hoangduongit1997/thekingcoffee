import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:thekingcoffee/app/data/model/get_place_item.dart';
import 'package:thekingcoffee/app/screens/dashboard.dart';
import 'package:thekingcoffee/app/screens/shopping_list.dart';
import 'package:thekingcoffee/core/components/ui/draw_left/draw_left.dart';
import 'package:thekingcoffee/core/components/widgets/address_picker.dart';
import 'package:thekingcoffee/core/utils/utils.dart';

class MapPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

String final_address = "";

class _HomePageState extends State<MapPage> {
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId selectedMarker;

  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  final Map<String, Marker> _markers = <String, Marker>{};

  GoogleMapController _mapController;

  MapType _currentMapType = MapType.normal;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          key: _scaffoldKey,
          body: Container(
            constraints: BoxConstraints.expand(),
            color: Colors.white,
            child: Center(
              child: Stack(
                children: <Widget>[
                  GoogleMap(
                    mapType: _currentMapType,
                    onMapCreated: (GoogleMapController controller) {
                      _mapController = controller;
                    },
                    markers: Set<Marker>.of(markers.values),
                    scrollGesturesEnabled: true,
                    rotateGesturesEnabled: true,
                    tiltGesturesEnabled: true,
                    minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    compassEnabled: true,
                    zoomGesturesEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(10.799651, 106.630737),
                      zoom: 14.4746,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    right: 0,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        AppBar(
                          elevation: 0.0,
                          backgroundColor: Colors.transparent,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: 20, left: 20, right: 20),
                          child: RidePicker(onPlaceSelected),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    onPressed: _onMapTypeButtonPressed,
                    tooltip: 'Change style map',
                    child: Icon(Icons.map),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: Dimension.getHeight(0.128),
                        width: Dimension.getWidth(0.128),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.blue),
                        child: IconButton(
                          tooltip: "Send to this address",
                          icon: Icon(Icons.send),
                          color: Colors.redAccent,
                          onPressed: () {
                            Navigator.of(context).pop(final_address);
                          },
                        ))),
              ],
            ),
          ),
        ));
  }

  void onPlaceSelected(Get_Place_Item place, bool fromAddress) {
    _addMarker(place);
    _moveCamera(place);
  }

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _addMarker(Get_Place_Item place) async {
    final String markerIdVal = 'marker_id' + place.name;

    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(place.lat, place.lng),
      infoWindow: InfoWindow(title: place.name),
    );

    setState(() {
      markers[markerId] = marker;
    });
  }

  void _moveCamera(Get_Place_Item place) {
    _mapController.moveCamera(
      CameraUpdate.newLatLngZoom(LatLng(place.lat, place.lng), 17.0),
    );
  }
}
