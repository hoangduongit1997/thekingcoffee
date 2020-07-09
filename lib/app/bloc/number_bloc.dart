import 'dart:async';

import 'package:thekingcoffee/core/components/ui/home_cart/home_cart_coffee.dart';

class NumberBloc {
  StreamController<int> _number = new StreamController<int>.broadcast();
  Stream get numberStream => _number.stream;
  void checkNumber() {
    int temp = listOrderProducts.fold(0, (t, e) => t + e['Quantity']);
    if (temp > 0) {
      _number.sink.add(temp);
    } else {
      _number.sink.add(0);
    }
  }

  void dispose() {
    _number.close();
  }
}
