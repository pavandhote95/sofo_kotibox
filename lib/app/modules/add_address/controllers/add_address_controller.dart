import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:sofo/app/services/api_service.dart';

class AddAddressController extends GetxController {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final pincodeController = TextEditingController();
  final houseController = TextEditingController();
  final areaController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();

  RxString selectedType = 'Home'.obs;

  final restApi = RestApi(); // <-- added restApi instance

  void selectType(String type) {
    selectedType.value = type;
  }

Future<void> saveAddress() async {
  const url = 'https://kotiboxglobaltech.com/sofo_app/api/auth/add-addresses';

  final token = restApi.storage.read("token");

  try {
    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    request.fields.addAll({
      'type': selectedType.value,
      'phone': phoneController.text.trim(),
      'full_name': nameController.text.trim(),
      'road_name': areaController.text.trim(),
      'house_no': houseController.text.trim(),
      'city': cityController.text.trim(),
      'state': stateController.text.trim(),
      'pincode': pincodeController.text.trim(),
    });

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    // ✅ PRINT RESPONSE FOR DEBUGGING
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    final responseData = jsonDecode(response.body);

    if (response.statusCode == 200 && responseData['status'] == true) {
      Get.snackbar("Success", "Address added successfully",
          snackPosition: SnackPosition.BOTTOM);
      Get.back();
    } else {
      Get.snackbar("Error", responseData['message'] ?? "Something went wrong",
          snackPosition: SnackPosition.BOTTOM);
    }
  } catch (e) {
    print('Error occurred: $e');
    Get.snackbar("Error", "Failed to add address: $e",
        snackPosition: SnackPosition.BOTTOM);
  }
}

}
