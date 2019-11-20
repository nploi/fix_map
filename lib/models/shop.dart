import 'coccoc.dart';

class Shop {
  String hash;
  String name;
  String phoneNumber;
  String address;
  double rate;
  String status;
  int rating;
  String image;
  String imageBig;
  double latitude;
  double longitude;

  Shop(
      {this.latitude,
      this.longitude,
      this.name,
      this.phoneNumber,
      this.address,
      this.rate,
      this.rating,
      this.status,
      this.image,
      this.imageBig});

  Shop.fromPoi(Poi poi) {
    name = poi.title != null
        ? poi.title.replaceAll("<b>", '').replaceAll("</b>", '')
        : "";
    hash = poi.hash;
    latitude = poi.gps.latitude;
    longitude = poi.gps.longitude;
    address = poi.address != null
        ? poi.address.replaceAll("<b>", '').replaceAll("</b>", '')
        : "";
    image = 'https:${poi.img}';
    imageBig = 'https:${poi.imgBig}';
    phoneNumber = poi.phone;
    status = "OK";
    rating = poi.rating;
  }
}
