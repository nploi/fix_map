import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

@immutable
abstract class ShopsEvent extends Equatable {
  const ShopsEvent();
  @override
  List<Object> get props => [];
}

class ShopsLoadingEvent extends ShopsEvent {
  ShopsLoadingEvent();

  List<Object> get props => [];

  @override
  String toString() => 'ShopsLoadingEvent {}';
}

class ShopsCheckDataEvent extends ShopsEvent {
  ShopsCheckDataEvent();

  List<Object> get props => [];

  @override
  String toString() => 'ShopsCheckDataEvent {}';
}

class ShopsDownLoadEvent extends ShopsEvent {
  ShopsDownLoadEvent();

  List<Object> get props => [];

  @override
  String toString() => 'ShopsDownLoadEvent {}';
}

class ShopsSearchEvent extends ShopsEvent {
  final LatLngBounds bounds;
  ShopsSearchEvent(this.bounds);

  List<Object> get props => [this.bounds];

  @override
  String toString() => 'ShopsSearchEvent {bounds: ${bounds.toString()}';
}

class ShopsSearchByKeywordEvent extends ShopsEvent {
  final String keyword;
  final int offset;
  final int limit;
  ShopsSearchByKeywordEvent(this.keyword, this.offset, this.limit);

  List<Object> get props => [this.keyword, this.offset, this.limit];

  @override
  String toString() =>
      'ShopsSearchByKeywordEvent {keyword: $keyword, offset: $offset, limit: $limit}';
}

class ShopsSearchByKeywordNextOffsetEvent extends ShopsEvent {
  final String keyword;
  final int offset;
  final int limit;
  ShopsSearchByKeywordNextOffsetEvent(this.keyword, this.offset, this.limit);

  List<Object> get props => [this.keyword, this.offset, this.limit];

  @override
  String toString() =>
      'ShopsSearchByKeywordNextOffsetEvent {keyword: $keyword, offset: $offset, limit: $limit}';
}

class ShopsCanRefreshEvent extends ShopsEvent {
  ShopsCanRefreshEvent();

  List<Object> get props => [];

  @override
  String toString() => 'ShopsCanRefreshEvent {}';
}
