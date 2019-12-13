import "shop.dart";

class ShopResponse {
  String responseText;
  Shop shop;

  ShopResponse({this.responseText, this.shop});

  ShopResponse.fromJson(Map<String, dynamic> json) {
    responseText = json["responseText"];
    shop = json["data"] != null ? Shop.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["responseText"] = responseText;
    if (shop != null) {
      data["shop"] = shop.toJson();
    }
    return data;
  }
}
