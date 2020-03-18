class Home_Slider {
  final String image;
  final String title;
  final double star;
  final int point;
  final String name;
  final String avatar;

  Home_Slider(
      {this.image, this.title, this.star, this.point, this.name, this.avatar});
  String get images => image;
  String get titles => title;
  double get stars => star;
  int get points => point;
  String get names => name;
  String get avatars => avatar;
}
