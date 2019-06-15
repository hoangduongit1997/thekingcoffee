import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';
import 'package:thekingcoffee/app/data/model/get_place_item.dart';
import 'package:thekingcoffee/core/components/lib/change_language/change_language.dart';
import 'package:thekingcoffee/core/components/widgets/address_picker.dart';
import 'package:thekingcoffee/core/utils/utils.dart';
import 'package:geocoder/geocoder.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

String final_address;

class _MapPageState extends State<MapPage> {
  LocationData _startLocation;
  StreamSubscription<LocationData> _locationSubscription;
  Location _locationService = new Location();
  bool _permission = false;
  String error;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId selectedMarker;
  GoogleMapController _mapController;
  Completer<GoogleMapController> _controller = Completer();
  initPlatformState() async {
    await _locationService.changeSettings(
        accuracy: LocationAccuracy.HIGH, interval: 1000);

    LocationData location;

    try {
      bool serviceStatus = await _locationService.serviceEnabled();

      if (serviceStatus) {
        _permission = await _locationService.requestPermission();

        if (_permission) {
          location = await _locationService.getLocation();

          _locationSubscription = _locationService
              .onLocationChanged()
              .listen((LocationData result) async {
            _mapController = await _controller.future;
            _mapController.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: LatLng(result.latitude, result.longitude),
                    zoom: 17.0)));

            if (mounted) {
              setState(() {
                _startLocation = result;
              });
            }
          });
        }
      } else {
        bool serviceStatusResult = await _locationService.requestService();
        if (serviceStatusResult) {
          initPlatformState();
        }
      }
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        error = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        error = e.message;
      }
      location = null;
    }

    setState(() {
      _startLocation = location;
      _search_name_location(_startLocation.latitude, _startLocation.longitude);
      _addMarker_Current_Position(
          _startLocation.latitude, _startLocation.longitude);
    });
  }

  @override
  void initState() {
    super.initState();
    final_address = "";
    initPlatformState();
  }

  MapType _currentMapType = MapType.normal;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: Center(
          child: Stack(
            children: <Widget>[
              _startLocation == null
                  ? Container()
                  : GoogleMap(
                      mapType: _currentMapType,
                      onMapCreated: (GoogleMapController controller) {
                        _mapController = controller;
                      },
                      markers: Set<Marker>.of(markers.values),
                      scrollGesturesEnabled: true,
                      rotateGesturesEnabled: true,
                      tiltGesturesEnabled: true,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                      compassEnabled: true,
                      zoomGesturesEnabled: true,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                            _startLocation.latitude, _startLocation.longitude),
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
                    Padding(
                      padding: EdgeInsets.only(top: 80, left: 20, right: 20),
                      child: AddressPicker(onPlaceSelected),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: _onMapTypeButtonPressed,
                tooltip: allTranslations.text("Change_style_map").toString(),
                child: Icon(
                  Icons.map,
                  color: Colors.redAccent,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Container(
                    height: Dimension.getHeight(0.128),
                    width: Dimension.getWidth(0.128),
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 40.0,
                        spreadRadius: 2.0,
                        offset: Offset(
                          8.0,
                          8.0,
                        ),
                      )
                    ], shape: BoxShape.circle, color: Colors.white),
                    child: IconButton(
                      tooltip: allTranslations.text("send_address").toString(),
                      icon: Icon(Icons.send),
                      color: Colors.redAccent,
                      onPressed: () {
                        Navigator.of(context).pop(final_address);
                      },
                    ))),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Future onPlaceSelected(Get_Place_Item place, bool fromAddress) async {
    _addMarker(place);
    _moveCamera(place);
    await _add_latlog(place);
  }

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType =
          _currentMapType == MapType.normal ? MapType.hybrid : MapType.normal;
    });
  }

  void _onMarkerTapped(MarkerId markerId) {
    final Marker tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      setState(() {
        if (markers.containsKey(selectedMarker)) {
          final Marker resetOld = markers[selectedMarker]
              .copyWith(iconParam: BitmapDescriptor.defaultMarker);
          markers[selectedMarker] = resetOld;
        }
        selectedMarker = markerId;
        final Marker newMarker = tappedMarker.copyWith(
          iconParam: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
        );
        markers[markerId] = newMarker;
      });
    }
  }

  void _addMarker(Get_Place_Item place) async {
    final String markerIdVal = 'marker_id' + place.name;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(place.lat, place.lng),
      infoWindow: InfoWindow(title: place.name),
      onTap: () {
        _onMarkerTapped(markerId);
      },
    );

    setState(() {
      markers[markerId] = marker;
    });
  }

  void _addMarker_Current_Position(double lat, double long) async {
    final String markerIdVal = 'marker_id' + lat.toString();
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(lat, long),
      infoWindow: InfoWindow(title: final_address.toString()),
      onTap: () {
        _onMarkerTapped(markerId);
      },
    );

    setState(() {
      markers[markerId] = marker;
    });
  }

  void _remove() {
    setState(() {
      if (markers.containsKey(selectedMarker)) {
        markers.remove(selectedMarker);
      }
    });
  }

  void _moveCamera(Get_Place_Item place) {
    _mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(place.lat, place.lng), zoom: 17.0)));
  }

  Future _add_latlog(Get_Place_Item place) async {
    final pref = await SharedPreferences.getInstance();
    pref.setDouble('Lat', place.lat);
    pref.setDouble('Lng', place.lng);

    pref.commit();
  }

  Future _add_latlog_current_location(double lat, double lng) async {
    final pref = await SharedPreferences.getInstance();
    pref.setDouble('Lat', lat);
    pref.setDouble('Lng', lng);

    pref.commit();
    print("Sharepreference: " +
        pref.getDouble('Lat').toString() +
        " " +
        pref.getDouble('Lng').toString());
  }

  _search_name_location(double lat, double long) async {
    final coordinates = new Coordinates(lat, long);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    setState(() {
      final_address = first.addressLine.toString();
    });

    await _add_latlog_current_location(lat, long);
  }
}
