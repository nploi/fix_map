import "dart:convert";

import "package:dio/dio.dart";
import "package:fix_map/models/models.dart";

class FixMapClient {
  static const baseUrl = "http://fixmap.documents.asia:5005";

  static Future<FixMapResponse> getAllShop() async {
    final Response response = await Dio().get(baseUrl + "/shop/list-all");

    final FixMapResponse fixMapResponse =
        FixMapResponse.fromJson(jsonDecode(response.toString()));

    return fixMapResponse;
  }

  static Future<Shop> getShop(String hash) async {
    return null;
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

    final AuthenticateResponse authenticateResponse =
        AuthenticateResponse.fromJson(jsonDecode(response.toString()));
    return authenticateResponse;
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
    final AuthenticateResponse authenticateResponse =
        AuthenticateResponse.fromJson(jsonDecode(response.toString()));
    return authenticateResponse;
  }
}
