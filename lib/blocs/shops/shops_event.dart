import "package:equatable/equatable.dart";
import "package:flutter/foundation.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";

@immutable
abstract class ShopsEvent extends Equatable {
  const ShopsEvent();
  @override
  List<Object> get props => [];
}

class ShopsLoadingEvent extends ShopsEvent {
  const ShopsLoadingEvent();

  List<Object> get props => [];

  @override
  String toString() => "ShopsLoadingEvent {}";
}

class ShopsCheckDataEvent extends ShopsEvent {
  const ShopsCheckDataEvent();

  List<Object> get props => [];

  @override
  String toString() => "ShopsCheckDataEvent {}";
}

class ShopsDownLoadEvent extends ShopsEvent {
  const ShopsDownLoadEvent();

  List<Object> get props => [];

  @override
  String toString() => "ShopsDownLoadEvent {}";
}

class ShopsSearchByBoundsEvent extends ShopsEvent {
  final LatLngBounds bounds;
  const ShopsSearchByBoundsEvent(this.bounds);

  List<Object> get props => [bounds];

  @override
  String toString() => "ShopsSearchByBoundsEvent {bounds: ${bounds.toString()}";
}

class ShopsCanRefreshEvent extends ShopsEvent {
  const ShopsCanRefreshEvent();

  List<Object> get props => [];

  @override
  String toString() => "ShopsCanRefreshEvent {}";
}
