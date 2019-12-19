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

class ShopsSearchSuggestionsLoadingState extends ShopsSearchState {}

class ShopsSearchSuggestionsLoadedState extends ShopsSearchState {
  final List<String> suggestions;
  const ShopsSearchSuggestionsLoadedState(this.suggestions);

  List<Object> get props => [suggestions];

  @override
  String toString() =>
      "ShopsSearchSuggestionsLoadedState {suggestions: $suggestions}";
}

class ShopsSearchLoadedState extends ShopsSearchState {
  final List<Shop> shops;
  final int size;
  final String query;

  const ShopsSearchLoadedState(this.shops, this.size, this.query);

  List<Object> get props => [shops, size, query];

  @override
  String toString() => "ShopsSearchLoadedState {shops: $shops, size: $size, query: $query}";
}
