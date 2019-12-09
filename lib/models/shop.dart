class Shop {
  int id;
  String hash;
  String name;
  String phoneNumber;
  String address;
  String status;
  double rating;
  String image;
  String imageBig;
  double latitude;
  double longitude;
  String category;

  Shop(
      {this.id,
      this.hash,
      this.name,
      this.phoneNumber,
      this.address,
      this.status,
      this.rating,
      this.image,
      this.imageBig,
      this.latitude,
      this.longitude,
      this.category});

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        id: json['id'],
        hash: json['hash'],
        name: json['name'],
        phoneNumber: json['phoneNumber'],
        address: json['address'],
        status: json['status'],
        rating: json['rating'],
        image: json['image'],
        imageBig: json['imageBig'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        category: json['category'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hash'] = this.hash;
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['address'] = this.address;
    data['status'] = this.status;
    data['rating'] = this.rating;
    data['image'] = this.image;
    data['imageBig'] = this.imageBig;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['category'] = this.category;
    return data;
  }

  Map<String, dynamic> toDatabaseJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hash'] = this.hash;
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['address'] = this.address;
    data['status'] = this.status;
    data['rating'] = this.rating;
    data['image'] = this.image;
    data['image_big'] = this.imageBig;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['category'] = this.category;
    return data;
  }

  factory Shop.fromDatabaseJson(Map<String, dynamic> json) => Shop(
        //This will be used to convert JSON objects that
        //are coming from querying the database and converting
        //it into a Shop object
        id: json['id'],
        hash: json['hash'],
        name: json['name'],
        phoneNumber: json['phone_number'],
        address: json['address'],
        status: json['status'],
        rating: json['rating'],
        image: json['image'],
        imageBig: json['image_big'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        category: json['category'],
      );
}
