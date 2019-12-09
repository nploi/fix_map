import "package:geolocator/geolocator.dart";

class MapRepository {
  Geolocator geoLocator = Geolocator();

  Future<Position> getCurrentLocation() async {
    final position = await geoLocator.getCurrentPosition(
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
