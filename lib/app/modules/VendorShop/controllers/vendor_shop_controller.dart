import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorShopController extends GetxController {
  final shopName = 'Aryan Electronics'.obs;
  final gstNumber = '27ABCDE1234F1Z5'.obs;
  final panNumber = 'ABCDE1234F'.obs;
  final tanNumber = 'BLRA12345E'.obs;
  final address = '123, MG Road, Jaipur, Rajasthan'.obs;
  final selectedCategories = ['Electronics', 'Accessories', 'Other'].obs;
  final otherCategoryDetail = 'Smart Home Gadgets'.obs;
}
