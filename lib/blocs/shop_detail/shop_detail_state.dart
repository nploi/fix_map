import "package:equatable/equatable.dart";
import "package:fix_map/models/models.dart";
import "package:flutter/foundation.dart";

@immutable
abstract class ShopDetailState extends Equatable {
  const ShopDetailState();
  @override
  List<Object> get props => [];
}

class InitialShopDetailState extends ShopDetailState {}

class ShopDetailLoadingState extends ShopDetailState {}

class ShopDetailFoundState extends ShopDetailState {
  final Shop shop;
  const ShopDetailFoundState(this.shop);

  List<Object> get props => [shop];

  @override
  String toString() => "ShopDetailLoadedState {shops: $shop}";
}

class ShopDetailNotFoundState extends ShopDetailState {
  const ShopDetailNotFoundState();

  List<Object> get props => [];

  @override
  String toString() => "ShopDetailNotFoundState {}";
}
