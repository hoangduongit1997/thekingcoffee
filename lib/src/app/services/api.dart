import 'dart:convert';
import 'package:http/http.dart';

class Api {
  Api();
  final List<IntroSlider> introSlide = [
    IntroSlider(
        title: allTranslations.text("title_tutorial_1").toString(),
        subtitle: allTranslations.text("subtitle_tutorial_1").toString(),
        icon: Images.introicon),
    IntroSlider(
        title: allTranslations.text("title_tutorial_2").toString(),
        subtitle: allTranslations.text("subtitle_tutorial_2").toString(),
        icon: null),
    IntroSlider(
        title: allTranslations.text("title_tutorial_3").toString(),
        subtitle: allTranslations.text("subtitle_tutorial_3").toString(),
        icon: null),
  ];
  Future<int> checkCoupon(String coupon) async {
    var orderData = [];
    for (var item in listOrderProducts) {
      var product = {};
      product['Id'] = item['Id'];
      orderData.add(product);
    }

    final check = {"CouponCode": coupon, "ListProduct": orderData};
    var dataFinish = json.encode(check);
    Response response = await post(Config.checkCoupon,
        headers: {'Content-Type': 'application/json'}, body: dataFinish);
    var data = json.decode(response.body);
    if (data['Status'] == 1) {
      for (var item in listOrderProducts) {
        for (var check_item in data['Value']) {
          if (item['Id'] == check_item['Id'] &&
              check_item['HasCoupon'] == true) {
            item['Price'] = item['Price'] - check_item['PriceDiscount'];
          }
        }
      }
      print(listOrderProducts.toString());
      return 1;
    }
    return 0;
  }

  Future<bool> checkEnoughPoint(int total) async {
    bool status = false;
    final pref = await SharedPreferences.getInstance();
    int idUser = pref.getInt("idUser");
    String token = pref.getString("token");
    final response = await get(
        Config.checkPoint +
            "?IdCustomer=" +
            idUser.toString() +
            "&Total=" +
            total.toString(),
        headers: {'Token': token});
    var data = json.decode(response.body);

    if (data['Status'] == 1) {
      status = true;
    } else {
      status = false;
    }

    return status;
  }

