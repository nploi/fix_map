import 'user.dart';

class AuthenticateResponse {
  String responseText;
  User user;

  AuthenticateResponse({this.responseText, this.user});

  AuthenticateResponse.fromJson(Map<String, dynamic> json) {
    responseText = json['responseText'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responseText'] = this.responseText;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}
