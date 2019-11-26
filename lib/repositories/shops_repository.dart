import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fix_map/dao/dao.dart';
import 'package:fix_map/models/models.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShopRepository {
  final shopDao = ShopDao();

  Future<List<Shop>> getShops(LatLngBounds bounds) async {
    return await shopDao.searchShops(bounds: bounds);
  }

  Future<List<Shop>> downloadShops() async {
    Response response =
        await Dio().get("http://fixmap.documents.asia:5005/shop/list-all");

    FixMapResponse fixMapResponse =
        FixMapResponse.fromJson(jsonDecode(response.toString()));

    if (fixMapResponse.responseText != "Successfully") {
      throw Exception("Opps, has error!");
    }

    for (int index = 0; index < fixMapResponse.shops.length; index++) {
      var shop = fixMapResponse.shops[index];
      var id = await insertShop(shop);
      print(id);
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
