import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thekingcoffee/app/config/config.dart';

Future<bool> check_enough_point(int total) async {
  bool status=false;
  final pref=await SharedPreferences.getInstance();
   int id_user=pref.getInt("id_user");
   String token=pref.getString("token");
  final response=await http.get(Config.check_point+"?IdCustomer="+id_user.toString()+"&Total="+total.toString(),headers: {
    'Token':token
  });
  var data=json.decode(response.body);
  if(data['Status']==1)
  {
    status=true;
  }
  else{
    status=false;
  }
  return status;
}