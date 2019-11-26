import 'dart:async';
import 'package:fix_map/database/database.dart';
import 'package:fix_map/models/models.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShopDao {
  final dbProvider = DatabaseProvider.dbProvider;

  //Adds new Shop records
  Future<int> createShop(Shop shop) async {
    final db = await dbProvider.database;
    var result = db.insert(shopTABLE, shop.toDatabaseJson());
    return result;
  }

  //Get All Shop items
  //Searches if query string was passed
  Future<List<Shop>> getShops({List<String> columns, String query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty)
        result = await db.query(shopTABLE,
            columns: columns, where: 'name LIKE ?', whereArgs: ["%$query%"]);
    } else {
      result = await db.query(shopTABLE, columns: columns);
    }

    List<Shop> shops = result.isNotEmpty
        ? result.map((item) => Shop.fromDatabaseJson(item)).toList()
        : [];
    return shops;
  }

  Future<List<Shop>> searchShops({LatLngBounds bounds}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    if (bounds != null) {
      String nextQuery = "(? <= longitude OR longitude <= ?)";
      if (bounds.southwest.longitude <= bounds.northeast.longitude) {
        nextQuery = "(? <= longitude AND longitude <= ?)";
      }
      result = await db.query(
        shopTABLE,
        where: '(? <= latitude AND latitude <= ?) '
            'AND $nextQuery',
        whereArgs: [
          bounds.southwest.latitude,
          bounds.northeast.latitude,
          bounds.southwest.longitude,
          bounds.northeast.longitude,
        ],
      );
    } else {
      result = await db.query(shopTABLE);
    }

    List<Shop> shops = result.isNotEmpty
        ? result.map((item) => Shop.fromDatabaseJson(item)).toList()
        : [];
    return shops;
  }

  //Get last Shop items
  Future<List<Shop>> getAllShop() async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;

    result = await db.query(shopTABLE);

    List<Shop> shops = result.isNotEmpty
        ? result.map((item) => Shop.fromDatabaseJson(item)).toList()
        : [];
    return shops;
  }

  //Update Shop record
  Future<int> updateShop(Shop shop) async {
    final db = await dbProvider.database;

    var result = await db.update(shopTABLE, shop.toDatabaseJson(),
        where: "id = ?", whereArgs: [shop.id]);

    return result;
  }

  //Delete Shop records
  Future<int> deleteShop(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(shopTABLE, where: 'id = ?', whereArgs: [id]);

    return result;
  }

  //We are not going to use this in the demo
  Future deleteAllShops() async {
    final db = await dbProvider.database;
    var result = await db.delete(
      shopTABLE,
    );

    return result;
  }
}
