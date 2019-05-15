class Size_Product{
  String flusmoney;
  String id;
  String name;
  Size_Product(this.flusmoney,this.id,this.name);
   static List<Size_Product> fromJson(Map<String, dynamic> json) {
    List<Size_Product> rs = new List();

    var results = json['results'] as List;
    for (var item in results) {
      var p = new Size_Product(
          item['PlusMonney'].toString(),
          item['Id'].toString(),
          item['Name'].toString(),
          );

      rs.add(p);
    }

    return rs;
  }
}