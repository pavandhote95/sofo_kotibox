// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str)['data']);

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  int? id;
  String? name;
  String? email;
  String? mobile;
  bool? isVerified;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProfileModel({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.isVerified,
    this.createdAt,
    this.updatedAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    mobile: json["mobile"],
    isVerified: json["is_verified"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "mobile": mobile,
    "is_verified": isVerified,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
