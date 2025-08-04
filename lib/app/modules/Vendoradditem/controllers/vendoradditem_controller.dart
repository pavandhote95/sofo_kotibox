import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../../../custom_widgets/api_url.dart';
import '../../../custom_widgets/auth_helper.dart';
import '../../../custom_widgets/snacbar.dart';
import '../../../services/ApiHelper.dart';
import '../../../services/api_service.dart';
import '../../Dashboard/views/dashboard_view.dart';

class VendoradditemController extends GetxController {
  // Controllers
  final itemNameController = TextEditingController();
  final itemDescController = TextEditingController();
  final itemPriceController = TextEditingController();
  final itemQtyController = TextEditingController();
  final brandController = TextEditingController();
  final sizeController = TextEditingController();
  var storage = GetStorage();

  // Focus nodes
  final itemNameFocus = FocusNode();
  final itemDescFocus = FocusNode();
  final itemPriceFocus = FocusNode();
  final itemQtyFocus = FocusNode();
  final brandFocus = FocusNode();
  final sizeFocus = FocusNode();

  var selectedCategoryId = RxnInt(); // Rx integer for selected shop ID
  RxBool isLoading = false.obs;
  RxBool isLoading1 = false.obs;
  Rx<File?> selectedImage = Rx<File?>(null);
  RxList<Map<String, dynamic>> shop = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    getCategoryName();
  }

  Future<void> getCategoryName() async {
    try {
      isLoading1(true);
      RestApi restApi = RestApi();
      var response = await restApi.getApi(getallstoreUrl);
      var responseJson = json.decode(response.body);

      if (response.statusCode == 200 && responseJson['success'] == true) {
        shop.value = List<Map<String, dynamic>>.from(responseJson['data']);
      } else if (response.statusCode == 401) {
        AuthHelper.handleUnauthorized();
      } else {
        Utils.showErrorSnackbar("Error", responseJson["message"] ?? "Something went wrong!");
      }
    } catch (e) {
      print('Shop Fetch Error: $e');
      Utils.showErrorSnackbar("Exception", "Failed to load shops");
    } finally {
      isLoading1(false);
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  // Validate all fields and return true if valid, false otherwise
  bool validateFields() {
    if (itemNameController.text.isEmpty) {
      Get.snackbar('Error', 'Item Name is required');
      return false;
    }
    if (itemDescController.text.isEmpty) {
      Get.snackbar('Error', 'Item Description is required');
      return false;
    }
    if (itemPriceController.text.isEmpty) {
      Get.snackbar('Error', 'Item Price is required');
      return false;
    }
    if (itemQtyController.text.isEmpty) {
      Get.snackbar('Error', 'Item Quantity is required');
      return false;
    }
    if (brandController.text.isEmpty) {
      Get.snackbar('Error', 'Brand is required');
      return false;
    }
    if (sizeController.text.isEmpty) {
      Get.snackbar('Error', 'Size is required');
      return false;
    }


    return true;
  }
  void addItem() async {
    isLoading(true);
   var id =  storage.read('userid');
        print("${additemUrl}${storage.read('userid')}");
    final result = await ApiHelper.postMultipart(
      url: additemUrl,

      fields: {
        // 'store_id': selectedCategoryId.value.toString(),
        'name': itemNameController.text.trim(),
        'price': itemPriceController.text.trim(),
        'about': itemDescController.text.trim(),
        'brand': brandController.text.trim(),
        'size': sizeController.text.trim(),
        'status': "1",
      },
      imageFile: selectedImage.value,
      imageKey: 'image',
    );

    isLoading(false);

    if (result['success']) {
      Get.snackbar('Success', result['message']);

      itemNameController.clear();
      itemDescController.clear();
      itemPriceController.clear();
      itemQtyController.clear();
      brandController.clear();
      sizeController.clear();
      selectedCategoryId.value = null;
      selectedImage.value = null;

      Get.to(() => DashboardView());

    } else {
      Get.snackbar('Error', result['message']);
    }
  }

  @override
  void onClose() {
    // Dispose controllers
    itemNameController.dispose();
    itemDescController.dispose();
    itemPriceController.dispose();
    itemQtyController.dispose();
    brandController.dispose();
    sizeController.dispose();
    // Dispose focus nodes
    itemNameFocus.dispose();
    itemDescFocus.dispose();
    itemPriceFocus.dispose();
    itemQtyFocus.dispose();
    brandFocus.dispose();
    sizeFocus.dispose();
    super.onClose();
  }
}