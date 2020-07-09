class Config {
  static String findFoodAPI = ip + "api/Product/FindProduct?Name=";
  static String ip = "http://207.148.71.41/";
  static bool isLogin = false;
  static String checkPoint = ip + "api/Order/TestPaidByPoint";
  static String loginApi = ip + "api/Customer/Login";
  static String rateOrder = ip + "api/Order/rateOrder";
  static String signupAPI = ip + "api/Customer/SignUp";
  static String sendCodeToGmailAPI = ip + "api/Customer/SendCode_ResetPass";
  static String gmailAuthAPI = ip + "api/Customer/ResetPassword";
  static String getDataHomeCartAPI = ip + "api/Product/GetAll";
  static String getFeeShip = ip + "api/Order/MakeShipment";
  static String setLove = ip + "api/Product/SetLoveProduct";
  static String checkCoupon = ip + "api/Product/CheckCoupon";
  static String getNewProductsAPI =
      ip + "api/Product/GetAll?IsDesc=true&Rows=5";
  static String getHistoryAPI = ip + "api/Order/FindOrderHistory?IdCustomer=";
  static String getCoffeeProductsAPI =
      ip + "api/Product/GetAll?IsDesc=true&Rows=10&IdCatalogue=2";
  static String isHaveCoffeeProductsAPI =
      ip + "api/Product/GetAll?IsDesc=true&Rows=1&IdCatalogue=2";
  static String getAllCoffeeProductsAPI =
      ip + "api/Product/GetAll?IsDesc=true&IdCatalogue=2";

  static String getTeaProductsAPI =
      ip + "api/Product/GetAll?IsDesc=true&Rows=10&IdCatalogue=4";

  static String isHaveTeaProductsAPI =
      ip + "api/Product/GetAll?IsDesc=true&Rows=1&IdCatalogue=4";
  static String getAllTeaProductsAPI =
      ip + "api/Product/GetAll?IsDesc=true&IdCatalogue=4";
  static String getDrinkingProductsAPI =
      ip + "api/Product/GetAll?IsDesc=true&Rows=10&IdCatalogue=1";
  static String isHaveDrinkingProductsAPI =
      ip + "api/Product/GetAll?IsDesc=true&Rows=1&IdCatalogue=1";
  static String getAllDrinkingProductsAPI =
      ip + "api/Product/GetAll?IsDesc=true&IdCatalogue=1";
  static String getFoodProductsAPI =
      ip + "api/Product/GetAll?IsDesc=true&Rows=10&IdCatalogue=3";
  static String isHaveFoodProductsAPI =
      ip + "api/Product/GetAll?IsDesc=true&Rows=1&IdCatalogue=3";
  static String getAllFoodProductsAPI =
      ip + "api/Product/GetAll?IsDesc=true&IdCatalogue=3";
  static String appKey = "AIzaSyDTWbrlyubWnDBeA8xsfemXjDm4XzHGyb0";
  static String searchPlaceApi =
      "https://maps.googleapis.com/maps/api/place/textsearch/json?key=" +
          appKey +
          "&language=vi&region=VN&query=";
  static String orderAPI = ip + "api/Order/OrderOnline";
}
