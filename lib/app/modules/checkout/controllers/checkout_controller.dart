import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:sofo/app/custom_widgets/snacbar.dart';
import 'package:sofo/app/modules/checkout/views/address_model.dart';
import 'package:sofo/app/modules/payment/views/order_success.dart';

class CheckoutController extends GetxController {
  final RxList<AddressModel> allAddresses = <AddressModel>[].obs;
  final isLoading = false.obs;
  final selectedAddressId = ''.obs;

  @override
  void onInit() {
    fetchAddresses();
    super.onInit();
  }

  /// ✅ Fetch all saved addresses
  Future<void> fetchAddresses() async {
    isLoading.value = true;
    final token = GetStorage().read("token");

    try {
      final response = await http.get(
        Uri.parse('https://kotiboxglobaltech.com/sofo_app/api/auth/addresses-list'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List list = data['data'];
        final addresses = list.map((e) => AddressModel.fromJson(e)).toList();
        allAddresses.value = List<AddressModel>.from(addresses);
      }
    } catch (e) {
      print("❌ Error fetching address list: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// ✅ Select Address
  void selectAddressById(String addressId) {
    selectedAddressId.value = addressId;
    print("📍 Selected Address ID: $addressId");
  }

  /// ✅ Place Order API
Future<bool> placeOrder({
  required List<int> productIds,
  required List<int> quantities,
  required String paymentMethod,
  required String deliveryType,
  required String selectedDate,
  required String selectedTime,
  required String selectPayment,
}) async {
  final token = GetStorage().read("token");

  if (selectedAddressId.isEmpty) {
    Utils.showToast("Please select an address before placing order.");
    return false;
  }

  isLoading.value = true;
  final url = Uri.parse("http://kotiboxglobaltech.com/sofo_app/api/storeiteams/checkout/");

  final body = {
    "storeiteam_ids": productIds,
    "quantities": quantities,
    "shipping_to": int.tryParse(selectedAddressId.value) ?? 1,
    "payment_method": paymentMethod,
    "delivery_type": deliveryType,
    "selected_date": selectedDate,
    "selected_time": selectedTime,
    "select_payment": selectPayment,
  };

  try {
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    print("📥 Checkout Response: ${response.statusCode} - ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      Get.to(() => OrderSuccessView());
      if (data["success"] == true) {
        Utils.showToast(data['message'] ?? "Order placed successfully!");
        return true; // ✅ ab bool return hoga
      } else {
        Utils.showToast(data['message'] ?? "Order failed");
        return false;
      }
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(msg: "Your order is already placed");
      return false;
    } else {
      Fluttertoast.showToast(msg: "Something went wrong! (${response.statusCode})");
      return false;
    }
  } catch (e) {
    Utils.showToast("❌ Error: $e");
    return false;
  } finally {
    isLoading.value = false;
  }
}

}