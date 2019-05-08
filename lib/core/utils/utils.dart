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

