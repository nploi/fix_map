import "package:equatable/equatable.dart";
import "package:flutter/foundation.dart";

@immutable
abstract class ShopsDetailEvent extends Equatable {
  const ShopsDetailEvent();
  @override
  List<Object> get props => [];
}

class ShopsDetailByQueryEvent extends ShopsDetailEvent {
  final String query;
  const ShopsDetailByQueryEvent(this.query);

  List<Object> get props => [query];

  @override
  String toString() => "ShopsDetailByQueryEvent {query: $query}";
}

class ShopsDetailNextOffsetEvent extends ShopsDetailEvent {
  final String query;
  const ShopsDetailNextOffsetEvent(this.query);

  List<Object> get props => [query];

  @override
  String toString() => "ShopsDetailNextOffsetEvent {query: $query}";
}
