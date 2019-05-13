class Config {
  static String ip = "http://207.148.71.41/";
  static String login_Api = ip + "api/Customer/Login";
  static String signup_API = ip + "api/Customer/SignUp";
  static String sendcodetogmail_API = ip + "api/Customer/SendCode_ResetPass";
  static String gmail_auth_API = ip + "api/Customer/ResetPassword";
  static String get_data_home_cart_API = ip + "api/Product/GetAll";
  static String app_key="AIzaSyDTWbrlyubWnDBeA8xsfemXjDm4XzHGyb0";
  static String search_place_Api="https://maps.googleapis.com/maps/api/place/textsearch/json?key="+app_key+"&language=vi&region=VN&query=";
}
