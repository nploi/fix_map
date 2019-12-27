import "package:fix_map/models/feedback.dart";
import "package:fix_map/models/models.dart";
import "package:fix_map/repositories/fix_map_client.dart";
import "package:fix_map/repositories/repostiories.dart";

class FeedbackRepository extends SharedPreferencesRepository {
  Future<String> rateShop({String hash, double rating, int userId}) async {
    final response =
        await FixMapClient.rateShop(hash: hash, userId: userId, rating: rating);

    if (response["responseText"] != "Successfully") {
      throw Exception(response["responseText"]);
    }
    return response["responseText"];
  }

  Future<String> feedbackShop({String hash, String comment, int userId}) async {
    final response = await FixMapClient.addFeedback(
        hash: hash, userId: userId, comment: comment);
    if (response["responseText"] != "Successfully") {
      throw Exception(response["responseText"]);
    }
    return response["responseText"];
  }

  Future<List<FeedbackEntity>> getListFeedback(String hash) async {
    final response = await FixMapClient.getListFeedback(hash: hash);
    if (response.responseText != "Successfully") {
      throw Exception("Opps, has error!");
    }
    return response.listFeedback;
  }
}
