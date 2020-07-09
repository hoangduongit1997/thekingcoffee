class GetPlaceItem {
  String name;
  String address;
  double lat;
  double lng;
  GetPlaceItem(this.name, this.address, this.lat, this.lng);

  static List<GetPlaceItem> fromJson(Map<String, dynamic> json) {
    List<GetPlaceItem> rs = new List();

    var results = json['results'] as List;
    for (var item in results) {
      var p = new GetPlaceItem(
          item['name'],
          item['formatted_address'],
          item['geometry']['location']['lat'],
          item['geometry']['location']['lng']);

      rs.add(p);
    }

    return rs;
  }
}
