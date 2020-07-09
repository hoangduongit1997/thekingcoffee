import 'dart:async';
import 'package:thekingcoffee/app/data/repository/get_place.dart';

class PlaceBloc {
  var _placeController = StreamController.broadcast();
  Stream get placeStream => _placeController.stream;

  void searchPlace(String keyword) {
    _placeController.sink.add("Search");
    GetPlace.searchPlace(keyword).then((respone) {
      _placeController.sink.add(respone);
    }).catchError(() {});
  }

  void dispose() {
    _placeController.close();
  }
}
