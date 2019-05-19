class Config {
  static int current_botton_tab=0;
  static String ip = "http://207.148.71.41/";
  static String login_Api = ip + "api/Customer/Login";
  static String signup_API = ip + "api/Customer/SignUp";
  static String sendcodetogmail_API = ip + "api/Customer/SendCode_ResetPass";
  static String gmail_auth_API = ip + "api/Customer/ResetPassword";
  static String get_data_home_cart_API = ip + "api/Product/GetAll";
  static String get_new_products_API =
      ip + "api/Product/GetAll?IsDesc=true&Rows=5";
  static String get_coffee_products_API =
      ip + "api/Product/GetAll?IsDesc=true&Rows=10&IdCatalogue=2";
  static String get_tea_products_API =
      ip + "api/Product/GetAll?IsDesc=true&Rows=10&IdCatalogue=4";
  static String get_drinking_products_API =
      ip + "api/Product/GetAll?IsDesc=true&Rows=10&IdCatalogue=1";
  static String get_food_products_API =
      ip + "api/Product/GetAll?IsDesc=true&Rows=10&IdCatalogue=3";
  static String app_key = "AIzaSyDTWbrlyubWnDBeA8xsfemXjDm4XzHGyb0";
  static String search_place_Api =
      "https://maps.googleapis.com/maps/api/place/textsearch/json?key=" +
          app_key +
          "&language=vi&region=VN&query=";
          static String order_API=ip+"api/Order/OrderOnline";
}
