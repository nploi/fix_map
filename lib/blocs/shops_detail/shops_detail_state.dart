import 'package:equatable/equatable.dart';
import 'package:fix_map/models/models.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class ShopsDetailState extends Equatable {
  const ShopsDetailState();
  @override
  List<Object> get props => [];
}

class InitialShopsDetailState extends ShopsDetailState {}

class ShopsDetailLoadingState extends ShopsDetailState {}

class ShopsDetailLoadedState extends ShopsDetailState {
  final List<Shop> shops;
  final int size;
  ShopsDetailLoadedState(this.shops, this.size);

  List<Object> get props => [shops, size];

  @override
  String toString() => 'ShopsDetailLoadedState {shops: $shops, size: $size}';
}
