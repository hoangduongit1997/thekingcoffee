import 'package:thekingcoffee/src/app/services/api.dart';

String domainAPI = "http://207.148.71.41/";
String findFoodAPI = domainAPI + "api/Product/FindProduct?Name=";
bool isLogin = false;
String checkPoint = domainAPI + "api/Order/TestPaidByPoint";
String loginApi = domainAPI + "api/Customer/Login";
String rateOrder = domainAPI + "api/Order/rateOrder";
String signupAPI = domainAPI + "api/Customer/SignUp";
String sendCodeToGmailAPI = domainAPI + "api/Customer/SendCode_ResetPass";
String gmailAuthAPI = domainAPI + "api/Customer/ResetPassword";
String getDataHomeCartAPI = domainAPI + "api/Product/GetAll";
String getFeeShdomainAPI = domainAPI + "api/Order/MakeShdomainAPIment";
String setLove = domainAPI + "api/Product/SetLoveProduct";
String checkCoupon = domainAPI + "api/Product/CheckCoupon";
String getNewProductsAPI = domainAPI + "api/Product/GetAll?IsDesc=true&Rows=5";
String getHistoryAPI = domainAPI + "api/Order/FindOrderHistory?IdCustomer=";
String getCoffeeProductsAPI =
    domainAPI + "api/Product/GetAll?IsDesc=true&Rows=10&IdCatalogue=2";
String isHaveCoffeeProductsAPI =
    domainAPI + "api/Product/GetAll?IsDesc=true&Rows=1&IdCatalogue=2";
String getAllCoffeeProductsAPI =
    domainAPI + "api/Product/GetAll?IsDesc=true&IdCatalogue=2";
String getTeaProductsAPI =
    domainAPI + "api/Product/GetAll?IsDesc=true&Rows=10&IdCatalogue=4";
String isHaveTeaProductsAPI =
    domainAPI + "api/Product/GetAll?IsDesc=true&Rows=1&IdCatalogue=4";
String getAllTeaProductsAPI =
    domainAPI + "api/Product/GetAll?IsDesc=true&IdCatalogue=4";
String getDrinkingProductsAPI =
    domainAPI + "api/Product/GetAll?IsDesc=true&Rows=10&IdCatalogue=1";
String isHaveDrinkingProductsAPI =
    domainAPI + "api/Product/GetAll?IsDesc=true&Rows=1&IdCatalogue=1";
String getAllDrinkingProductsAPI =
    domainAPI + "api/Product/GetAll?IsDesc=true&IdCatalogue=1";
String getFoodProductsAPI =
    domainAPI + "api/Product/GetAll?IsDesc=true&Rows=10&IdCatalogue=3";
String isHaveFoodProductsAPI =
    domainAPI + "api/Product/GetAll?IsDesc=true&Rows=1&IdCatalogue=3";
String getAllFoodProductsAPI =
    domainAPI + "api/Product/GetAll?IsDesc=true&IdCatalogue=3";
String appKey = "AIzaSyDTWbrlyubWnDBeA8xsfemXjDm4XzHGyb0";
String searchPlaceApi =
    "https://maps.googleapis.com/maps/api/place/textsearch/json?key=" +
        appKey +
        "&language=vi&region=VN&query=";
String orderAPI = domainAPI + "api/Order/OrderOnline";
Api api = new Api();