  Future findFood(String food) async {
    try {
      var res;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token");
      if (token != null) {
        http.Response response = await http
            .get(Config.findFoodAPI + food, headers: {'Token': token});
        res = json.decode(response.body)['Value'];
      } else {
        http.Response response = await http.get(Config.findFoodAPI + food);
        res = json.decode(response.body)['Value'];
      }
      if (res == null) {
        showToast(
          allTranslations.text("no_food").toString(),
        );
      }
      return res;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getCoffeeProduct() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token");
      if (token != null) {
        final response = await http
            .get(Config.getCoffeeProductsAPI, headers: {'Token': token});
        final res = json.decode(response.body)['Value'];
        return res;
      } else {
        final response = await http.get(Config.getCoffeeProductsAPI);
        final res = json.decode(response.body)['Value'];
        return res;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future isHasCoffeeProduct() async {
    try {
      final response = await http.get(Config.isHaveCoffeeProductsAPI);
      final res = json.decode(response.body)['Value'];
      return res;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getDataAllProduct(int i) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token");
      switch (i) {
        case 0:
          {
            if (token != null) {
              final response = await http.get(
                  Config.getDataHomeCartAPI + "?IsDesc=true",
                  headers: {'Token': token});
              final res = json.decode(response.body)['Value'];
              return res;
            }

            final response =
                await http.get(Config.getDataHomeCartAPI + "?IsDesc=true");
            final res = json.decode(response.body)['Value'];
            return res;
          }
        case 1:
          {
            if (token != null) {
              final response = await http.get(Config.getAllDrinkingProductsAPI,
                  headers: {'Token': token});
              final res = json.decode(response.body)['Value'];
              return res;
            }
            final response = await http.get(Config.getAllDrinkingProductsAPI);
            final res = json.decode(response.body)['Value'];
            return res;
          }
        case 2:
          {
            if (token != null) {
              final response = await http.get(Config.getAllCoffeeProductsAPI,
                  headers: {'Token': token});
              final res = json.decode(response.body)['Value'];
              return res;
            }
            final response = await http.get(Config.getAllCoffeeProductsAPI);
            final res = json.decode(response.body)['Value'];
            return res;
          }
        case 3:
          {
            if (token != null) {
              final response = await http
                  .get(Config.getAllFoodProductsAPI, headers: {'Token': token});
              final res = json.decode(response.body)['Value'];
              return res;
            }
            final response = await http.get(Config.getAllFoodProductsAPI);
            final res = json.decode(response.body)['Value'];
            return res;
          }
        case 4:
          {
            if (token != null) {
              final response = await http
                  .get(Config.getAllTeaProductsAPI, headers: {'Token': token});
              final res = json.decode(response.body)['Value'];
              return res;
            }
            final response = await http.get(Config.getAllTeaProductsAPI);
            final res = json.decode(response.body)['Value'];
            return res;
          }
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getDrinkingProducts() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token");
      if (token != null) {
        final response = await http
            .get(Config.getDrinkingProductsAPI, headers: {'Token': token});
        final res = json.decode(response.body)['Value'];
        return res;
      } else {
        final response = await http.get(Config.getDrinkingProductsAPI);
        final res = json.decode(response.body)['Value'];
        return res;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future isHaveDrinkingProducts() async {
    try {
      final response = await http.get(Config.isHaveDrinkingProductsAPI);
      final res = json.decode(response.body)['Value'];
      return res;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getFavoriteProduct() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token");
      Response response =
          await get(Config.getDataHomeCartAPI, headers: {'Token': token});
      var res = json.decode(response.body)['Value'];
      return res;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<int> getFeeShip(double lat, double lng) async {
    Map dataOrder = {"OrdersData": listOrderProducts, "Lat": lat, "Long": lng};
    var dataOrderFinal = json.encode(dataOrder);
    Response response = await post(Config.getFeeShip,
        headers: {'Content-Type': 'application/json'}, body: dataOrderFinal);
    var data = json.decode(response.body);
    if (data['Status'] == 1) {
      return data['Value'];
    }
    return 0;
  }

  Future getFoodProducts() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token");
      if (token != null) {
        final response = await http
            .get(Config.getFoodProductsAPI, headers: {'Token': token});
        final res = json.decode(response.body)['Value'];
        return res;
      } else {
        final response = await http.get(Config.getFoodProductsAPI);
        final res = json.decode(response.body)['Value'];
        return res;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future isHaveFoodProducts() async {
    try {
      final response = await http.get(Config.isHaveFoodProductsAPI);
      final res = json.decode(response.body)['Value'];
      return res;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token');
      int idUser = prefs.getInt('idUser');
      final response = await http.get(
        Config.getHistoryAPI + idUser.toString(),
        headers: {'Token': token.toString()},
      );
      final res = json.decode(response.body)['Value'];
      return res;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getNewProducts() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token");
      if (token != null) {
        final response =
            await http.get(Config.getNewProductsAPI, headers: {'Token': token});
        final res = json.decode(response.body)['Value'];
        return res;
      } else {
        final response = await http.get(Config.getNewProductsAPI);
        final res = json.decode(response.body)['Value'];
        return res;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<GetPlaceItem>> searchPlace(String keyword) async {
    var res = await http
        .get(Config.searchPlaceApi + Uri.encodeQueryComponent(keyword));
    if (res.statusCode == 200) {
      return GetPlaceItem.fromJson(json.decode(res.body));
    } else {
      return new List();
    }
  }

  Future getTeaProducts() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token");
      if (token != null) {
        final response =
            await http.get(Config.getTeaProductsAPI, headers: {'Token': token});
        final res = json.decode(response.body)['Value'];
        return res;
      } else {
        final response = await http.get(Config.getTeaProductsAPI);
        final res = json.decode(response.body)['Value'];
        return res;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future isHaveTeaProducts() async {
    try {
      final response = await http.get(Config.isHaveTeaProductsAPI);
      final res = json.decode(response.body)['Value'];
      return res;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> gmailAuthCode(String code, int idUser, String idRequest) async {
    bool status = false;
    String idUserString = idUser.toString();
    final gmailAuthJson = {
      "Code_Reset": code,
      "IdCustomer": idUserString,
      "IdRequest": idRequest,
      "Password": idUserString
    };
    Response response = await post(Config.gmailAuthAPI, body: gmailAuthJson)
        .timeout(const Duration(seconds: 4));
    String body = response.body;
    var data = json.decode(body);
    var rest = data['Message'];

    if (rest == "Reset password successfully") {
      status = true;
    }
    if (rest == "Check mail for getting cod") {
      showToast(
        allTranslations.text("code_input_wrong").toString(),
      );
      status = false;
    }
    if (rest == "Data for reset password is wrong") {
      showToast(
        allTranslations.text("code_input_wrong").toString(),
      );
      status = false;
    }
    return status;
  }

  Future<bool> postLogin(String username, String password) async {
    bool status = false;
    final loginJson = {"Username": username, "Password": password};
    Response response = await post(Config.loginApi, body: loginJson);
    String body = response.body;
    var data = json.decode(body);
    if (data['Status'] == 1) {
      status = true;
      var token = data['Value']['Token'];
      var idUser = data['Value']['Id'];
      var point = data['Value']['Point'];
      var fullname = data['Value']['Name'];
      var phoneNumber = data['Value']['Phone'];
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);
      prefs.setInt('idUser', idUser);
      prefs.setInt('points', point);
      prefs.setString('name', fullname);
      prefs.setString('phone', phoneNumber);
      showToast(
        allTranslations.text("login_suc").toString(),
      );
    } else {
      showToast(
        allTranslations.text("login_false").toString(),
      );
      status = false;
    }
    return status;
  }

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

  Future<bool> rateOrder(String idOrder, double startRate, String note) async {
    bool status = false;
    final rateOrder = {
      "IdOrder": idOrder,
      "Star": startRate.toString(),
      "Note": note
    };
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    Response response = await post(Config.rateOrder,
        headers: {'Token': token}, body: rateOrder);
    var data = json.decode(response.body);
    if (data['Status'] == 1) {
      status = true;
    } else {
      status = false;
    }
    return status;
  }

  Future<bool> reSetPassRes(
      String code, int idUser, String idRequest, String pass) async {
    bool status = false;
    String idUserString = idUser.toString();
    final gmailAuthJson = {
      "Code_Reset": code,
      "IdCustomer": idUserString,
      "IdRequest": idRequest,
      "Password": pass
    };
    Response response = await post(Config.gmailAuthAPI, body: gmailAuthJson)
        .timeout(const Duration(seconds: 4));
    String body = response.body;
    var data = json.decode(body);

    if (data['Status'] == 1) {
      status = true;
      final pref = await SharedPreferences.getInstance();
      pref.clear();
      showToast(
        allTranslations.text("reset_pass_suc").toString(),
      );
    } else {
      status = false;
      showToast(
        allTranslations.text("reset_pass_false").toString(),
      );
    }

    return status;
  }

  Future<bool> sendCodeToGmail(String gmail) async {
    bool status = false;
    final gmailJson = {"email": gmail};
    Response response = await post(Config.sendCodeToGmailAPI, body: gmailJson);
    String body = response.body;

    var data = json.decode(body);

    if (data['Status'] == 1) {
      status = true;
      var idRequest = data['Value']['IdRequest'];
      var idUser = data['Value']['IdCustomer'];

      final prefs = await SharedPreferences.getInstance()
          .timeout(const Duration(seconds: 4));
      prefs.setString('idRequest', idRequest);
      prefs.setInt('idUser', idUser);
      showToast(
        allTranslations.text("gmail_auth").toString(),
      );
    } else {
      showToast(
        allTranslations.text("invalid_send_code_to_gmail").toString(),
      );
      status = false;
    }
    return status;
  }

  Future<int> isLove(int idProduct) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokenUser = prefs.getString("token");
    var res;
    final data = {"IdProduct": idProduct.toString()};

    Response response = await post(Config.setLove,
        headers: {
          'Token': tokenUser,
        },
        body: data);
    res = json.decode(response.body);
    if (res['Status'] == 1) {
      return 1;
    } else {
      return 0;
    }
  }

  Future<bool> postSignUp(String name, String pass, String phone, String date,
      String fullname, String gmail) async {
    bool status = false;
    final signUpJson = {
      "Username": name,
      "Password": pass,
      "Phone": phone,
      "Name": fullname,
      "Repassword": pass,
      "Age": date,
      "Email": gmail
    };
    Response response = await post(Config.signupAPI, body: signUpJson);
    String body = response.body;
    var data = json.decode(body);
    if (data['Status'] == 1) {
      status = true;
      showToast(
        allTranslations.text("sign_up_suc").toString(),
      );
    } else {
      showToast(
        allTranslations.text("sign_up_false").toString(),
      );
      status = false;
    }
    return status;
  }
}
