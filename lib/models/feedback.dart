class FeedbackEntity {
  int id;
  int userId;
  String userFullName;
  String shopHash;
  String comment;
  double rating;
  String updatedAt;
  String createdAt;

  FeedbackEntity(
      {this.id,
      this.userId,
      this.userFullName,
      this.rating,
      this.shopHash,
      this.comment,
      this.updatedAt,
      this.createdAt});

  FeedbackEntity.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    userId = json["user_id"];
    userFullName = json["user_fullname"];
    rating = (json["rating"] as int).toDouble();
    shopHash = json["shop_hash"];
    comment = json["comment"];
    updatedAt = json["updatedAt"];
    createdAt = json["createdAt"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = this.id;
    data["user_id"] = this.userId;
    data["user_fullname"] = this.userFullName;
    data["rating"] = this.rating;
    data["shop_hash"] = this.shopHash;
    data["comment"] = this.comment;
    data["updatedAt"] = this.updatedAt;
    data["createdAt"] = this.createdAt;
    return data;
  }
}
