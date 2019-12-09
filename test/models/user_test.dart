import 'package:fix_map/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Shop', () {
    var json = {
      'id': 1,
      'hash': '1234',
      'name': 'Sua xe',
      'phoneNumber': '84123456789',
      'address': '227 Nguyen Van Cu',
      'status': 'Online',
      'rating': 4.0,
      'image': '1234.png',
      'imageBig': '1234.png',
      'latitude': 10.0,
      'longitude': 100.0,
      'category': 'Fixer'
    };

    test('toJson', () {
      Shop shop = Shop(
        id: 1,
        hash: "1234",
        name: "Sua xe",
        phoneNumber: "84123456789",
        address: "227 Nguyen Van Cu",
        status: "Online",
        rating: 4.0,
        image: "1234.png",
        imageBig: "1234.png",
        latitude: 10.0,
        longitude: 100.0,
        category: "Fixer",
      );

      expect(shop.toJson(), json);
    });

    test('fromJson', () {
      Shop shop = Shop.fromJson(json);
      expect(shop.toJson(), json);
    });

    var databaseJson = {
      'id': 1,
      'hash': '1234',
      'name': 'Sua xe',
      'phone_number': '84123456789',
      'address': '227 Nguyen Van Cu',
      'status': 'Online',
      'rating': 4.0,
      'image': '1234.png',
      'image_big': '1234.png',
      'latitude': 10.0,
      'longitude': 100.0,
      'category': 'Fixer'
    };

    test('toDatabaseJson', () {
      Shop shop = Shop(
        id: 1,
        hash: "1234",
        name: "Sua xe",
        phoneNumber: "84123456789",
        address: "227 Nguyen Van Cu",
        status: "Online",
        rating: 4.0,
        image: "1234.png",
        imageBig: "1234.png",
        latitude: 10.0,
        longitude: 100.0,
        category: "Fixer",
      );

      expect(shop.toDatabaseJson(), databaseJson);
    });

    test('fromDatabaseJson', () {
      Shop shop = Shop.fromDatabaseJson(databaseJson);
      expect(shop.toDatabaseJson(), databaseJson);
    });
  });
}
