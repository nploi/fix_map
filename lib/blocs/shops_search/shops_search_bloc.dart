import "dart:async";
import "package:bloc/bloc.dart";
import "package:fix_map/models/models.dart";
import "package:fix_map/repositories/repostiories.dart";

import "bloc.dart";
import "dart:developer" as developer;

class ShopsSearchBloc extends Bloc<ShopsSearchEvent, ShopsSearchState> {
  final ShopRepository _shopRepository = ShopRepository();
  List<Shop> _shops = [];
  List<Shop> get shop => _shops;
  int _limit = 20;
  int _offset = 0;

  @override
  ShopsSearchState get initialState => InitialShopsSearchState();

  @override
  Stream<ShopsSearchState> mapEventToState(ShopsSearchEvent event) async* {
    try {
      if (event is ShopsSearchByQueryEvent) {
        yield* _handleShopsSearchByQueryEvent(event);
        return;
      }

      if (event is ShopsSearchNextOffsetEvent) {
        yield* _handleShopsSearchNextOffsetEvent(event);
        return;
      }

      if (event is ShopsSearchNextOffsetEvent) {
        yield* _handleShopsSearchNextOffsetEvent(event);
        return;
      }
    } catch (_, stackTrace) {
      developer.log("$_",
          name: "ShopsSearchBloc", error: _, stackTrace: stackTrace);
      yield state;
    }
  }

  Stream<ShopsSearchState> _handleShopsSearchByQueryEvent(
      ShopsSearchByQueryEvent event) async* {
    yield ShopsSearchLoadingState();
    _limit = 20;
    _offset = 0;
    _shops = await _shopRepository.getAllShops(
        query: event.query, limit: _limit, offset: _offset);
    yield ShopsSearchLoadedState(_shops, _shops.length, event.query);
  }

  Stream<ShopsSearchState> _handleShopsSearchNextOffsetEvent(
      ShopsSearchNextOffsetEvent event) async* {
    _offset += _limit;
    final shops = await _shopRepository.getAllShops(
        query: event.query, limit: _limit, offset: _offset);
    _shops.addAll(shops);
    yield ShopsSearchLoadedState(_shops, _shops.length, event.query);
  }
}
