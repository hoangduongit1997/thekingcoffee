import 'dart:async';

import 'package:thekingcoffee/app/validation/validation.dart';

class Coupon_Bloc {
  StreamController _coupon = new StreamController.broadcast();
  Stream get coupon_stream => _coupon.stream;
  bool isValidInfo(String coupon) {
    bool status = false;
    if (!Validation.isValidAddress(coupon)) {
      status = false;
      _coupon.sink.addError("Invalid Coupon");
    }
    if (Validation.isValidAddress(coupon)) {
      status = true;
      _coupon.sink.add("OK");
    }
    return status;
  }

  void dispose() {
    _coupon.close();
  }
}
