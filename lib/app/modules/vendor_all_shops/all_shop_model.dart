class ShopModel {
  final int id;
  final String shopName;
  final String gstNo;
  final String shopTime;
  final String rating;
  final String panNo;
  final String tanno;
  final String address;
  final String userName;
  final String categories;
  final String? otherCategories;
  final String? email;
  final String? contact;
  final String? website;
  final String? about;
  final String? delivery;
  final String shopImage;

  ShopModel({
    required this.id,
    required this.shopName,
    required this.gstNo,
    required this.shopTime,
    required this.rating,
    required this.panNo,
    required this.tanno,
    required this.address,
    required this.userName,
    required this.categories,
    this.otherCategories,
    this.email,
    this.contact,
    this.website,
    this.about,
    this.delivery,
    required this.shopImage,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(
      id: json['id'] ?? 0,
      shopName: json['shop_name'] ?? '',
      gstNo: json['gst_no'] ?? '',
      shopTime: json['shop_time'] ?? '',
      rating: json['rating'] ?? '',
      panNo: json['pan_no'] ?? '',
      tanno: json['tanno'] ?? '',
      address: json['address'] ?? '',
      userName: json['user_name'] ?? '',
      categories: json['categories'] ?? '',
      otherCategories: json['other_categories'],
      email: json['email'],
      contact: json['contact'],
      website: json['website'],
      about: json['about'],
      delivery: json['delivery'],
      shopImage: json['shop_image'] ?? '',
    );
  }
}
