import 'dart:convert';

import 'package:fix_map/models/coccoc.dart';
import 'package:fix_map/models/models.dart';

class ShopRepository {
  List<Shop> getShops({bool mock = false}) {
    if (mock) {
      return _shopsMock();
    }
    return [];
  }

  List<Shop> _shopsMock() {
    CocCoc cocCoc = CocCoc.fromJson(mockCocCoc);
    List<Shop> shops = [];
    cocCoc.result.poi.forEach((poi) => shops.add(Shop.fromPoi(poi)));
    return shops;
  }
}
