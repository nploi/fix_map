import "package:fix_map/models/models.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group("Feedback", () {
    final json = {
      "id": 1,
      "user_id": 1,
      "user_fullname": "Lợi Hại",
      "comment": "Great",
      "rating": 4,
      "shop_hash": "1234567",
      "updatedAt": null,
      "createdAt": null
    };

    test("toJson", () {
      final FeedbackEntity feedback = FeedbackEntity(
        id: 1,
        userId: 1,
        userFullName: "Lợi Hại",
        comment: "Great",
        rating: 4,
        shopHash: "1234567",
      );
      expect(feedback.toJson(), json);
    });

    test("fromJson", () {
      final FeedbackEntity feedback = FeedbackEntity.fromJson(json);
      expect(feedback.toJson(), json);
    });
  });
}
