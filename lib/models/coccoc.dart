class CocCoc {
  Result result;
  String reqid;

  CocCoc({this.result, this.reqid});

  CocCoc.fromJson(Map<String, dynamic> json) {
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
    reqid = json['reqid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    data['reqid'] = this.reqid;
    return data;
  }
}

class Result {
  List<Poi> poi;
  List<Ads> ads;

  Result({this.poi, this.ads});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['poi'] != null) {
      poi = new List<Poi>();
      json['poi'].forEach((v) {
        poi.add(new Poi.fromJson(v));
      });
    }
    if (json['ads'] != null) {
      ads = new List<Ads>();
      json['ads'].forEach((v) {
        ads.add(new Ads.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.poi != null) {
      data['poi'] = this.poi.map((v) => v.toJson()).toList();
    }
    if (this.ads != null) {
      data['ads'] = this.ads.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Poi {
  Gps gps;
  bool isPromoted;
  String hash;
  String title;
  String brand;
  String address;
  String category;
  int rating;
  String description;
  String img;
  String imgBig;
  bool noImage;
  String phone;
  String email;
  String facebook;
  String url;
  int countReviews;
  List<Photos> photos;

  Poi(
      {this.gps,
      this.isPromoted,
      this.hash,
      this.title,
      this.brand,
      this.address,
      this.category,
      this.rating,
      this.description,
      this.img,
      this.imgBig,
      this.noImage,
      this.phone,
      this.email,
      this.facebook,
      this.url,
      this.countReviews,
      this.photos});

  Poi.fromJson(Map<String, dynamic> json) {
    gps = json['gps'] != null ? new Gps.fromJson(json['gps']) : null;
//    print(gps.toJson());
    isPromoted = json['is_promoted'];
    hash = json['hash'];
    title = json['title'];
    brand = json['brand'];
    address = json['address'];
    category = json['category'];
    rating = json['rating'];
    description = json['description'];
    img = json['img'];
    imgBig = json['img_big'];
    noImage = json['no_image'];
    phone = json['phone'];
    email = json['email'];
    facebook = json['facebook'];
    url = json['url'];
    countReviews = json['count_reviews'];
    if (json['photos'] != null) {
      photos = new List<Photos>();
      json['photos'].forEach((v) {
        photos.add(new Photos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.gps != null) {
      data['gps'] = this.gps.toJson();
    }
    data['is_promoted'] = this.isPromoted;
    data['hash'] = this.hash;
    data['title'] = this.title;
    data['brand'] = this.brand;
    data['address'] = this.address;
    data['category'] = this.category;
    data['rating'] = this.rating;
    data['description'] = this.description;
    data['img'] = this.img;
    data['img_big'] = this.imgBig;
    data['no_image'] = this.noImage;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['facebook'] = this.facebook;
    data['url'] = this.url;
    data['count_reviews'] = this.countReviews;
    if (this.photos != null) {
      data['photos'] = this.photos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Gps {
  double latitude;
  double longitude;

  Gps({this.latitude, this.longitude});

  Gps.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}

class Photos {
  Photos();

  Photos.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}

class Ads {
  String title;
  String address;
  String promotionText;
  String promotionUrl;
  String clickUrl;
  String showUrl;

  Ads(
      {this.title,
      this.address,
      this.promotionText,
      this.promotionUrl,
      this.clickUrl,
      this.showUrl});

  Ads.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    address = json['address'];
    promotionText = json['promotion_text'];
    promotionUrl = json['promotion_url'];
    clickUrl = json['click_url'];
    showUrl = json['show_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['address'] = this.address;
    data['promotion_text'] = this.promotionText;
    data['promotion_url'] = this.promotionUrl;
    data['click_url'] = this.clickUrl;
    data['show_url'] = this.showUrl;
    return data;
  }
}

var mockCocCoc = {
  "result": {
    "poi": [
      {
        "gps": {"latitude": 10.83190632, "longitude": 106.69015503},
        "is_promoted": false,
        "hash": "24625648651241771",
        "title": "<b>S\u1eeda<\/b> <b>xe<\/b> \u0110\u01b0\u1ee3c",
        "brand": "",
        "address":
            "117, Tr\u1ea7n B\u00e1 Giao, P. 5, Q. G\u00f2 V\u1ea5p, Tp. H\u1ed3 Ch\u00ed Minh",
        "category": "Giao th\u00f4ng",
        "rating": 0,
        "description": "",
        "img":
            "\/\/poipic6.coccoc.com\/80x80\/poi\/previews\/20171220\/20615-87092b3c368f3945335bd398a09b6ceb.jpg",
        "img_big":
            "\/\/poipic4.coccoc.com\/1000x750\/poi\/previews\/20171220\/20615-87092b3c368f3945335bd398a09b6ceb.jpg",
        "no_image": false,
        "phone": "(84-98) 6 833 390",
        "email": "",
        "facebook": "",
        "url": "",
        "count_reviews": 0,
        "photos": []
      },
      {
        "gps": {"latitude": 10.82482719, "longitude": 106.76911163},
        "is_promoted": false,
        "hash": "2425793147717192",
        "title": "<b>S\u1eeda<\/b> ch\u1eefa <b>xe<\/b>",
        "brand": "",
        "address":
            "234, \u0110\u1ed7 Xu\u00e2n H\u1ee3p, Q. 9, Tp. H\u1ed3 Ch\u00ed Minh",
        "category": "Giao th\u00f4ng",
        "rating": 0,
        "description": "",
        "img":
            "\/\/poipic4.coccoc.com\/80x80\/poi\/previews\/20140508\/1206-163093296d019f322f3ce3fba7269e62.jpg",
        "img_big":
            "\/\/poipic4.coccoc.com\/1000x750\/poi\/previews\/20140508\/1206-163093296d019f322f3ce3fba7269e62.jpg",
        "no_image": false,
        "phone": "",
        "email": "",
        "facebook": "",
        "url": "",
        "count_reviews": 0,
        "photos": []
      },
      {
        "gps": {"latitude": 10.825193, "longitude": 106.685555},
        "is_promoted": false,
        "hash": "34837356361000098106",
        "title": "<b>S\u1eeda<\/b> <b>Xe<\/b> M\u00e1y",
        "brand": "",
        "address":
            "45, 45 Nguy\u1ec5n Du, P. 7, Qu\u1eadn G\u00f2 V\u1ea5p, TP. HCM",
        "category": "Giao th\u00f4ng",
        "rating": 0,
        "description": "",
        "img": "\/\/poipic4.coccoc.com\/80x80\/poi\/previews\/1.png",
        "img_big": "\/\/poipic2.coccoc.com\/1000x750\/poi\/previews\/1.png",
        "no_image": true,
        "phone": "",
        "email": "",
        "facebook": "",
        "url": "https:\/\/www.foody.vn\/ho-chi-minh\/sua-xe-may",
        "count_reviews": 0,
        "photos": []
      },
      {
        "gps": {"latitude": 10.81750393, "longitude": 106.68901825},
        "is_promoted": false,
        "hash": "2884202904643477",
        "title": "<b>S\u1eeda<\/b> <b>xe<\/b> m\u00e1y",
        "brand": "",
        "address":
            "507, L\u00ea Quang \u0110\u1ecbnh, P. 1, Q. G\u00f2 V\u1ea5p, Tp. H\u1ed3 Ch\u00ed Minh",
        "category": "Giao th\u00f4ng",
        "rating": 0,
        "description": "",
        "img":
            "\/\/poipic5.coccoc.com\/80x80\/poi\/previews\/20180110\/20951-7f4f293cd0ef30af7878cd466c564b27.jpg",
        "img_big":
            "\/\/poipic4.coccoc.com\/1000x750\/poi\/previews\/20180110\/20951-7f4f293cd0ef30af7878cd466c564b27.jpg",
        "no_image": false,
        "phone": "(84-93) 3 944 855",
        "email": "",
        "facebook": "",
        "url": "",
        "count_reviews": 0,
        "photos": []
      },
      {
        "gps": {"latitude": 10.80714035, "longitude": 106.68963623},
        "is_promoted": false,
        "hash": "2742871791114821",
        "title": "<b>S\u1eeda<\/b> <b>xe<\/b> Th\u00e0nh",
        "brand": "",
        "address":
            "88, Ho\u00e0ng Hoa Th\u00e1m, P. 7, Q. B\u00ecnh Th\u1ea1nh, Tp. H\u1ed3 Ch\u00ed Minh",
        "category": "Giao th\u00f4ng",
        "rating": 0,
        "description": "",
        "img":
            "\/\/poipic3.coccoc.com\/80x80\/poi\/previews\/20180111\/20969-139fee96169c590adde1693ecf771b7e.jpg",
        "img_big":
            "\/\/poipic5.coccoc.com\/1000x750\/poi\/previews\/20180111\/20969-139fee96169c590adde1693ecf771b7e.jpg",
        "no_image": false,
        "phone": "(84-98) 3 324 320",
        "email": "",
        "facebook": "",
        "url": "",
        "count_reviews": 0,
        "photos": []
      },
      {
        "gps": {"latitude": 10.80274773, "longitude": 106.72871399},
        "is_promoted": false,
        "hash": "24333527061318173",
        "title": "<b>S\u1eeda<\/b> <b>xe<\/b> Th\u00e0nh",
        "brand": "",
        "address": "24, Xu\u00e2n Th\u1ee7y, Q. 2, Tp. H\u1ed3 Ch\u00ed Minh",
        "category": "Giao th\u00f4ng",
        "rating": 0,
        "description": "",
        "img":
            "\/\/poipic6.coccoc.com\/80x80\/poi\/previews\/20160610\/11680-7c19902961698e789fc8c03e1c06f26b.jpg",
        "img_big":
            "\/\/poipic4.coccoc.com\/1000x750\/poi\/previews\/20160610\/11680-7c19902961698e789fc8c03e1c06f26b.jpg",
        "no_image": false,
        "phone": "(84-90) 3 638 539",
        "email": "",
        "facebook": "",
        "url": "",
        "count_reviews": 0,
        "photos": []
      },
      {
        "gps": {"latitude": 10.84099483, "longitude": 106.61509705},
        "is_promoted": false,
        "hash": "34596357051382123",
        "title": "<b>S\u1eeda<\/b> <b>xe<\/b> Th\u00e0nh",
        "brand": "",
        "address":
            "251, T\u00e2n Th\u1edbi Nh\u1ea5t 1, P. T\u00e2n Th\u1edbi Nh\u1ea5t, Q. 12, Tp. H\u1ed3 Ch\u00ed Minh",
        "category": "Giao th\u00f4ng",
        "rating": 0,
        "description": "",
        "img":
            "\/\/poipic5.coccoc.com\/80x80\/poi\/previews\/20161114\/13474-612044b4627fcbeb27323d6e5d5f9888.jpg",
        "img_big":
            "\/\/poipic.coccoc.com\/1000x750\/poi\/previews\/20161114\/13474-612044b4627fcbeb27323d6e5d5f9888.jpg",
        "no_image": false,
        "phone": "",
        "email": "",
        "facebook": "",
        "url": "",
        "count_reviews": 0,
        "photos": []
      },
      {
        "gps": {"latitude": 10.83285713, "longitude": 106.62802887},
        "is_promoted": false,
        "hash": "20199501211617460",
        "title": "<b>S\u1eeda<\/b> <b>xe<\/b> Th\u00e0nh",
        "brand": "",
        "address":
            "222, Nguy\u1ec5n V\u0103n Qu\u00e1, P. \u0110\u00f4ng H\u01b0ng Thu\u1eadn, Q. 12, Tp. H\u1ed3 Ch\u00ed Minh",
        "category": "Giao th\u00f4ng",
        "rating": 0,
        "description": "",
        "img":
            "\/\/poipic.coccoc.com\/80x80\/poi\/previews\/20180604\/24103-727df421d1c3977dacfce317dcb75b93.jpg",
        "img_big":
            "\/\/poipic2.coccoc.com\/1000x750\/poi\/previews\/20180604\/24103-727df421d1c3977dacfce317dcb75b93.jpg",
        "no_image": false,
        "phone": "",
        "email": "",
        "facebook": "",
        "url": "",
        "count_reviews": 0,
        "photos": []
      },
      {
        "gps": {"latitude": 10.80994797, "longitude": 106.70912933},
        "is_promoted": false,
        "hash": "3952532891685714",
        "title": "<b>S\u1eeda<\/b> <b>xe<\/b> Th\u00e0nh",
        "brand": "",
        "address":
            "183, \u0110inh B\u1ed9 L\u0129nh, Q. B\u00ecnh Th\u1ea1nh, Tp. H\u1ed3 Ch\u00ed Minh",
        "category": "Giao th\u00f4ng",
        "rating": 0,
        "description": "",
        "img":
            "\/\/poipic3.coccoc.com\/80x80\/poi\/previews\/20160608\/11604-5cc5f813224153294ac11076696a1414.jpg",
        "img_big":
            "\/\/poipic.coccoc.com\/1000x750\/poi\/previews\/20160608\/11604-5cc5f813224153294ac11076696a1414.jpg",
        "no_image": false,
        "phone": "",
        "email": "",
        "facebook": "",
        "url": "",
        "count_reviews": 0,
        "photos": []
      },
      {
        "gps": {"latitude": 10.81388187, "longitude": 106.77523041},
        "is_promoted": false,
        "hash": "81451130712597",
        "title": "<b>S\u1eeda<\/b> <b>xe<\/b> Th\u00e0nh",
        "brand": "",
        "address":
            "642, \u0110\u1ed7 Xu\u00e2n H\u1ee3p, Q. 9, Tp. H\u1ed3 Ch\u00ed Minh",
        "category": "Giao th\u00f4ng",
        "rating": 0,
        "description": "",
        "img":
            "\/\/poipic1.coccoc.com\/80x80\/poi\/previews\/20140506\/1208-c8ff2db75edef8ac14a1849115f42487.jpg",
        "img_big":
            "\/\/poipic3.coccoc.com\/1000x750\/poi\/previews\/20140506\/1208-c8ff2db75edef8ac14a1849115f42487.jpg",
        "no_image": false,
        "phone": "",
        "email": "",
        "facebook": "",
        "url": "",
        "count_reviews": 0,
        "photos": []
      },
      {
        "gps": {"latitude": 10.82564545, "longitude": 106.57346344},
        "is_promoted": false,
        "hash": "1485627270832158",
        "title": "<b>S\u1eeda<\/b> <b>xe<\/b> Th\u00e0nh",
        "brand": "",
        "address":
            "E1\/2C, Qu\u00e1ch \u0110i\u00eau, X\u00e3 V\u0129nh L\u1ed9c A, H. B\u00ecnh Ch\u00e1nh, Tp. H\u1ed3 Ch\u00ed Minh",
        "category": "Giao th\u00f4ng",
        "rating": 0,
        "description": "",
        "img":
            "\/\/poipic.coccoc.com\/80x80\/poi\/previews\/20160616\/11753-d2786d870ee7bffe104387914f29850b.jpg",
        "img_big":
            "\/\/poipic3.coccoc.com\/1000x750\/poi\/previews\/20160616\/11753-d2786d870ee7bffe104387914f29850b.jpg",
        "no_image": false,
        "phone": "",
        "email": "",
        "facebook": "",
        "url": "",
        "count_reviews": 0,
        "photos": []
      },
      {
        "gps": {"latitude": 10.80222607, "longitude": 106.68919373},
        "is_promoted": false,
        "hash": "4116363211893213",
        "title": "<b>S\u1eeda<\/b> <b>xe<\/b> Th\u00e0nh",
        "brand": "",
        "address":
            "2, Nhi\u00eau T\u1ee9, P. 7, Q. Ph\u00fa Nhu\u1eadn, Tp. H\u1ed3 Ch\u00ed Minh",
        "category": "Giao th\u00f4ng",
        "rating": 0,
        "description": "",
        "img":
            "\/\/poipic5.coccoc.com\/80x80\/poi\/previews\/20180613\/24311-0b4a48dbaeaf51738dd715ff6ea0d0a4.jpg",
        "img_big":
            "\/\/poipic3.coccoc.com\/1000x750\/poi\/previews\/20180613\/24311-0b4a48dbaeaf51738dd715ff6ea0d0a4.jpg",
        "no_image": false,
        "phone": "",
        "email": "",
        "facebook": "",
        "url": "",
        "count_reviews": 0,
        "photos": []
      },
      {
        "gps": {"latitude": 10.83980656, "longitude": 106.61227417},
        "is_promoted": false,
        "hash": "14710890471221636",
        "title": "<b>S\u1eeda<\/b> <b>xe<\/b> N\u0103m",
        "brand": "",
        "address":
            "2803, Qu\u1ed1c l\u1ed9 1A, P. T\u00e2n Th\u1edbi Nh\u1ea5t, Q. 12, Tp. H\u1ed3 Ch\u00ed Minh",
        "category": "Giao th\u00f4ng",
        "rating": 0,
        "description": "",
        "img":
            "\/\/poipic3.coccoc.com\/80x80\/poi\/previews\/20161115\/13477-dca0e2c645977f709935d6d9c8842032.jpg",
        "img_big":
            "\/\/poipic1.coccoc.com\/1000x750\/poi\/previews\/20161115\/13477-dca0e2c645977f709935d6d9c8842032.jpg",
        "no_image": false,
        "phone": "",
        "email": "",
        "facebook": "",
        "url": "",
        "count_reviews": 0,
        "photos": []
      },
      {
        "gps": {"latitude": 10.8328867, "longitude": 106.68131256},
        "is_promoted": false,
        "hash": "36835215811310918",
        "title": "<b>S\u1eeda<\/b> <b>xe<\/b> N\u0103m",
        "brand": "",
        "address":
            "Ph\u1ea1m Huy Th\u00f4ng, P. 7, Q. G\u00f2 V\u1ea5p, Tp. H\u1ed3 Ch\u00ed Minh",
        "category": "Giao th\u00f4ng",
        "rating": 0,
        "description": "",
        "img":
            "\/\/poipic1.coccoc.com\/80x80\/poi\/previews\/20171205\/20354-719759a9cec09b5d83a523e19eee7adb.jpg",
        "img_big":
            "\/\/poipic.coccoc.com\/1000x750\/poi\/previews\/20171205\/20354-719759a9cec09b5d83a523e19eee7adb.jpg",
        "no_image": false,
        "phone": "",
        "email": "",
        "facebook": "",
        "url": "",
        "count_reviews": 0,
        "photos": []
      },
      {
        "gps": {"latitude": 10.81769657, "longitude": 106.7233429},
        "is_promoted": false,
        "hash": "3532633846722697",
        "title": "<b>S\u1eeda<\/b> <b>xe<\/b> Th\u00eam",
        "brand": "",
        "address":
            "140\/10, B\u00ecnh Qu\u1edbi, Q. B\u00ecnh Th\u1ea1nh, Tp. H\u1ed3 Ch\u00ed Minh",
        "category": "Giao th\u00f4ng",
        "rating": 0,
        "description": "",
        "img":
            "\/\/poipic3.coccoc.com\/80x80\/poi\/previews\/20141204\/4616-05a86e1864357b2ddcb4b173ec6b29e6.jpg",
        "img_big":
            "\/\/poipic1.coccoc.com\/1000x750\/poi\/previews\/20141204\/4616-05a86e1864357b2ddcb4b173ec6b29e6.jpg",
        "no_image": false,
        "phone": "(84-90) 3 306 066",
        "email": "",
        "facebook": "",
        "url": "",
        "count_reviews": 0,
        "photos": []
      },
      {
        "gps": {"latitude": 10.8284874, "longitude": 106.61060333},
        "is_promoted": false,
        "hash": "20588406611221138",
        "title": "<b>S\u1eeda<\/b> <b>xe<\/b> Vi\u1ec7t",
        "brand": "",
        "address":
            "T\u00e2n Th\u1edbi Nh\u1ea5t 8, Q. 12, Tp. H\u1ed3 Ch\u00ed Minh",
        "category": "Giao th\u00f4ng",
        "rating": 0,
        "description": "",
        "img":
            "\/\/poipic4.coccoc.com\/80x80\/poi\/previews\/20151126\/9047-cc6219b3cbd7dc00a7d7c569b218e4e1.jpg",
        "img_big":
            "\/\/poipic4.coccoc.com\/1000x750\/poi\/previews\/20151126\/9047-cc6219b3cbd7dc00a7d7c569b218e4e1.jpg",
        "no_image": false,
        "phone": "",
        "email": "",
        "facebook": "",
        "url": "",
        "count_reviews": 0,
        "photos": []
      },
      {
        "gps": {"latitude": 10.82897472, "longitude": 106.58380127},
        "is_promoted": false,
        "hash": "3115700888829552",
        "title": "<b>S\u1eeda<\/b> <b>xe<\/b> Ra",
        "brand": "",
        "address":
            "E9\/18, Th\u1edbi H\u00f2a, X\u00e3 V\u0129nh L\u1ed9c A, H. B\u00ecnh Ch\u00e1nh, Tp. H\u1ed3 Ch\u00ed Minh",
        "category": "Giao th\u00f4ng",
        "rating": 0,
        "description": "",
        "img":
            "\/\/poipic4.coccoc.com\/80x80\/poi\/previews\/20160617\/11753-6f9af096064605dbaee0cc2ec663d64f.jpg",
        "img_big":
            "\/\/poipic1.coccoc.com\/1000x750\/poi\/previews\/20160617\/11753-6f9af096064605dbaee0cc2ec663d64f.jpg",
        "no_image": false,
        "phone": "",
        "email": "",
        "facebook": "",
        "url": "",
        "count_reviews": 0,
        "photos": []
      },
      {
        "gps": {"latitude": 10.83877754, "longitude": 106.7193222},
        "is_promoted": false,
        "hash": "6278920551318632",
        "title": "<b>S\u1eeda<\/b> <b>xe<\/b> \u0110\u1ecbnh",
        "brand": "",
        "address":
            "77, \u0110\u01b0\u1eddng s\u1ed1 2, P. Hi\u1ec7p B\u00ecnh Ph\u01b0\u1edbc, Q. Th\u1ee7 \u0110\u1ee9c, Tp. H\u1ed3 Ch\u00ed Minh",
        "category": "Giao th\u00f4ng",
        "rating": 0,
        "description": "",
        "img":
            "\/\/poipic1.coccoc.com\/80x80\/poi\/previews\/20180614\/24322-a613357bb5b33b06f49dd7edc81a1c69.jpg",
        "img_big":
            "\/\/poipic6.coccoc.com\/1000x750\/poi\/previews\/20180614\/24322-a613357bb5b33b06f49dd7edc81a1c69.jpg",
        "no_image": false,
        "phone": "(84-93) 3 093 099",
        "email": "",
        "facebook": "",
        "url": "",
        "count_reviews": 0,
        "photos": []
      },
      {
        "gps": {"latitude": 10.83498955, "longitude": 106.61482239},
        "is_promoted": false,
        "hash": "2723225059345411",
        "title": "<b>S\u1eeda<\/b> <b>xe<\/b> \u0110\u1ecbnh",
        "brand": "",
        "address":
            "59, T\u00e2n Th\u1edbi Nh\u1ea5t 2, P. T\u00e2n Th\u1edbi Nh\u1ea5t, Q. 12, Tp. H\u1ed3 Ch\u00ed Minh",
        "category": "Giao th\u00f4ng",
        "rating": 0,
        "description": "",
        "img":
            "\/\/poipic4.coccoc.com\/80x80\/poi\/previews\/20161115\/13474-10e786ff71614d0163630f270d8e053c.jpg",
        "img_big":
            "\/\/poipic3.coccoc.com\/1000x750\/poi\/previews\/20161115\/13474-10e786ff71614d0163630f270d8e053c.jpg",
        "no_image": false,
        "phone": "(84-90) 7 949 609",
        "email": "",
        "facebook": "",
        "url": "",
        "count_reviews": 0,
        "photos": []
      },
      {
        "gps": {"latitude": 10.80474854, "longitude": 106.68321991},
        "is_promoted": false,
        "hash": "4271179830962305",
        "title": "<b>S\u1eeda<\/b> <b>xe<\/b> T\u1ed1t",
        "brand": "",
        "address":
            "112, Ph\u00f9ng V\u0103n Cung, P. 4, Q. Ph\u00fa Nhu\u1eadn, Tp. H\u1ed3 Ch\u00ed Minh",
        "category": "Giao th\u00f4ng",
        "rating": 0,
        "description": "",
        "img":
            "\/\/poipic6.coccoc.com\/80x80\/poi\/previews\/20141111\/4164-fed63eb1a6608aab5e33a805e290d5d5.jpg",
        "img_big":
            "\/\/poipic3.coccoc.com\/1000x750\/poi\/previews\/20141111\/4164-fed63eb1a6608aab5e33a805e290d5d5.jpg",
        "no_image": false,
        "phone": "",
        "email": "",
        "facebook": "",
        "url": "",
        "count_reviews": 0,
        "photos": []
      },
    ],
    "ads": [
      {
        "title":
            "B\u1ea3ng Tin C\u1eadp Nh\u1eadt KM Si\u00eau Kh\u1ee7ng C\u00e1c D\u00f2ng \u00d4 T\u00f4 Hyundai Palisade!",
        "address": "",
        "promotion_text":
            "H\u1ed7 Tr\u1ee3 Th\u1ee7 T\u1ee5c Vay Ng\u00e2n H\u00e0ng LS Th\u1ea5p - Th\u1ee7 T\u1ee5c \u0110\u01a1n Gi\u1ea3n - Giao <b>Xe<\/b> \u0110\u00fang H\u1eb9n",
        "promotion_url":
            "https:\/\/huyndai-saigon.com\/gia-hyundai-palisade-tai-viet-nam-da-duoc-cong-bo-trang-chu-tin-tuc-moi-gia-hyundai-palisade-tai-viet-nam-da-duoc-cong-bo\/?utm_source=coccoc_%7Bcampaign_type%7D&utm_medium=%7Bpayment_type%7D&utm_campaign=%7Bcampaign_name%7D&utm_term=%7BkeywordOrCategory%7D&utm_content=%7Bcreative%7D",
        "click_url":
            "https:\/\/context.qc.coccoc.com\/click?click=_0A7O50vdaVeKsH5UfBez15Yyt5vOz9qu84ISDlHqdH5vUcE5idRodzpNWGvPGyNJau37bvQLReUNGZYJFljPFQGJ-H2MDIKVg6Aa4c3JvhGnPwRJGEv-Ym1RtP44iLU8h35XUJYvwanir8VgkrW0vunWYGyKI5hyZw0LizHLiNXzvTGH5W17l3ewDVMxndwi1I*CMnMYxzO23QZdOtQdU0pjqoqQPGShCyGFgaUk*A-TCCQ2kGIPcruXSJ7Ks5CgW8WJ1DqaLg1wtMR8DC0wDo*mK3UezrxjYNc4K5W0BkPuKUiCfSank8uh8*tInASWqgUIgKZOIVFMGQJtaZaOuA9adfOuAmj5Cr-efQOkXQ0A*I-9E5o*0qig28Lu3KK0SYcKelmoQdG5ATFFk1yfCATqzPXJmVxcx*BvSk1vn8srBjYUZ8tD1UBBRvHKK4gkvakFyRod9hH4q95cWgZcrO0XDVhumWFWZ-rbD8ZltOgJcnX*cE7zNVwdBLPexlt6StoxIiKg*ssI6g601R4ZMV2zA9xD5rowxXl5eT5xJYHpzW*WJxrxtKGRE4DWfGntAu*koAg3KeQXcpx*pPKEQdnSxOP-Q3W*cNl0U5p*65LTBpMWC4zCVBBYWumpP9xKGnAf2XKDaMYn8S06BxrkETgIm3*0KGT9ry0EO3fFYpC5bxbnrqzzk7Z4ERgA8EfHhCvJV0Q24rfCb2zk7UqYeXnfhLkExQFdrOr3CvfwI2*u0DKsd5DFRfKS-i5ombeaGRb0l6PlFJIv2ol2MP-xRFIYHC0jBY-xqsoGDllu9asLBXwFzX07WlGO70C2mNzixGmH46r9jMgWT-09vVA-rSKRBEdvhsZHw8*el9wEATF4LnwprBp*5Os*Adsc0CJkymX7rVGoBENfidDMfWeE.&reqid=H3iUpDnV",
        "show_url":
            "https:\/\/context.qc.coccoc.com\/show?show=_0H7W50vdahecg-p0HBexLp*26DaWpOGgsRPEcT1zLfhpKZmrOtGaGVm--lS8Pxrrmk8xqOKjh3mJHkSvQhuRo6wKa0T9AGAp8p4i*7f5FXoLzgspVZlFQotykQ4JX76il4jngBlSKkvBN1*hojeQRIogRrtEGn1XwvKyyBHF7S5AQ6UbLzUdQXtgcAlfT1mYh5o4EkptQVMvgMy8SlSH5BDeDljDQajU0OxKcpN0lN*GFgOJ2j9ludil713vOJSr-offYwh1S9IdDCfkel-OYzMVR5Wd*XjrHrquwk3u2GqgU4pfpTY91lEyXnzRwctjz-CTQW4DTMhcujLtf6mDrXgDTnvrzG9f0sWWstMyTruUU3maPPEOvegK74m-8de6Iu-8E3YmRjx8tOJEfebqo3oTL1w0KL3C3IWx-vI1argFySZBK1Ctlx3F1deOU0LFH22xBYNbuzAwiEAFcNHSOzvAvadeQhC6A1PdHOSAziEzNSWZKLSusE5FUqbZ-sU-SD9U4iHrqeWGEZrg07NPLjPwLZ7Ppe393o-jcIvwSG8VsYv4KqZAKVhjffToGpODmrplemTeeGg..&reqid=H3iUpDnV"
      }
    ]
  },
  "reqid": ""
};
