import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sofo/app/modules/all_address_list/controllers/all_address_list_controller.dart';
import 'package:sofo/app/modules/checkout/controllers/checkout_controller.dart';

class EditAddressController extends GetxController {
  var isLoading = false.obs;

  Future<void> updateAddress(Map<String, String> data, BuildContext context) async {
    isLoading.value = true;

    final token = GetStorage().read("token");

    print("🔐 Token: $token");
    print("📦 Sending data to update-addresses API:");
    data.forEach((key, value) {
      print("➡️  $key: $value");
    });

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://kotiboxglobaltech.com/sofo_app/api/auth/update-addresses'),
      );

      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      request.fields.addAll(data);

      print("📤 Sending request...");
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print("📥 Response status: ${response.statusCode}");
      print("📥 Response body: ${response.body}");

      final resBody = jsonDecode(response.body);

      if (response.statusCode == 200 && resBody['status'] == true) {
        print("✅ Success: ${resBody['message']}");

        /// 🔄 Refresh address list
        if (!Get.isRegistered<AllAddressListController>()) {
          Get.put(AllAddressListController());
        }
        Get.find<CheckoutController>().fetchAddresses();

        Fluttertoast.showToast(msg: resBody['message'] ?? "Address updated");
        Navigator.pop(context);
      } else {
        print("❌ Error: ${resBody['message']}");
        Fluttertoast.showToast(msg: resBody['message'] ?? "Update failed");
      }
    } catch (e) {
      print("🚨 Exception occurred: $e");
      Fluttertoast.showToast(msg: "Error: $e");
    } finally {
      isLoading.value = false;
      print("🟢 Done updating address.");
    }
  }
}
