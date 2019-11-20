import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fix_map/models/coccoc.dart';
import 'package:fix_map/models/models.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShopRepository {
  Future<List<Shop>> getShops(LatLngBounds bounds, {bool mock = false}) async {
    if (mock) {
      return _shopsMock();
    }
    return await fetchFixShops(bounds);
  }

  List<Shop> _shopsMock() {
    CocCoc cocCoc = CocCoc.fromJson(mockCocCoc);
    List<Shop> shops = [];
    cocCoc.result.poi.forEach((poi) => shops.add(Shop.fromPoi(poi)));
    return shops;
  }

  Future<List<Shop>> fetchFixShops(LatLngBounds bounds) async {
    Response response = await Dio().get(
        "https://map.coccoc.com/en/map/search.json?query=s%E1%BB%ADa+xe&borders=${bounds.southwest.latitude}%2C${bounds.southwest.longitude}%2C${bounds.northeast.latitude}%2C${bounds.northeast.longitude}");

    CocCoc cocCoc = CocCoc.fromJson(jsonDecode(response.toString()));
    List<Shop> shops = [];
    cocCoc.result.poi.forEach((poi) => shops.add(Shop.fromPoi(poi)));
    return shops;
  }
}
