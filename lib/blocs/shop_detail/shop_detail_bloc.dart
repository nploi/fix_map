import "dart:async";
import "package:bloc/bloc.dart";
import "package:fix_map/repositories/repostiories.dart";

import "bloc.dart";
import "dart:developer" as developer;

class ShopDetailBloc extends Bloc<ShopDetailEvent, ShopDetailState> {
  final ShopRepository _shopRepository = ShopRepository();

  @override
  ShopDetailState get initialState => InitialShopDetailState();

  @override
  Stream<ShopDetailState> mapEventToState(ShopDetailEvent event) async* {
    try {
      if (event is ShopDetailByHashEvent) {
        yield* _handleShopDetailByHashEvent(event);
        return;
      }
    } catch (_, stackTrace) {
      developer.log("$_",
          name: "ShopDetailState", error: _, stackTrace: stackTrace);
      yield state;
    }
  }

  Stream<ShopDetailState> _handleShopDetailByHashEvent(
      ShopDetailByHashEvent event) async* {
    yield ShopDetailLoadingState();
    try {
      final shop = await _shopRepository.getShopBy(event.hash);
      yield ShopDetailFoundState(shop);
    } catch (exception) {
      yield ShopDetailNotFoundState();
    }
  }
}
