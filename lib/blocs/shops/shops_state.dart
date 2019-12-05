import 'package:equatable/equatable.dart';
import 'package:fix_map/models/models.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class ShopsState extends Equatable {
  const ShopsState();
  @override
  List<Object> get props => [];
}

class InitialShopsState extends ShopsState {}

class ShopsLoadingState extends ShopsState {}

class ShopsDownloadedState extends ShopsState {
  ShopsDownloadedState();

  List<Object> get props => [];

  @override
  String toString() => 'ShopsDownloadedState {}';
}

class ShopsDataNotFoundState extends ShopsState {
  ShopsDataNotFoundState();

  List<Object> get props => [];

  @override
  String toString() => 'ShopsDataNotFoundState {}';
}

class ShopsDownloadingState extends ShopsState {
  ShopsDownloadingState();

  List<Object> get props => [];

  @override
  String toString() => 'ShopsDownloadingState {}';
}

class ShopsLoadedState extends ShopsState {
  final List<Shop> shops;
  ShopsLoadedState(this.shops);

  List<Object> get props => [shops];

  @override
  String toString() => 'ShopsLoadedState {shops: $shops}';
}

class ShopsCanRefreshState extends ShopsState {
  ShopsCanRefreshState();

  List<Object> get props => [];

  @override
  String toString() => 'ShopsCanRefreshState {}';
}

class ShopsDataInitState extends ShopsState {
  final double percent;
  ShopsDataInitState(this.percent);

  List<Object> get props => [percent];

  @override
  String toString() => 'ShopsDataInitState {percent : $percent}';
}
