import 'dart:async';

import 'package:thekingcoffee/core/components/ui/home_cart/home_cart_coffee.dart';

class Number_Bloc{
  StreamController<int> _number=new StreamController<int>.broadcast();
  Stream get numberStream=>_number.stream;
  void Check_Number()
  {
   int temp=ListOrderProducts.fold(0, (t, e) => t + e['Quantity']);
   if(temp>0)
   {
      _number.sink.add(temp);
   }
   else{
     _number.sink.add(0);
   }
  
  }
  void dispose()
  {
    _number.close();
  }
}