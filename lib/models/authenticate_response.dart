import "user.dart";

class AuthenticateResponse {
  String responseText;
  User user;

  AuthenticateResponse({this.responseText, this.user});

  AuthenticateResponse.fromJson(Map<String, dynamic> json) {
    responseText = json["responseText"];
    user = json["user"] != null ? User.fromJson(json["user"]) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["responseText"] = responseText;
    if (user != null) {
      data["user"] = user.toJson();
    }
    return data;
  }
}
