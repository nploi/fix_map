import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fix_map/dao/dao.dart';
import 'package:fix_map/models/models.dart';
import 'package:fix_map/repositories/fix_map_client.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShopRepository {
  final shopDao = ShopDao();

  Future<List<Shop>> getShops(LatLngBounds bounds) async {
    return await shopDao.searchShops(bounds: bounds);
  }

  Future<List<Shop>> downloadShops() async {
    FixMapResponse fixMapResponse = await FixMapClient.getAllShop();

    if (fixMapResponse.responseText != "Successfully") {
      throw Exception("Opps, has error!");
    }

    return fixMapResponse.shops;
  }

  Future<List<Shop>> getAllRecord() async {
    var shops = await shopDao.getAllShop();
    if (shops.isNotEmpty) {
      return shops;
    }
    return [];
  }

  Future getAllShops({String query}) => shopDao.getShops(query: query);

  Future<int> insertShop(Shop shop) => shopDao.createShop(shop);

  Future updateShop(Shop shop) => shopDao.updateShop(shop);
}
