class LoginModel {
  int stastus;
  int id;
  String address;
  String name;
  String phone;
  String email;
  String username;
  String password;
  String token;
  String age;
  String error;
  String message;
  LoginModel(
      {this.stastus,
      this.id,
      this.address,
      this.name,
      this.phone,
      this.email,
      this.username,
      this.password,
      this.token,
      this.age,
      this.error,
      this.message});
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
        stastus: json['Status'],
        id: json['Value']['Id'],
        address: json['Value']['Address'],
        name: json['Value']['Name'],
        phone: json['Value']['Phone'],
        email: json['Value']['Email'],
        username: json['Value']['Username'],
        password: json['Value']['Password'],
        token: json['Value']['Token'],
        age: json['Value']['Age'],
        error: json['Error'],
        message: json['Message']);
  }
  Map toMap() {
    var map = new Map<String, dynamic>();
    map['Status'] = stastus;
    map['Value']['Id'] = id;
    map['Value']['Name'] = name;
    map['Value']['Phone'] = phone;
    map['Value']['Email'] = email;
    map['Value']['Username'] = username;
    map['Value']['Password'] = password;
    map['Value']['Token'] = token;
    map['Value']['Age'] = age;
    map['Error'] = error;
    map['Message'] = message;
    return map;
  }
}
