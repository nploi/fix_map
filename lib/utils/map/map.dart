import "dart:math";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:vector_math/vector_math.dart";

class MapUtils {
  static const RADIUS = 300.0;
  static LatLngBounds toBounds(LatLng center, double radiusInMeters) {
    final double distanceFromCenterToCorner = radiusInMeters * sqrt(2.0);
    final LatLng southwestCorner =
        computeOffset(center, distanceFromCenterToCorner, 225.0);
    final LatLng northeastCorner =
        computeOffset(center, distanceFromCenterToCorner, 45.0);
    return LatLngBounds(
        southwest: southwestCorner, northeast: northeastCorner);
  }

  static LatLng computeOffset(LatLng from, double distance, double heading) {
    distance /= 6371009;
    heading = radians(heading);
    final double fromLat = radians(from.latitude);
    final double fromLng = radians(from.longitude);
    final double cosDistance = cos(distance);
    final double sinDistance = sin(distance);
    final double sinFromLat = sin(fromLat);
    final double cosFromLat = cos(fromLat);
    final double sinLat =
        cosDistance * sinFromLat + sinDistance * cosFromLat * cos(heading);
    final double dLng = atan2(sinDistance * cosFromLat * sin(heading),
        cosDistance - sinFromLat * sinLat);
    return LatLng(degrees(asin(sinLat)), degrees(fromLng + dLng));
  }
}
