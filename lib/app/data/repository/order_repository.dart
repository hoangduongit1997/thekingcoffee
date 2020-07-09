import 'dart:convert';
import 'package:http/http.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thekingcoffee/app/screens/shopping_list.dart';
import 'package:thekingcoffee/core/components/ui/home_cart/home_cart_coffee.dart';

Future<bool> postOrder(String phone, String address, bool isMoney) async {
  bool statusOder = false;
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  int idUser = prefs.getInt('idUser');
  double lat = prefs.getDouble('Lat');
  double lng = prefs.getDouble('Lng');
  double total = 0;
  var orderData = [];
  for (var item in listOrderProducts) {
    total += item['Price'];
    var product = {};

    product['Id'] = item['Id'];
    product['Quantity'] = item['Quantity'];
    if (item['Size'] != null) {
      product['Catalogue_Size_Id'] = item['Size']['Id'];
    }
    product['Price'] = item['Price'];
    if (item['Toppings'] != null) {
      var selectedToppings = [];
      for (var topping in item['Toppings']) {
        var t = {};
        t['Id'] = topping['Id'];
        selectedToppings.add(t);
      }
      product['Toppings'] = selectedToppings;
    }
    if (item['SelectedPromotion'] != null &&
        item['selectedDetailedSaleForProduct'] != null) {
      var selectedSaleProductFor = [];
      for (var saleProductFor in item['selectedDetailedSaleForProduct']) {
        var temp = {};
        temp['IdProduct'] = saleProductFor['IdProduct'];
        temp['Quantity'] = 1;
        temp['Id_detailedsale'] = item['SelectedPromotion']['Id'];
        selectedSaleProductFor.add(temp);
      }
      product['SaleProductFor'] = selectedSaleProductFor;
    }
    orderData.add(product);
  }

  Map orderDetail = {
    "IsApp": true,
    "IdCustomer": idUser.toString(),
    "Shipment": feeShip,
    "Address": address.toString(),
    "Phone": phone.toString(),
    "Total": total + feeShip.toDouble(),
    "OrdersData": orderData,
    "Lat": lat.toString(),
    "Long": lng.toString(),
    "PaidByPoint": isMoney,
  };
  var bodyOrder = json.encode(orderDetail);
  Response response1 = await post(Config.orderAPI,
      headers: {'Token': token, 'Content-Type': 'application/json'},
      body: bodyOrder);
  var data = json.decode(response1.body);

  if (data['Status'] == 1) {
    prefs.setInt("points", data['Value']['Customer']['Point']);
    statusOder = true;
  } else {
    statusOder = false;
  }
  return statusOder;
}
