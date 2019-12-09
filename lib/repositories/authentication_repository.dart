import "dart:convert";

import "package:fix_map/models/models.dart";
import "package:fix_map/repositories/fix_map_client.dart";

import "shared_preferences_repository.dart";

class AuthenticationRepository extends SharedPreferencesRepository {
  Future<User> getUser() async {
    await this.boot();
    final userJson = this.get(SharedPreferencesRepository.USER);
    if (userJson != null) {
      return User.fromJson(jsonDecode(userJson));
    }
    return User();
  }

  Future setUser(User user) async {
    await this.boot();
    return await this
        .set(SharedPreferencesRepository.USER, jsonEncode(user.toJson()));
  }

  Future removeUser() async {
    await this.boot();
    return await this.set(SharedPreferencesRepository.USER, null);
  }

  Future<User> signIn(
      {String email, String password, String accessToken}) async {
    final response = await FixMapClient.signIn(
        email: email, password: password, accessToken: accessToken);
    if (response.responseText.toLowerCase() != "successfully") {
      throw Exception(response.responseText);
    }
    return response.user;
  }

  Future<User> signUp({User user}) async {
    final response = await FixMapClient.signUp(user: user);
    if (response.responseText.toLowerCase() != "successfully") {
      throw Exception(response.responseText);
    }
    return response.user;
  }
}
