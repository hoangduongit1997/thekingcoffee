import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:thekingcoffee/app/config/config.dart';
 Get_Data_All_Product() async {
   try {
      final response = await http.get(Config.get_data_home_cart_API);
    final res=json.decode(response.body)['Value'];
    return res;
   } catch (e) {
     print(e.toString());
     return null;
   }
}