import "package:equatable/equatable.dart";
import "package:fix_map/models/models.dart";
import "package:flutter/foundation.dart";

@immutable
abstract class FeedbackState extends Equatable {
  const FeedbackState();
  @override
  List<Object> get props => [];
}

class InitialFeedbackState extends FeedbackState {}

class FeedbackLoadingState extends FeedbackState {}

class FeedbackFoundState extends FeedbackState {
  final Shop shop;
  const FeedbackFoundState(this.shop);

  List<Object> get props => [shop];

  @override
  String toString() => "FeedbackLoadedState {shops: $shop}";
}

class FeedbackNotFoundState extends FeedbackState {
  const FeedbackNotFoundState();

  List<Object> get props => [];

  @override
  String toString() => "FeedbackNotFoundState {}";
}

class FeedbackErrorState extends FeedbackState {
  final String message;
  const FeedbackErrorState(this.message);

  List<Object> get props => [message];

  @override
  String toString() => "FeedbackErrorState {message: $message}";
}

class FeedbackLoadedListFeedbackState extends FeedbackState {
  final List<Feedback> listFeedback;
  const FeedbackLoadedListFeedbackState(this.listFeedback);

  List<Object> get props => [listFeedback];

  @override
  String toString() =>
      "FeedbackLoadedListFeedbackState {listFeedback: $listFeedback}";
}

class FeedbackAddedFeedbackState extends FeedbackState {
  final String hash;
  final double rating;
  final String comment;
  const FeedbackAddedFeedbackState(this.hash, this.rating, this.comment);

  List<Object> get props => [this.hash, this.rating, this.comment];

  @override
  String toString() =>
      "FeedbackAddFeedbackState {hash: $hash, rating: $rating, comment: $comment}";
}
