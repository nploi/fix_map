import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fix_map/models/models.dart';
import 'package:fix_map/repositories/repostiories.dart';

import 'bloc.dart';
import 'dart:developer' as developer;

class ShopsBloc extends Bloc<ShopsEvent, ShopsState> {
  final ShopRepository _shopRepository = ShopRepository();
  List<Shop> _shops = [];
  List<Shop> get shops => this._shops;

  @override
  ShopsState get initialState => InitialShopsState();

  @override
  Stream<ShopsState> mapEventToState(ShopsEvent event) async* {
    try {
      if (event is ShopsSearchEvent) {
        yield* _handleMapFetchShopsEvent(event);
        return;
      }

      if (event is ShopsSearchByKeywordEvent) {
        yield* _handleShopsSearchByKeywordEvent(event);
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
      developer.log('$_', name: 'ShopsBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }

  Stream<ShopsState> _handleMapFetchShopsEvent(ShopsSearchEvent event) async* {
    yield ShopsLoadingState();
    _shops = await _shopRepository.getShops(event.bounds);
    yield ShopsLoadedState(_shops.length);
  }

  Stream<ShopsState> _handleShopsSearchByKeywordEvent(ShopsSearchByKeywordEvent event) async* {
    yield ShopsLoadingState();
    _shops = await _shopRepository.getAllShops(query: event.keyword);
    yield ShopsLoadedState(_shops.length);
  }

  Stream<ShopsState> _handleShopsDownLoadEvent(
      ShopsDownLoadEvent event) async* {
    var shops = await _shopRepository.downloadShops();

    for (int index = 0; index < shops.length; index++) {
      var shop = shops[index];
      await _shopRepository.insertShop(shop);
      double percent = (((index + 1) / shops.length) * 100).toDouble();
      yield ShopsDataInitState(percent);
    }
    yield ShopsDownloadedState();
  }

  Stream<ShopsState> _handleShopsCheckDataEvent(
      ShopsCheckDataEvent event) async* {
    var shops = await _shopRepository.getAllRecord();
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
