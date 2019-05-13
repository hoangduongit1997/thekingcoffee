class Get_Place_Item {
  String name;
  String address;
  double lat;
  double lng;
  Get_Place_Item(this.name, this.address, this.lat, this.lng);

  static List<Get_Place_Item> fromJson(Map<String, dynamic> json) {
    List<Get_Place_Item> rs = new List();

    var results = json['results'] as List;
    for (var item in results) {
      var p = new Get_Place_Item(
          item['name'],
          item['formatted_address'],
          item['geometry']['location']['lat'],
          item['geometry']['location']['lng']);

      rs.add(p);
    }

    return rs;
  }
}
