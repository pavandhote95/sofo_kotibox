import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sofo/app/custom_widgets/snacbar.dart';
import 'package:sofo/app/routes/app_pages.dart';
import 'package:sofo/app/services/api_service.dart';

class VendoradditemController extends GetxController {
  /// Text controllers
  final itemNameController = TextEditingController();
  final itemDescController = TextEditingController();
  final itemPriceController = TextEditingController();
  final itemQtyController = TextEditingController();
  final brandController = TextEditingController();
  final sizeController = TextEditingController();

  /// Focus nodes
  final itemNameFocus = FocusNode();
  final itemDescFocus = FocusNode();
  final itemPriceFocus = FocusNode();
  final itemQtyFocus = FocusNode();
  final brandFocus = FocusNode();
  final sizeFocus = FocusNode();

  /// Image Picker
  var selectedImage = Rxn<File>();

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  /// Shops Dropdown (Dynamic)
  var shops = <Map<String, dynamic>>[].obs;
  var isLoadingShops = false.obs;
  var selectedShopId = Rxn<int>();

  /// Add Item Loading
  var isLoading = false.obs;

  final RestApi _api = RestApi();
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchShops();
  }

  /// Fetch shops dynamically for logged-in user
Future<void> fetchShops() async {
  try {
    isLoadingShops.value = true;

    // ✅ userId correct key se lo
    final userId = storage.read("userId");
    print("👤 UserId from storage: $userId");

    if (userId == null) {
      Get.snackbar("Error", "User not logged in");
      return;
    }

    final url =
        "https://kotiboxglobaltech.com/sofo_app/api/storelistbyuser/$userId";

    print("🌍 Fetching shops from: $url");

    final response = await _api.getWithAuthApi(url);
    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data["success"] == true) {
      shops.assignAll(List<Map<String, dynamic>>.from(data["data"]));

      if (shops.isEmpty) {
        shops.assignAll([
          {"id": -1, "shop_name": "No shops available"}
        ]);
      }
    } else {
      Get.snackbar("Error", data["message"] ?? "Failed to fetch shops");
    }
  } catch (e) {
    Get.snackbar("Error", "Something went wrong: $e");
  } finally {
    isLoadingShops.value = false;
  }
}

  /// Validate input fields
  bool validateFields() {
    if (selectedImage.value == null) {
      Get.snackbar("Error", "Please upload an image");
      return false;
    }
    if (itemNameController.text.isEmpty ||
        itemDescController.text.isEmpty ||
        itemPriceController.text.isEmpty ||
        itemQtyController.text.isEmpty ||
        brandController.text.isEmpty ||
        sizeController.text.isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return false;
    }
    if (selectedShopId.value == null || selectedShopId.value == -1) {
      Get.snackbar("Error", "Please select a shop");
      return false;
    }
    return true;
  }

  /// Submit Add Item
Future<void> addItem() async {
  isLoading.value = true;

  try {
    final url = "https://kotiboxglobaltech.com/sofo_app/api/add-items";
    final fields = {
      "store_id": selectedShopId.value.toString(), // ✅ correct key
      "name": itemNameController.text,
      "about": itemDescController.text,            // ✅ changed from description -> about
      "price": itemPriceController.text,
      "quantity": itemQtyController.text,
      "brand": brandController.text,
      "size": sizeController.text,
      "status": "1",                               // ✅ static value from your payload
    };

    // 🔹 Print request details in terminal
    print("======== ADD ITEM REQUEST ========");
    print("API URL: $url");
    print("Fields: $fields");
    print("Selected Image: ${selectedImage.value?.path}");
    print("==================================");

    final response = await _api.postMultipartApiWithAuth(
      url,
      fields,
      fileKey: "image",
      file: selectedImage.value,
    );

    // 🔹 Print response details
    print("======== ADD ITEM RESPONSE ========");
    print("Status Code: ${response.statusCode}");
    print("Body: ${response.body}");
    print("==================================");

    final resData = jsonDecode(response.body);
    if (response.statusCode == 200 && resData["success"] == true) {
      Utils.showToast( "Item added successfully");
      clearForm();
      Get.toNamed(Routes.DASHBOARD);
    } else {
      Get.snackbar("Error", resData["message"] ?? "Failed to add item");
    }
  } catch (e) {
    print("======== ADD ITEM ERROR ========");
    print("Error: $e");
    print("================================");
    Utils.showErrorToast( "Something went wrong: $e");
  } finally {
    isLoading.value = false;
  }
}


  /// Clear form after success
  void clearForm() {
    itemNameController.clear();
    itemDescController.clear();
    itemPriceController.clear();
    itemQtyController.clear();
    brandController.clear();
    sizeController.clear();
    selectedImage.value = null;
    selectedShopId.value = null;
  }

  @override
  void onClose() {
    itemNameController.dispose();
    itemDescController.dispose();
    itemPriceController.dispose();
    itemQtyController.dispose();
    brandController.dispose();
    sizeController.dispose();
    super.onClose();
  }
}
