// store_item.dart
import 'dart:convert';

class shopitem {
  bool success;
  String store;
  List<shopitemData> items; // Renamed from storeItems to items for clarity

  shopitem({
    this.success = false,
    this.store = '',
    this.items = const [],
  });

  factory shopitem.fromJson(Map<String, dynamic> json) {
    return shopitem(
      success: json['success'] ?? false,
      store: json['store'] ?? '',
      items: (json['data'] as List<dynamic>?)
          ?.map((item) => shopitemData.fromJson(item as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }
}

class shopitemData {
  int? id;
  int? storeId;
  String? name;
  String? image;
  String? price;
  String? about;
  String? brand;
  String? size;
  String? status;
  String? createdAt;
  String? updatedAt;

  shopitemData({
    this.id,
    this.storeId,
    this.name,
    this.image,
    this.price,
    this.about,
    this.brand,
    this.size,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory shopitemData.fromJson(Map<String, dynamic> json) {
    return shopitemData(
      id: json['id'] as int?,
      storeId: json['store_id'] as int?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      price: json['price'] as String?,
      about: json['about'] as String?,
      brand: json['brand'] as String?,
      size: json['size'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}

shopitem storeItemFromJson(String str) => shopitem.fromJson(json.decode(str));