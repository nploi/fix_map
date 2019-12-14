import "package:equatable/equatable.dart";
import "package:flutter/foundation.dart";

@immutable
abstract class FeedbackEvent extends Equatable {
  const FeedbackEvent();
  @override
  List<Object> get props => [];
}

class FeedbackGetListFeedbackEvent extends FeedbackEvent {
  final String hash;
  const FeedbackGetListFeedbackEvent(this.hash);

  List<Object> get props => [hash];

  @override
  String toString() => "FeedbackGetListFeedbackEvent {hash: $hash}";
}

class FeedbackAddFeedbackEvent extends FeedbackEvent {
  final String hash;
  final double rating;
  final String comment;
  const FeedbackAddFeedbackEvent(this.hash, this.rating, this.comment);

  List<Object> get props => [this.hash, this.rating, this.comment];

  @override
  String toString() =>
      "FeedbackAddFeedbackEvent {hash: $hash, rating: $rating, comment: $comment}";
}
