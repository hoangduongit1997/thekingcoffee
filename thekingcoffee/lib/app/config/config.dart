class Config {
  static String find_food_API = ip + "api/Product/FindProduct?Name=";
  static String ip = "http://207.148.71.41/";
  static int item_shopping_list=0;
  static String check_point = ip + "api/Order/TestPaidByPoint";
  static String login_Api = ip + "api/Customer/Login";
  static String rate_order = ip + "api/Order/RateOrder";
  static String signup_API = ip + "api/Customer/SignUp";
  static String sendcodetogmail_API = ip + "api/Customer/SendCode_ResetPass";
  static String gmail_auth_API = ip + "api/Customer/ResetPassword";
  static String get_data_home_cart_API = ip + "api/Product/GetAll";
  static String get_fee_ship = ip + "api/Order/MakeShipment";
  static String check_coupon = ip + "api/Product/CheckCoupon";
  static String get_new_products_API =
      ip + "api/Product/GetAll?IsDesc=true&Rows=5";
  static String get_history_API = ip + "api/Order/FindOrderHistory?IdCustomer=";
  static String get_coffee_products_API =
      ip + "api/Product/GetAll?IsDesc=true&Rows=10&IdCatalogue=2";
  static String is_have_coffee_products_API =
      ip + "api/Product/GetAll?IsDesc=true&Rows=1&IdCatalogue=2";
  static String get_all_coffee_products_API =
      ip + "api/Product/GetAll?IsDesc=true&IdCatalogue=2";

  static String get_tea_products_API =
      ip + "api/Product/GetAll?IsDesc=true&Rows=10&IdCatalogue=4";

  static String is_have_tea_products_API =
      ip + "api/Product/GetAll?IsDesc=true&Rows=1&IdCatalogue=4";
  static String get_all_tea_products_API =
      ip + "api/Product/GetAll?IsDesc=true&IdCatalogue=4";
  static String get_drinking_products_API =
      ip + "api/Product/GetAll?IsDesc=true&Rows=10&IdCatalogue=1";
  static String is_have_drinking_products_API =
      ip + "api/Product/GetAll?IsDesc=true&Rows=1&IdCatalogue=1";
  static String get_all_drinking_products_API =
      ip + "api/Product/GetAll?IsDesc=true&IdCatalogue=1";
  static String get_food_products_API =
      ip + "api/Product/GetAll?IsDesc=true&Rows=10&IdCatalogue=3";
  static String is_have_food_products_API =
      ip + "api/Product/GetAll?IsDesc=true&Rows=1&IdCatalogue=3";
  static String get_all_food_products_API =
      ip + "api/Product/GetAll?IsDesc=true&IdCatalogue=3";
  static String app_key = "AIzaSyDTWbrlyubWnDBeA8xsfemXjDm4XzHGyb0";
  static String search_place_Api =
      "https://maps.googleapis.com/maps/api/place/textsearch/json?key=" +
          app_key +
          "&language=vi&region=VN&query=";
  static String order_API = ip + "api/Order/OrderOnline";
}
