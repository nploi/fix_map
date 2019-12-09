import "shop.dart";

class FixMapResponse {
  String responseText;
  int count;
  List<Shop> shops;

  FixMapResponse({this.responseText, this.count, this.shops});

  FixMapResponse.fromJson(Map<String, dynamic> json) {
    responseText = json["responseText"];
    count = json["count"];
    if (json["data"] != null) {
      shops = List<Shop>();
      json["data"].forEach((v) {
        shops.add(Shop.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> shops = Map<String, dynamic>();
    shops["responseText"] = this.responseText;
    shops["count"] = this.count;
    if (this.shops != null) {
      shops["shops"] = this.shops.map((v) => v.toJson()).toList();
    }
    return shops;
  }
}
