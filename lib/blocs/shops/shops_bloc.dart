import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fix_map/models/models.dart';
import 'package:fix_map/repositories/repostiories.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';
import 'dart:developer' as developer;

class ShopsBloc extends Bloc<ShopsEvent, ShopsState> {
  final ShopRepository _shopRepository = ShopRepository();
  // ignore: close_sinks
  final _downloadListener = BehaviorSubject<double>();

  bool loading = false;
  List<Shop> _shops = [];
  List<Shop> get shops => this._shops;
  BehaviorSubject<double> get downloadListener => this._downloadListener;
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
    _shops = await _shopRepository.getShops(event.bounds);
    yield ShopsLoadedState(_shops.length);
  }

  Stream<ShopsState> _handleShopsDownLoadEvent(
      ShopsDownLoadEvent event) async* {
    await _shopRepository.downloadShops((percent) {
      downloadListener.add(percent);
    });
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
    downloadListener.close();
    return super.close();
  }
}
