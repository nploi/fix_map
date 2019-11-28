import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vector_math/vector_math.dart';

class MapUtils {
  static const RADIUS = 300.0;
  static LatLngBounds toBounds(LatLng center, double radiusInMeters) {
    double distanceFromCenterToCorner = radiusInMeters * sqrt(2.0);
    LatLng southwestCorner =
        computeOffset(center, distanceFromCenterToCorner, 225.0);
    LatLng northeastCorner =
        computeOffset(center, distanceFromCenterToCorner, 45.0);
    return new LatLngBounds(
        southwest: southwestCorner, northeast: northeastCorner);
  }

  static LatLng computeOffset(LatLng from, double distance, double heading) {
    distance /= 6371009;
    heading = radians(heading);
    double fromLat = radians(from.latitude);
    double fromLng = radians(from.longitude);
    double cosDistance = cos(distance);
    double sinDistance = sin(distance);
    double sinFromLat = sin(fromLat);
    double cosFromLat = cos(fromLat);
    double sinLat =
        cosDistance * sinFromLat + sinDistance * cosFromLat * cos(heading);
    double dLng = atan2(sinDistance * cosFromLat * sin(heading),
        cosDistance - sinFromLat * sinLat);
    return new LatLng(degrees(asin(sinLat)), degrees(fromLng + dLng));
  }
}
