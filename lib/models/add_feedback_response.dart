import "feedback.dart";

class AddFeedbackResponse {
  String responseText;
  FeedbackEntity feedback;

  AddFeedbackResponse({this.responseText, this.feedback});

  AddFeedbackResponse.fromJson(Map<String, dynamic> json) {
    responseText = json["responseText"];
    feedback = json["data"] != null ? FeedbackEntity.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["responseText"] = this.responseText;
    if (this.feedback != null) {
      data["data"] = this.feedback.toJson();
    }
    return data;
  }
}
