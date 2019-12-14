import "feedback.dart";

class ListFeedbackResponse {
  String responseText;
  List<Feedback> listFeedback;

  ListFeedbackResponse({this.responseText, this.listFeedback});

  ListFeedbackResponse.fromJson(Map<String, dynamic> json) {
    responseText = json["responseText"];
    if (json["data"] != null) {
      listFeedback = List<Feedback>();
      json["data"].forEach((v) {
        listFeedback.add(Feedback.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["responseText"] = this.responseText;
    if (this.listFeedback != null) {
      data["data"] = this.listFeedback.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
