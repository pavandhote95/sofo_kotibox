import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str)['data']);

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  int? id;
  String? name;
  String? email;
  String? mobile;
  bool? isVerified;
  String? profileImageUrl;
  String? becomeVendor;
  String? vendorStatus;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProfileModel({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.isVerified,
    this.profileImageUrl,
    this.becomeVendor,
    this.vendorStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        isVerified: json["is_verified"],
        profileImageUrl: json["profile_image_url"],
        becomeVendor: json["become_vendor"],
        vendorStatus: json["vendor_status"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "mobile": mobile,
        "is_verified": isVerified,
        "profile_image_url": profileImageUrl,
        "become_vendor": becomeVendor,
        "vendor_status": vendorStatus,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
