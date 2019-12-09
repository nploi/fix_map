import "dart:async";
import "package:fix_map/database/database.dart";
import "package:fix_map/models/models.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";

class ShopDao {
  final dbProvider = DatabaseProvider.dbProvider;

  //Adds new Shop records
  Future<int> createShop(Shop shop) async {
    final db = await dbProvider.database;
    final result = db.insert(shopTABLE, shop.toDatabaseJson());
    return result;
  }

  //Get All Shop items
  //Searches if query string was passed
  Future<List<Shop>> getShops(
      {String query, int offset = 0, int limit = 20}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null && query != "") {
      if (query.isNotEmpty) {
        result = await db.query(shopTABLE,
            where: "name LIKE ?",
            whereArgs: ["%$query%"],
            offset: offset,
            limit: limit);
      }
    } else {
      result = [];
    }

    final List<Shop> shops = result.isNotEmpty
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
        where: "(? <= latitude AND latitude <= ?) "
            "AND $nextQuery",
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

    final List<Shop> shops = result.isNotEmpty
        ? result.map((item) => Shop.fromDatabaseJson(item)).toList()
        : [];
    return shops;
  }

  //Get last Shop items
  Future<List<Shop>> getAllShop() async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;

    result = await db.query(shopTABLE);

    final List<Shop> shops = result.isNotEmpty
        ? result.map((item) => Shop.fromDatabaseJson(item)).toList()
        : [];
    return shops;
  }

  //Update Shop record
  Future<int> updateShop(Shop shop) async {
    final db = await dbProvider.database;

    final result = await db.update(shopTABLE, shop.toDatabaseJson(),
        where: "id = ?", whereArgs: [shop.id]);

    return result;
  }

  //Delete Shop records
  Future<int> deleteShop(int id) async {
    final db = await dbProvider.database;
    final result = await db.delete(shopTABLE, where: "id = ?", whereArgs: [id]);

    return result;
  }

  //We are not going to use this in the demo
  Future deleteAllShops() async {
    final db = await dbProvider.database;
    final result = await db.delete(
      shopTABLE,
    );

    return result;
  }
}
