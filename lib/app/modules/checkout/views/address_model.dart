class AddressModel {
  final int id;
  final int userId;
  final String fullName;
  final String phone;
  final String houseNo;
  final String roadName;
  final String city;
  final String state;
  final String type;
  final int pincode;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  AddressModel({
    required this.id,
    required this.userId,
    required this.fullName,
    required this.phone,
    required this.houseNo,
    required this.roadName,
    required this.city,
    required this.state,
    required this.type,
    required this.pincode,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'],
      userId: json['user_id'],
      fullName: json['full_name'],
      phone: json['phone'],
      houseNo: json['house_no'],
      roadName: json['road_name'],
      city: json['city'],
      state: json['state'],
      type: json['type'],
      pincode: json['pincode'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      deletedAt: json['deleted_at'] != null ? DateTime.tryParse(json['deleted_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'full_name': fullName,
      'phone': phone,
      'house_no': houseNo,
      'road_name': roadName,
      'city': city,
      'state': state,
      'type': type,
      'pincode': pincode,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }
}
