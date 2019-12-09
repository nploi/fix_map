class User {
  int id;
  String email;
  String password;
  String avatar;
  String fullName;
  String phone;

  User(
      {this.id,
      this.email,
      this.password,
      this.avatar,
      this.fullName,
      this.phone});

  User.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    email = json["email"];
    password = json["password"];
    avatar = json["avatar"];
    fullName = json["fullname"];
    phone = json["phone"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = this.id;
    data["email"] = this.email;
    data["password"] = this.password;
    data["avatar"] = this.avatar;
    data["fullname"] = this.fullName;
    data["phone"] = this.phone;
    return data;
  }
}
