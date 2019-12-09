import "package:fix_map/models/models.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group("User", () {
    final json = {
      "id": 1,
      "fullname": "Loi hai",
      "password": "asdf",
      "email": "nploi1998@gmail.com",
      "avatar": "1234.png",
      "phone": "8412345678"
    };

    test("toJson", () {
      final User user = User(
          id: 1,
          fullName: "Loi hai",
          password: "asdf",
          email: "nploi1998@gmail.com",
          avatar: "1234.png",
          phone: "8412345678");

      expect(user.toJson(), json);
    });

    test("fromJson", () {
      final User user = User.fromJson(json);
      expect(user.toJson(), json);
    });
  });
}
