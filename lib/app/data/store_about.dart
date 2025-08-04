// To parse this JSON data, do
//
//     final storeAboutData = storeAboutDataFromJson(jsonString);

import 'dart:convert';

StoreAboutData storeAboutDataFromJson(String str) => StoreAboutData.fromJson(json.decode(str));

String storeAboutDataToJson(StoreAboutData data) => json.encode(data.toJson());

class StoreAboutData {
  bool? status;
  String? message;
  Data? data;

  StoreAboutData({
    this.status,
    this.message,
    this.data,
  });

  factory StoreAboutData.fromJson(Map<String, dynamic> json) => StoreAboutData(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  int? id;
  String? title;
  String? imageUrl;
  String? category;
  int? categoryId;
  String? location;
  String? contact;
  String? email;
  String? website;
  String? about;
  bool? delivery;
  double? rating;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.id,
    this.title,
    this.imageUrl,
    this.category,
    this.categoryId,
    this.location,
    this.contact,
    this.email,
    this.website,
    this.about,
    this.delivery,
    this.rating,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    title: json["title"],
    imageUrl: json["image_url"],
    category: json["category"],
    categoryId: json["category_id"],
    location: json["location"],
    contact: json["contact"],
    email: json["email"],
    website: json["website"],
    about: json["about"],
    delivery: json["delivery"],
    rating: json["rating"].toDouble(),
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image_url": imageUrl,
    "category": category,
    "category_id": categoryId,
    "location": location,
    "contact": contact,
    "email": email,
    "website": website,
    "about": about,
    "delivery": delivery,
    "rating": rating,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
