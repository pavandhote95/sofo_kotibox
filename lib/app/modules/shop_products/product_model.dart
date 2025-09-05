class ProductModel {
  final int id;
  final String name;
  final String? image;
  final String? price;
  final String? brand;
  final String? about;

  ProductModel({
    required this.id,
    required this.name,
    this.image,
    this.price,
    this.brand,
    this.about,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"] is int
          ? json["id"]
          : int.tryParse(json["id"].toString()) ?? 0,
      name: json["name"] ?? "",
      image: json["image"],
      price: json["price"]?.toString(),
      brand: json["brand"]?.toString(),
      about: json["about"]?.toString(),
    );
  }
}
