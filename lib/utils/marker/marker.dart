import "dart:typed_data";
import "dart:ui" as ui;

import "package:flutter/services.dart";

class MarkerUtils {
  static Uint8List settingsCircle;
  static Uint8List settingsLocation;

  static Future initIcons() async {
    settingsCircle = await getBytesFromAsset("assets/map/circle.png", 50);
    settingsLocation = await getBytesFromAsset("assets/map/marker.png", 70);
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    final ByteData data = await rootBundle.load(path);
    final ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    final ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }
}
