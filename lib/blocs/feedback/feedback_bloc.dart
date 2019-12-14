import "dart:async";
import "package:bloc/bloc.dart";
import "package:fix_map/repositories/repostiories.dart";

import "bloc.dart";
import "dart:developer" as developer;

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  final FeedbackRepository _feedbackRepository = FeedbackRepository();
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  @override
  FeedbackState get initialState => InitialFeedbackState();

  @override
  Stream<FeedbackState> mapEventToState(FeedbackEvent event) async* {
    try {
      if (event is FeedbackAddFeedbackEvent) {
        yield* _handleFeedbackAddFeedbackEvent(event);
        return;
      }
      if (event is FeedbackGetListFeedbackEvent) {
        yield* _handleFeedbackGetListFeedbackEvent(event);
        return;
      }
    } catch (_, stackTrace) {
      developer.log("$_",
          name: "FeedbackState", error: _, stackTrace: stackTrace);
      yield state;
    }
  }

  Stream<FeedbackState> _handleFeedbackAddFeedbackEvent(
      FeedbackAddFeedbackEvent event) async* {
    yield FeedbackLoadingState();
    try {
      final user = await _authenticationRepository.getUser();
      await _feedbackRepository.feedbackShop(
          hash: event.hash, userId: user.id, comment: event.comment);
      await _feedbackRepository.rateShop(
          hash: event.hash, userId: user.id, rating: event.rating);
      yield FeedbackAddedFeedbackState(event.hash, event.rating, event.comment);
    } catch (exception) {
      yield FeedbackErrorState(exception.message);
    }
  }

  Stream<FeedbackState> _handleFeedbackGetListFeedbackEvent(
      FeedbackGetListFeedbackEvent event) async* {
    yield FeedbackLoadingState();
    try {
      final listFeedback =
          await _feedbackRepository.getListFeedback(event.hash);
      yield FeedbackLoadedListFeedbackState(listFeedback);
    } catch (exception) {
      yield FeedbackErrorState(exception.message);
    }
  }
}
