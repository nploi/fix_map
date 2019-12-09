import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fix_map/models/models.dart';

class FixMapClient {
  static const baseUrl = 'http://fixmap.documents.asia:5005';

  static Future<FixMapResponse> getAllShop() async {
    Response response = await Dio().get(baseUrl + "/shop/list-all");

    FixMapResponse fixMapResponse =
        FixMapResponse.fromJson(jsonDecode(response.toString()));

    return fixMapResponse;
  }

  static Future<Shop> getShop(String hash) async {}

  static Future<AuthenticateResponse> signIn(
      {String email, String password, String accessToken}) async {
    Response response = await Dio().post(
      baseUrl + "/user/sign-in",
      data: {
        "email": email,
        "password": password,
        "accessToken": accessToken,
      },
    );

    AuthenticateResponse authenticateResponse =
        AuthenticateResponse.fromJson(jsonDecode(response.toString()));
    return authenticateResponse;
  }

  static Future<AuthenticateResponse> signUp({User user}) async {
    Response response = await Dio().post(
      baseUrl + "/user/sign-up",
      data: {
        "email": user.email,
        "fullname": user.fullName,
        "password": user.password,
        "repassword": user.password,
        "accessToken": "",
      },
    );
    AuthenticateResponse authenticateResponse =
        AuthenticateResponse.fromJson(jsonDecode(response.toString()));
    return authenticateResponse;
  }
}
