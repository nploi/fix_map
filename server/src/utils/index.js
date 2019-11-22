export function toBounds(center,radiusInMeters) {
    let distanceFromCenterToCorner = radiusInMeters * Math.sqrt(2.0);
    let southwestCorner =
        computeOffset(center, distanceFromCenterToCorner, 225.0);
    let northeastCorner =
        computeOffset(center, distanceFromCenterToCorner, 45.0);
    return {
      southwest: southwestCorner, 
      northeast: northeastCorner
    }
 }

export function computeOffset(from, distance, heading) {
    distance /= 6371009;
    heading = radians(heading);
    let fromLat = radians(from.latitude);
    let fromLng = radians(from.longitude);
    let cosDistance = Math.cos(distance);
    let sinDistance = Math.sin(distance);
    let sinFromLat = Math.sin(fromLat);
    let cosFromLat = Math.cos(fromLat);
    let sinLat =
        cosDistance * sinFromLat + sinDistance * cosFromLat * Math.cos(heading);
    let dLng = Math.atan2(sinDistance * cosFromLat * Math.sin(heading),
        cosDistance - sinFromLat * sinLat);
    return {
      latlng: {
        lat: degrees(Math.asin(sinLat)),
        lng: degrees(fromLng + dLng)
      }
    }
}

export function radians(degrees) {
  var pi = Math.PI;
  return degrees * (pi/180);
}

export function degrees(radians) {
  var pi = Math.PI;
  return radians * (180/pi);
}
  