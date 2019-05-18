const LOG_ENABLED = true;

class Dimension {
  static double height = 0.0;
  static double witdh = 0.0;

  static double getWidth(double size) {
    return witdh * size;
  }

  static double getHeight(double size) {
    return height * size;
  }
}

class Utils {
  // Hàm này dùng để thay cho print('')
  static void printLog(String data) {
    if (LOG_ENABLED) {
      print(data);
    }
  }
}

class Map_Object {
  static List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  static List<T> map_home_cart<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < 5; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }
}
