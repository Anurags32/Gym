class Excersise_Model {
  bool? status;
  String? message;
  List<Data>? data;

  Excersise_Model({this.status, this.message, this.data});

  Excersise_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? gymId;
  String? gymName;
  String? gymLogo;
  List<String>? gymImages;
  String? address;
  String? description;
  String? howToGet;
  String? partnerName;
  String? partnerEmail;
  String? partnerPhone;
  String? phoneCode;
  String? avaliableSlots;
  List<Amenities>? amenities;
  List<String>? gymImages2;
  String? open;
  String? rating;
  List<Categories>? categories;
  String? distance;
  String? imgPath;

  Data(
      {this.gymId,
      this.gymName,
      this.gymLogo,
      this.gymImages,
      this.address,
      this.description,
      this.howToGet,
      this.partnerName,
      this.partnerEmail,
      this.partnerPhone,
      this.phoneCode,
      this.avaliableSlots,
      this.amenities,
      this.gymImages2,
      this.open,
      this.rating,
      this.categories,
      this.distance,
      this.imgPath});

  Data.fromJson(Map<String, dynamic> json) {
    gymId = json['gym_id'];
    gymName = json['gym_name'];
    gymLogo = json['gym_logo'];
    gymImages = json['gym_images'].cast<String>();
    address = json['address'];
    description = json['description'];
    howToGet = json['how_to_get'];
    partnerName = json['partner_name'];
    partnerEmail = json['partner_email'];
    partnerPhone = json['partner_phone'];
    phoneCode = json['phone_code'];
    avaliableSlots = json['avaliable_slots'];
    if (json['amenities'] != null) {
      amenities = <Amenities>[];
      json['amenities'].forEach((v) {
        amenities!.add(new Amenities.fromJson(v));
      });
    }
    gymImages2 = json['gym_images2'].cast<String>();
    open = json['open'];
    rating = json['rating'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    distance = json['distance'];
    imgPath = json['img_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gym_id'] = this.gymId;
    data['gym_name'] = this.gymName;
    data['gym_logo'] = this.gymLogo;
    data['gym_images'] = this.gymImages;
    data['address'] = this.address;
    data['description'] = this.description;
    data['how_to_get'] = this.howToGet;
    data['partner_name'] = this.partnerName;
    data['partner_email'] = this.partnerEmail;
    data['partner_phone'] = this.partnerPhone;
    data['phone_code'] = this.phoneCode;
    data['avaliable_slots'] = this.avaliableSlots;
    if (this.amenities != null) {
      data['amenities'] = this.amenities!.map((v) => v.toJson()).toList();
    }
    data['gym_images2'] = this.gymImages2;
    data['open'] = this.open;
    data['rating'] = this.rating;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    data['distance'] = this.distance;
    data['img_path'] = this.imgPath;
    return data;
  }
}

class Amenities {
  int? id;
  String? name;
  String? icon;

  Amenities({this.id, this.name, this.icon});

  Amenities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['icon'] = this.icon;
    return data;
  }
}

class Categories {
  int? pricingId;
  String? categoryName;
  int? categoryId;
  List<Price>? price;

  Categories({this.pricingId, this.categoryName, this.categoryId, this.price});

  Categories.fromJson(Map<String, dynamic> json) {
    pricingId = json['pricing_id'];
    categoryName = json['category_name'];
    categoryId = json['category_id'];
    if (json['price'] != null) {
      price = <Price>[];
      json['price'].forEach((v) {
        price!.add(new Price.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pricing_id'] = this.pricingId;
    data['category_name'] = this.categoryName;
    data['category_id'] = this.categoryId;
    if (this.price != null) {
      data['price'] = this.price!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Price {
  int? hour;
  int? rate;

  Price({this.hour, this.rate});

  Price.fromJson(Map<String, dynamic> json) {
    hour = json['hour'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hour'] = this.hour;
    data['rate'] = this.rate;
    return data;
  }
}
