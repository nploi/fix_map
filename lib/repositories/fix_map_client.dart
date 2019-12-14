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

  static Future<Map<String, dynamic>> rateShop(
      {String hash, double rating, int userId}) async {
    final Response response = await Dio().post(
      baseUrl + "/shop/rating",
      data: {
        "user_id": userId,
        "rating": rating,
        "hash": hash,
      },
    );
    return jsonDecode(response.toString());
  }

  static Future<Map<String, dynamic>> addFeedback(
      {String hash, String comment, int userId}) async {
    final Response response = await Dio().post(
      baseUrl + "/feedback/add",
      data: {
        "user_id": userId,
        "comment": comment,
        "hash": hash,
      },
    );
    return jsonDecode(response.toString());
  }

  static Future<ListFeedbackResponse> getListFeedback({String hash}) async {
    final Response response = await Dio().get(
      baseUrl + "/feedback/list-by-hash?hash=$hash",
    );
    return ListFeedbackResponse.fromJson(jsonDecode(response.toString()));
  }
}
