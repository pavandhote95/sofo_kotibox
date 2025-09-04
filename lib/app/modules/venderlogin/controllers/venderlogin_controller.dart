  import 'dart:convert';
  import 'dart:io';
  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:get_storage/get_storage.dart';
  import 'package:image_picker/image_picker.dart';
  import 'package:http/http.dart' as http;
import 'package:sofo/app/modules/vendor_registration_success/views/vendor_registration_success_view.dart';
  import '../../../custom_widgets/api_url.dart';
  import '../../../custom_widgets/auth_helper.dart';
  import '../../../custom_widgets/snacbar.dart';
  import '../../../services/api_service.dart';

  class VendorRegisterController extends GetxController {
    final shopNameController = TextEditingController();
    final gstController = TextEditingController();
    final panController = TextEditingController();
    final tanController = TextEditingController();
    final addressController = TextEditingController();
    final otherCategoryController = TextEditingController();

    final shopNameFocus = FocusNode();
    final gstFocus = FocusNode();
    final panFocus = FocusNode();
    final tanFocus = FocusNode();
    final addressFocus = FocusNode();
    final otherCategoryFocus = FocusNode();
    final shopTimingController = TextEditingController();
    final shopRatingController = TextEditingController();

    final shopTimingFocus = FocusNode();
    final shopRatingFocus = FocusNode();

    var isLoading = false.obs;

    // Store fetched categories from API
    RxList<Map<String, dynamic>> categories = <Map<String, dynamic>>[].obs;

    // Store single selected category ID
    var selectedCategoryName = RxnString(); // To track the name for "Other" check
    var selectedCategoryId = RxnInt(); // ✅ Rx integer that can be null

    final ImagePicker _picker = ImagePicker();
    var selectedImage = Rxn<File>(); // Rx File to observe image changes

    @override
    void onClose() {
      shopNameController.dispose();
      gstController.dispose();
      panController.dispose();
      tanController.dispose();
      addressController.dispose();
      otherCategoryController.dispose();
      shopNameFocus.dispose();
      gstFocus.dispose();
      panFocus.dispose();
      tanFocus.dispose();
      addressFocus.dispose();
      otherCategoryFocus.dispose();
      shopTimingController.dispose();
      shopRatingController.dispose();
      shopTimingFocus.dispose();
      shopRatingFocus.dispose();

      super.onClose();
    }

    @override
    void onInit() {
      super.onInit();
      getCategoryName();
    }

    Future<void> getCategoryName() async {
      try {
        isLoading(true);
        RestApi restApi = RestApi();
        var response = await restApi.getApi(getCategoryNameUrl);
        var responseJson = json.decode(response.body);

        if (response.statusCode == 200 && responseJson['status'] == true) {
          categories.value = List<Map<String, dynamic>>.from(responseJson['data']);
        } else if (response.statusCode == 401) {
          AuthHelper.handleUnauthorized();
        } else {
          Utils.showErrorSnackbar("Error", responseJson["message"] ?? "Something went wrong!");
        }
      } catch (e) {
        print('Category Fetch Error: $e');
        Utils.showErrorSnackbar("Exception", "Failed to load category");
      } finally {
        isLoading(false);
      }
    }

    Future<void> pickShopImage() async {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        selectedImage.value = File(image.path);
      }
    }

    // Set single category
    void setCategory(int id, String name) {
      selectedCategoryId.value = id;
      selectedCategoryName.value = name;
      if (name != 'Other') {
        otherCategoryController.clear();
      }
    }


    // Clear selected category
    void clearCategory() {
      selectedCategoryId.value = null;
      selectedCategoryName.value = null;
      otherCategoryController.clear();
    }

    void vendorRegister() async {
      try {
        isLoading(true);


        if (selectedImage.value != null) {
          print("🖼️ Selected Image Path: ${selectedImage.value!.path}");
        } else {
          print("⚠️ No image selected");
        }

        final token = GetStorage().read('token');
        print("🔐 Token: $token");

        final uri = Uri.parse(postvendorLoginUrl);
        final request = http.MultipartRequest('POST', uri);

        request.headers['Authorization'] = 'Bearer $token';
        request.headers['Accept'] = 'application/json';

        // Add basic fields
        request.fields['shop_name'] = shopNameController.text.trim();
        request.fields['gst_no'] = gstController.text.trim();
        request.fields['pan_no'] = panController.text.trim();
        request.fields['tanno'] = tanController.text.trim();
        request.fields['address'] = addressController.text.trim();
        request.fields['categories'] = selectedCategoryId.value.toString(); // ✅ only 1 ID
        request.fields['shop_time'] = shopTimingController.text.trim();
        request.fields['rating'] = shopRatingController.text.trim();


        // Add other category if needed
        request.fields['other_category'] = selectedCategoryName.value == 'Other'
            ? otherCategoryController.text.trim()
            : '';

        // Add image if selected
        if (selectedImage.value != null) {
          request.files.add(await http.MultipartFile.fromPath(
            'shop_image',
            selectedImage.value!.path,
          ));
        }

        // Send request and handle response
        final response = await request.send();
        final respStr = await response.stream.bytesToString();
        final decoded = json.decode(respStr);

        if (response.statusCode == 201) {
          Get.snackbar('Success', decoded['message'] ?? 'Vendor registered successfully');

          Get.to(() => VendorRegistrationSuccessView());

      } else {
          Get.snackbar('Error', decoded['message'] ?? 'Something went wrong');
        }
      } catch (e) {
        Get.snackbar('Error', 'Failed to register vendor: $e');
        print("🔥 Error details: $e");
      } finally {
        isLoading(false);
      }
    }
  }