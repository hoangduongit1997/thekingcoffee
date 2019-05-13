
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:thekingcoffee/app/data/model/get_place_item.dart';
import 'package:thekingcoffee/core/components/ui/draw_left/draw_left.dart';
import 'package:thekingcoffee/core/components/widgets/address_picker.dart';

class MapPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<MapPage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _tripDistance = 0;
  final Map<String, Marker> _markers = <String, Marker>{};

  GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            GoogleMap(
//              key: ggKey,
//              markers: Set.of(markers.values),
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(10.7915178, 106.7271422),
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
                    leading: FlatButton(
                        onPressed: () {
                          _scaffoldKey.currentState.openDrawer();
                        },
                        child:Icon(Icons.menu) ),
                   
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: RidePicker(onPlaceSelected),
                  ),
                ],
              ),
            ),
            // Positioned(left: 20, right: 20, bottom: 40,
            //   height: 248,
            //   child: CarPickup(_tripDistance),
            // )
          ],
        ),
      ),
      drawer: Drawer(
        child: HomeMenu(),
      ),
    );
  }

  void onPlaceSelected(Get_Place_Item place, bool fromAddress) {
    var mkId = fromAddress ? "from_address" : "null";
    _addMarker(mkId, place);
    _moveCamera();
    // _checkDrawPolyline();
  }

  void _addMarker(String mkId, Get_Place_Item place) async {
    // remove old
    _markers.remove(mkId);
    _mapController.clearMarkers();

    _markers[mkId] = Marker(
        mkId,
        MarkerOptions(
            position: LatLng(place.lat, place.lng),
            infoWindowText: InfoWindowText(place.name, place.address)));

    for (var m in _markers.values) {
      await _mapController.addMarker(m.options);
    }
  }

  void _moveCamera() {
    print("move camera: ");
    print(_markers);

    if (_markers.values.length > 1) {
      var fromLatLng = _markers["from_address"].options.position;
      var toLatLng = _markers["to_address"].options.position;

      var sLat, sLng, nLat, nLng;
      if(fromLatLng.latitude <= toLatLng.latitude) {
        sLat = fromLatLng.latitude;
        nLat = toLatLng.latitude;
      } else {
        sLat = toLatLng.latitude;
        nLat = fromLatLng.latitude;
      }

      if(fromLatLng.longitude <= toLatLng.longitude) {
        sLng = fromLatLng.longitude;
        nLng = toLatLng.longitude;
      } else {
        sLng = toLatLng.longitude;
        nLng = fromLatLng.longitude;
      }

      LatLngBounds bounds = LatLngBounds(northeast: LatLng(nLat, nLng), southwest: LatLng(sLat, sLng));
      _mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    } else {
      _mapController.animateCamera(CameraUpdate.newLatLng(
          _markers.values.elementAt(0).options.position));
    }
  }

//   void _checkDrawPolyline() {
// //  remove old polyline
//     _mapController.clearPolylines();

//     if (_markers.length > 1) {
//       var from = _markers["from_address"].options.position;
//       var to = _markers["to_address"].options.position;
//       PlaceService.getStep(
//               from.latitude, from.longitude, to.latitude, to.longitude)
//           .then((vl) {
//             TripInfoRes infoRes = vl;

//             _tripDistance = infoRes.distance;
//             setState(() {
//             });
//         List<StepsRes> rs = infoRes.steps;
//         List<LatLng> paths = new List();
//         for (var t in rs) {
//           paths
//               .add(LatLng(t.startLocation.latitude, t.startLocation.longitude));
//           paths.add(LatLng(t.endLocation.latitude, t.endLocation.longitude));
//         }

// //        print(paths);
//         _mapController.addPolyline(PolylineOptions(
//             points: paths, color: Color(0xFF3ADF00).value, width: 10));
//       });
//     }
//   }
}
