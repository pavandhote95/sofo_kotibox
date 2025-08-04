import 'dart:convert';

StoreList storeListFromJson(String str) => StoreList.fromJson(json.decode(str));
String storeListToJson(StoreList data) => json.encode(data.toJson());

class StoreList {
  bool success;
  List<StorelistData> data;

  StoreList({
    this.success = false,
    this.data = const [],
  });

  factory StoreList.fromJson(Map<String, dynamic> json) => StoreList(
    success: json["success"] ?? false,
    data: json["data"] == null
        ? []
        : List<StorelistData>.from(
        json["data"].map((x) => StorelistData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.map((x) => x.toJson()).toList(),
  };
}

class StorelistData {
  int? id;
  String shopName;
  String gstNo;
  String panNo;
  String tanno;
  String address;
  String appUserId;
  String userName;
  String categories;
  String otherCategories;
  String shopImage;
  String shoptime;
  String rating;

  StorelistData({
    this.id,
    this.shopName = '',
    this.gstNo = '',
    this.panNo = '',
    this.tanno = '',
    this.address = '',
    this.appUserId = '',
    this.userName = '',
    this.categories = '',
    this.otherCategories = '',
    this.shopImage = '',
    this.shoptime = '',
    this.rating = '',
  });

  factory StorelistData.fromJson(Map<String, dynamic> json) => StorelistData(
    id: json["id"],
    shopName: json["shop_name"] ?? '',
    gstNo: json["gst_no"] ?? '',
    panNo: json["pan_no"] ?? '',
    tanno: json["tanno"] ?? '',
    address: json["address"] ?? '',
    appUserId: json["app_user_id"]?.toString() ?? '',
    userName: json["user_name"] ?? '',
    categories: json["categories"] ?? '',
    otherCategories: json["other_categories"] ?? '',
    shopImage: json["shop_image"] ?? '',
    shoptime: json["shop_time"] ?? '',
    rating: json["rating"]?.toString() ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "shop_name": shopName,
    "gst_no": gstNo,
    "pan_no": panNo,
    "tanno": tanno,
    "address": address,
    "app_user_id": appUserId,
    "user_name": userName,
    "categories": categories,
    "other_categories": otherCategories,
    "shop_image": shopImage,
    "shop_time": shoptime,
    "rating": rating,
  };
}
