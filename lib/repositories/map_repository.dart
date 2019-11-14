import 'dart:convert';

import 'package:fix_map/models/models.dart';
import 'package:geolocator/geolocator.dart';

import 'shared_preferences_repository.dart';

class MapRepository {
  Geolocator geoLocator = Geolocator();

  Future<Position> getCurrentLocation() async {
    var position = await geoLocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );

    return position;
  }

  Future<Position> getLastKnownLocation() async {
    return await geoLocator.getLastKnownPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
  }
}
