import "dart:convert";

import "package:dio/dio.dart";
import "package:fix_map/models/models.dart";

class FixMapClient {
  static const baseUrl = "http://45.77.245.125:8001";

  static Future<FixMapResponse> getAllShop() async {
    final Response response = await Dio().get(baseUrl + "/shop/list-all");
    return FixMapResponse.fromJson(jsonDecode(response.toString()));
  }

  static Future<ShopResponse> getShop(String hash) async {
    final Response response =
        await Dio().get(baseUrl + "/shop/list-by-hash?hash=$hash");
    return ShopResponse.fromJson(jsonDecode(response.toString()));
  }

  static Future<AuthenticateResponse> signIn(
      {String email, String password, String accessToken}) async {
    final Response response = await Dio().post(
      baseUrl + "/user/sign-in",
      data: {
        "email": email,
        "password": password,
        "accessToken": accessToken,
      },
    );

    return AuthenticateResponse.fromJson(jsonDecode(response.toString()));
  }

  static Future<AuthenticateResponse> signUp({User user}) async {
    final Response response = await Dio().post(
      baseUrl + "/user/sign-up",
      data: {
        "email": user.email,
        "fullname": user.fullName,
        "password": user.password,
        "repassword": user.password,
        "accessToken": "",
      },
    );
    return AuthenticateResponse.fromJson(jsonDecode(response.toString()));
  }


}
