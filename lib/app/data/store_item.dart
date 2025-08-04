import 'dart:convert';

StoreItem storeItemFromJson(String str) => StoreItem.fromJson(json.decode(str));

String storeItemToJson(StoreItem data) => json.encode(data.toJson());

class StoreItem {
  bool? success;
  StoreDetails? storeDetails;

  StoreItem({this.success, this.storeDetails});

  factory StoreItem.fromJson(Map<String, dynamic> json) => StoreItem(
    success: json["success"],
    storeDetails: json["data"] != null
        ? StoreDetails.fromJson(json["data"]) // Treat data as an object
        : null,
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": storeDetails?.toJson(),
  };
}

class StoreDetails {
  int? id;
  String? shopName;
  String? gstNo;
  String? shopTime;
  double? rating;
  String? panNo;
  String? tanno;
  String? address;
  String? userName;
  String? categories;
  String? otherCategories;
  String? shopImage;
  String? email; // Added
  String? contact; // Added
  String? website; // Added
  String? about; // Added
  String? delivery; // Added

  StoreDetails({
    this.id,
    this.shopName,
    this.gstNo,
    this.shopTime,
    this.rating,
    this.panNo,
    this.tanno,
    this.address,
    this.userName,
    this.categories,
    this.otherCategories,
    this.shopImage,
    this.email,
    this.contact,
    this.website,
    this.about,
    this.delivery,
  });

  factory StoreDetails.fromJson(Map<String, dynamic> json) => StoreDetails(
    id: json["id"],
    shopName: json["shop_name"],
    gstNo: json["gst_no"],
    shopTime: json["shop_time"],
    rating: json["rating"] != null
        ? double.tryParse(json["rating"].toString()) ?? 0.0
        : 0.0,
    panNo: json["pan_no"],
    tanno: json["tanno"],
    address: json["address"],
    userName: json["user_name"],
    categories: json["categories"],
    otherCategories: json["other_categories"],
    shopImage: json["shop_image"],
    email: json["email"],
    contact: json["contact"],
    website: json["website"],
    about: json["about"],
    delivery: json["delivery"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "shop_name": shopName,
    "gst_no": gstNo,
    "shop_time": shopTime,
    "rating": rating,
    "pan_no": panNo,
    "tanno": tanno,
    "address": address,
    "user_name": userName,
    "categories": categories,
    "other_categories": otherCategories,
    "shop_image": shopImage,
    "email": email,
    "contact": contact,
    "website": website,
    "about": about,
    "delivery": delivery,
  };
}

