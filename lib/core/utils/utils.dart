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

class MapObject {
  static List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  static List<T> mapHomeCart<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < 5; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  static List<T> mapPromotionSlider<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }
}
