import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fix_map/models/models.dart';
import 'package:fix_map/repositories/repostiories.dart';

import 'bloc.dart';
import 'dart:developer' as developer;

class ShopsBloc extends Bloc<ShopsEvent, ShopsState> {
  final ShopRepository _shopRepository = ShopRepository();
  bool loading = false;
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
    } catch (_, stackTrace) {
      developer.log('$_', name: 'ShopsBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }

  Stream<ShopsState> _handleMapFetchShopsEvent(ShopsSearchEvent event) async* {
    _shops = await _shopRepository.getShops(event.bounds);
    yield ShopsLoadedState(_shops.length);
  }

  Stream<ShopsState> _handleShopsDownLoadEvent(
      ShopsDownLoadEvent event) async* {
    await _shopRepository.downloadShops();
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
}
