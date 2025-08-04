import 'dart:convert';

// Top-level parsing
StoreCategoryResponse storeCategoryFromJson(String str) => StoreCategoryResponse.fromJson(json.decode(str));
String storeCategoryToJson(StoreCategoryResponse data) => json.encode(data.toJson());

// Response wrapper
class StoreCategoryResponse {
  bool? status;
  List<StoreCategory>? data;

  StoreCategoryResponse({
    this.status,
    this.data,
  });

  factory StoreCategoryResponse.fromJson(Map<String, dynamic> json) => StoreCategoryResponse(
    status: json["status"],
    data: json["data"] == null
        ? []
        : List<StoreCategory>.from(json["data"].map((x) => StoreCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

// Store category model
class StoreCategory {
  int? id;
  String? name;
  String? status;
  String? image;

  StoreCategory({
    this.id,
    this.name,
    this.status,
    this.image,
  });

  factory StoreCategory.fromJson(Map<String, dynamic> json) => StoreCategory(
    id: json["id"],
    name: json["name"],
    status: json["status"]?.toString(), // cast int to string if needed
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": status,
    "image": image,
  };
}
