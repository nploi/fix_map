import "dart:async";
import "package:bloc/bloc.dart";
import "package:fix_map/models/models.dart";
import "package:fix_map/repositories/repostiories.dart";

import "bloc.dart";
import "dart:developer" as developer;

class ShopsBloc extends Bloc<ShopsEvent, ShopsState> {
  final ShopRepository _shopRepository = ShopRepository();
  List<Shop> _shops = [];
  List<Shop> get shops => _shops;

  @override
  ShopsState get initialState => InitialShopsState();

  @override
  Stream<ShopsState> mapEventToState(ShopsEvent event) async* {
    try {
      if (event is ShopsSearchByBoundsEvent) {
        yield* _handleMapFetchShopsEvent(event);
        return;
      }

      if (event is ShopsLoadingEvent) {
        yield ShopsLoadingState();
        return;
      }

      if (event is ShopsDownLoadEvent) {
        yield* _handleShopsDownLoadEvent(event);
        return;
      }

      if (event is ShopsCheckDataEvent) {
        yield* _handleShopsCheckDataEvent(event);
        return;
      }

      if (event is ShopsCanRefreshEvent) {
        yield* _handleShopsCanRefreshEvent(event);
        return;
      }
    } catch (_, stackTrace) {
      developer.log("$_", name: "ShopsBloc", error: _, stackTrace: stackTrace);
      yield state;
    }
  }

  Stream<ShopsState> _handleMapFetchShopsEvent(ShopsSearchByBoundsEvent event) async* {
    yield ShopsLoadingState();
    _shops = await _shopRepository.getShops(event.bounds);
    if (_shops != null && _shops.isNotEmpty) {

    }
    yield ShopsLoadedState(_shops);
  }

  Stream<ShopsState> _handleShopsDownLoadEvent(
      ShopsDownLoadEvent event) async* {
    final shops = await _shopRepository.downloadShops();

    for (int index = 0; index < shops.length; index++) {
      final shop = shops[index];
      await _shopRepository.insertShop(shop);
      final double percent = (((index + 1) / shops.length) * 100).toDouble();
      yield ShopsDataInitState(percent);
    }
    yield ShopsDownloadedState();
  }

  Stream<ShopsState> _handleShopsCheckDataEvent(
      ShopsCheckDataEvent event) async* {
    final shops = await _shopRepository.getAllRecord();
    if (shops.isNotEmpty) {
      yield ShopsDownloadedState();
      return;
    }
    yield ShopsDataNotFoundState();
  }

  Stream<ShopsState> _handleShopsCanRefreshEvent(
      ShopsCanRefreshEvent event) async* {
    yield ShopsCanRefreshState();
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
