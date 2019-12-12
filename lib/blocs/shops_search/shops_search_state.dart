import "package:equatable/equatable.dart";
import "package:fix_map/models/models.dart";
import "package:flutter/foundation.dart";

@immutable
abstract class ShopsSearchState extends Equatable {
  const ShopsSearchState();
  @override
  List<Object> get props => [];
}

class InitialShopsSearchState extends ShopsSearchState {}

class ShopsSearchLoadingState extends ShopsSearchState {}

class ShopsSearchLoadedState extends ShopsSearchState {
  final List<Shop> shops;
  final int size;
  const ShopsSearchLoadedState(this.shops, this.size);

  List<Object> get props => [shops, size];

  @override
  String toString() => "ShopsSearchLoadedState {shops: $shops, size: $size}";
}

