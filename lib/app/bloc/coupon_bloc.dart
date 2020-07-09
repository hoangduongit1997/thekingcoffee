import 'dart:async';

import 'package:thekingcoffee/app/validation/validation.dart';
import 'package:thekingcoffee/core/components/lib/change_language/change_language.dart';

class CouponBloc {
  StreamController _coupon = new StreamController.broadcast();
  Stream get couponStream => _coupon.stream;
  bool isValidInfo(String coupon) {
    bool status = false;
    if (!Validation.isValidAddress(coupon)) {
      status = false;
      _coupon.sink.addError(allTranslations.text("invalid_coupon").toString());
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
