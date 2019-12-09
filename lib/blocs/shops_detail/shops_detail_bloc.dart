import "dart:async";
import "package:bloc/bloc.dart";

import "bloc.dart";
import "dart:developer" as developer;

class ShopsDetailBloc extends Bloc<ShopsDetailEvent, ShopsDetailState> {


  @override
  ShopsDetailState get initialState => InitialShopsDetailState();

  @override
  Stream<ShopsDetailState> mapEventToState(ShopsDetailEvent event) async* {
    try {
    } catch (_, stackTrace) {
      developer.log("$_", name: "ShopsDetailState", error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
