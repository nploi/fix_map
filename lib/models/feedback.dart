class Feedback {
  int id;
  int userId;
  String shopHash;
  String comment;
  String updatedAt;
  String createdAt;

  Feedback(
      {this.id,
      this.userId,
      this.shopHash,
      this.comment,
      this.updatedAt,
      this.createdAt});

  Feedback.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    userId = json["user_id"];
    shopHash = json["shop_hash"];
    comment = json["comment"];
    updatedAt = json["updatedAt"];
    createdAt = json["createdAt"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = this.id;
    data["user_id"] = this.userId;
    data["shop_hash"] = this.shopHash;
    data["comment"] = this.comment;
    data["updatedAt"] = this.updatedAt;
    data["createdAt"] = this.createdAt;
    return data;
  }
}
