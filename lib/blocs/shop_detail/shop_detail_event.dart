import "package:equatable/equatable.dart";
import "package:flutter/foundation.dart";

@immutable
abstract class ShopDetailEvent extends Equatable {
  const ShopDetailEvent();
  @override
  List<Object> get props => [];
}

class ShopDetailByHashEvent extends ShopDetailEvent {
  final String hash;
  const ShopDetailByHashEvent(this.hash);

  List<Object> get props => [hash];

  @override
  String toString() => "ShopDetailByHashEvent {hash: $hash}";
}